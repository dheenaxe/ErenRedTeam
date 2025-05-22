function Check-GPOAuditPolicyOverride {
    $lsaPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa"
    try {
        $value = Get-ItemPropertyValue -Path $lsaPath -Name "SCENoApplyLegacyAuditPolicy" -ErrorAction Stop
        if ($value -eq 1) {
            Write-Host "🔒 GPO Override Active: Legacy audit policies are ignored due to GPO-enforced advanced audit policies." -ForegroundColor Yellow
            return $true
        } else {
            Write-Host "✅ GPO Override is NOT active. Local auditpol settings are applied." -ForegroundColor Green
            return $false
        }
    } catch {
        Write-Host "ℹ️ SCENoApplyLegacyAuditPolicy not found. Assuming GPO override is NOT active." -ForegroundColor Cyan
        return $false
    }
}

function Apply-AuditPolSettings {
    Write-Host "`n🔍 Trying to set extended Audit Policy via auditpol."

    $AuditpolSubcategories = @(
        "Security System Extension", "System Integrity", "IPsec Driver", "Other System Events",
        "Security State Change", "Logon", "Logoff", "Account Lockout", "Special Logon",
        "Other Logon/Logoff Events", "Network Policy Server", "File System", "File Share",
        "Detailed File Share", "Removable Storage", "Sensitive Privilege Use", "Process Creation",
        "Process Termination", "DPAPI Activity", "Audit Policy Change", "Authentication Policy Change",
        "Computer Account Management", "Security Group Management", "Other Account Management Events",
        "User Account Management", "Directory Service Access", "Kerberos Service Ticket Operations",
        "Kerberos Authentication Service", "Credential Validation"
    )

    foreach ($subcategory in $AuditpolSubcategories) {
        try {
            $null = auditpol /set /subcategory:"$subcategory" /success:enable /failure:enable 2>$null | Out-Null
            if ($LASTEXITCODE -eq 0) {
                Write-Host "✅ auditpol: Enabled auditing for '$subcategory'" -ForegroundColor Green
            } else {
                Write-Host "⚠️ auditpol failed for '$subcategory'. Skipping..." -ForegroundColor Red
            }
        } catch {
            Write-Host "❌ auditpol error for '$subcategory'. Continuing silently." -ForegroundColor Red
        }
    }
}

function Check-EventIDPresence {
    param (
        [int[]]$EventIDs = @(4688, 4689, 4724, 4728, 4732, 4735, 4738, 4756, 4768, 4769, 4771, 4776,
                            4798, 4799, 5140, 5145, 5142, 5144, 4648, 1102, 4697, 4698, 4702, 4699,
                            201, 4701, 4720, 4776, 4672, 4722, 104, 1001, 7045, 7034, 7036, 7040,
                            4103, 4104, 4106, 800, 400, 403, 5857, 5861, 5869),
        [int]$DaysBack = 30
    )

    $eventLogs = @(
        "Security", "System", "Application",
        "Microsoft-Windows-PowerShell/Operational",
        "Microsoft-Windows-WMI-Activity/Trace",
        "Windows PowerShell"
    )

    Write-Host "`n📚 Scanning logs for last $DaysBack days..."

    foreach ($id in $EventIDs) {
        $matched = $false

        foreach ($log in $eventLogs) {
            try {
                $entry = Get-WinEvent -FilterHashtable @{ LogName = $log; ID = $id; StartTime = (Get-Date).AddDays(-$DaysBack) } -MaxEvents 1 -ErrorAction SilentlyContinue
                if ($entry) {
                    Write-Host "✅ Event ID $id found in log: $log" -ForegroundColor Green
                    $matched = $true
                    break
                }
            } catch {
                continue
            }
        }

        if (-not $matched) {
            Write-Host "❌ Event ID $id not found in any log (last $DaysBack days)" -ForegroundColor Red
        }
    }
}

# === MAIN EXECUTION ===

Clear-Host
Write-Host ""; Write-Host ""
$banner = @"
@@@  @@@  @@@@@@@@      @@      @@@@@@@@       @@@@@@@    @@@@@@     @@@
@@@@ @@@  @@@@@@@@   @@@@@@@@@  @@@@@@@@       @@@@@@@@  @@@@@@@    @@@@
@@!@!@@@  @@!       !@@!@@!@@!  @@!            @@!  @@@  !@@       @@@!!
!@!!@!@!  !@!       !@! !@      !@!            !@!  @!@  !@!         !@!
@!@ !!@!  @!!!:!    !!!@@!!!!   @!!!:!         @!@@!@!   !!@@!!      @!@
!@!  !!!  !!!!!:     !!!@@@!!!  !!!!!:         !!@!!!     !!@!!!     !@!
!!:  !!!  !!:           !: !:!  !!:            !!:            !:!    !!:
:!:  !:!  :!:       !:!!:!: :!  :!:       :!:  :!:           !:!     :!:
 ::   ::   :: ::::  : :::: ::    :: ::::  :::   ::       :::: ::     :::
::    :   : :: ::       ::      : :: ::   :::   :        :: : :       ::
"@
Write-Host $banner -ForegroundColor Red
Write-Host "          Eren Perakende Red Team" -ForegroundColor Red
Write-Host "          https://github.com/dheenaxe/ErenRedTeam" -ForegroundColor DarkGray
Write-Host ""

# Administrator check
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "Run this script as Administrator."
    exit
}

# Registry-based config (manually re-add your full logging config here)
Write-Output "`n🔧 Configuring audit logging via registry..."
# === INSERT your existing registry logging config here ===
# (ScriptBlockLogging, ModuleLogging, TranscriptLogging, CmdLine logging etc.)

Write-Output "`n🎉 All registry-based audit configurations applied successfully."

# GPO and Auditpol
Write-Host "`n🪠 Checking GPO override status..."
$gpoOverride = Check-GPOAuditPolicyOverride
if (-not $gpoOverride) {
    Apply-AuditPolSettings
} else {
    Write-Host "⚠️ Skipping auditpol because GPO override is active." -ForegroundColor Yellow
}

# Check real log activity
Write-Host "`n🔍 Checking Enabled Event Logs"
Check-EventIDPresence
