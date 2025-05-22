function Check-GPOAuditPolicyOverride {
    $lsaPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa"
    $value = Get-ItemPropertyValue -Path $lsaPath -Name "SCENoApplyLegacyAuditPolicy" -ErrorAction SilentlyContinue

    if ($value -eq 1) {
        Write-Host "🔒 GPO Override Active: Legacy audit policies are ignored due to GPO-enforced advanced audit policies." -ForegroundColor Yellow
        return $true
    } elseif ($value -eq 0) {
        Write-Host "✅ GPO Override is NOT active. Local auditpol settings are applied." -ForegroundColor Green
        return $false
    } else {
        Write-Host "⚠️ Could not determine SCENoApplyLegacyAuditPolicy. Registry value missing or inaccessible." -ForegroundColor Red
        return $null
    }
}

function Apply-AuditPolSettings {
    Write-Host "`n🔍 Trying to set extended Audit Policy via auditpol."

    $AuditpolSubcategories = @(
        "Security System Extension",
        "System Integrity",
        "IPsec Driver",
        "Other System Events",
        "Security State Change",
        "Logon",
        "Logoff",
        "Account Lockout",
        "Special Logon",
        "Other Logon/Logoff Events",
        "Network Policy Server",
        "File System",
        "File Share",
        "Detailed File Share",
        "Removable Storage",
        "Sensitive Privilege Use",
        "Process Creation",
        "Process Termination",
        "DPAPI Activity",
        "Audit Policy Change",
        "Authentication Policy Change",
        "Computer Account Management",
        "Security Group Management",
        "Other Account Management Events",
        "User Account Management",
        "Directory Service Access",
        "Kerberos Service Ticket Operations",
        "Kerberos Authentication Service",
        "Credential Validation"
    )

    foreach ($subcategory in $AuditpolSubcategories) {
        try {
            $null = auditpol /set /subcategory:"$subcategory" /success:enable /failure:enable 2>$null
            if ($LASTEXITCODE -eq 0) {
                Write-Host "✅ auditpol: Enabled auditing for '$subcategory'" -ForegroundColor DarkGreen
            } else {
                Write-Host "⚠️  auditpol failed for '$subcategory'. Skipping..." -ForegroundColor Red
            }
        } catch {
            Write-Host "❌ auditpol error for '$subcategory'. Continuing silently." -ForegroundColor Red
        }
    }
}

function Check-EventIDStatus {
    $EventIDSources = @{
        4688 = "Security"
        4689 = "Security"
        4724 = "Security"
        4728 = "Security"
        4732 = "Security"
        4735 = "Security"
        4738 = "Security"
        4756 = "Security"
        4768 = "Security"
        4769 = "Security"
        4771 = "Security"
        4776 = "Security"
        4798 = "Security"
        4799 = "Security"
        5140 = "Security"
        5145 = "Security"
        5142 = "Security"
        5144 = "Security"
        4648 = "Security"
        1102 = "Security"
        4697 = "Security"
        4698 = "Security"
        4702 = "Security"
        4699 = "Security"
        201  = "Security"
        4701 = "Security"
        4720 = "Security"
        4672 = "Security"
        4722 = "Security"
        104  = "System"
        1001 = "Application"
        7045 = "System"
        7034 = "System"
        7036 = "System"
        7040 = "System"
        4103 = "Microsoft-Windows-PowerShell/Operational"
        4104 = "Microsoft-Windows-PowerShell/Operational"
        4106 = "Microsoft-Windows-PowerShell/Operational"
        800  = "Windows PowerShell"
        400  = "Windows PowerShell"
        403  = "Windows PowerShell"
        5857 = "Microsoft-Windows-WMI-Activity/Trace"
        5861 = "Microsoft-Windows-WMI-Activity/Trace"
        5869 = "Microsoft-Windows-WMI-Activity/Trace"
    }

    $PowerShellRegPath = "HKLM:\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\PowerShell"
    $WmiRegPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WINEVT\Channels"

    foreach ($eventID in $EventIDSources.Keys) {
        $source = $EventIDSources[$eventID]

        # SECURITY LOG EVENTS
        if ($source -eq "Security") {
            $auditpolOutput = & auditpol /get /category:* 2>$null
            if ($auditpolOutput -match "$eventID") {
                Write-Host "✅ Event ID $eventID ($source): Auditpol policy exists" -ForegroundColor Green
            } elseif ($auditpolOutput) {
                Write-Host "❌ Event ID $eventID ($source): Not enabled (via auditpol)" -ForegroundColor Red
            } else {
                Write-Host "⚠️  Event ID $eventID ($source): Could not verify auditpol (maybe GPO override)" -ForegroundColor Yellow
            }

        # OPERATIONAL OR SYSTEM LOGS
        } elseif ($source -like "*/*" -or $source -eq "System" -or $source -eq "Application") {
            try {
                $escapedSource = "`"$source`""
                $logStatus = & wevtutil get-log $escapedSource 2>$null
                if ($logStatus -match "enabled\s*:\s*true") {
                    Write-Host "✅ Event ID $eventID ($source): Enabled (log channel active)" -ForegroundColor Green
                } else {
                    Write-Host "❌ Event ID $eventID ($source): Log channel disabled" -ForegroundColor Red
                }
            } catch {
                Write-Host "⚠️  Event ID $eventID ($source): Could not verify (log not found or access denied)" -ForegroundColor Yellow
            }

        # REGISTRY-BASED VERIFICATION (PowerShell or WMI)
        } elseif ($source -like "Windows PowerShell") {
            $enabled = Get-ItemPropertyValue -Path "$PowerShellRegPath\ModuleLogging" -Name "EnableModuleLogging" -ErrorAction SilentlyContinue
            if ($enabled -eq 1) {
                Write-Host "✅ Event ID $eventID ($source): Module logging enabled (registry)" -ForegroundColor Green
            } else {
                Write-Host "❌ Event ID $eventID ($source): Module logging NOT enabled" -ForegroundColor Red
            }

        } elseif ($source -like "Microsoft-Windows-WMI-Activity/Trace") {
            $regPath = "$WmiRegPath\$source"
            $enabled = Get-ItemPropertyValue -Path $regPath -Name "Enabled" -ErrorAction SilentlyContinue
            if ($enabled -eq 1) {
                Write-Host "✅ Event ID $eventID ($source): WMI trace enabled" -ForegroundColor Green
            } else {
                Write-Host "❌ Event ID $eventID ($source): WMI trace NOT enabled" -ForegroundColor Red
            }
        }
    }
}


Clear-Host
Write-Host ""
Write-Host ""

# ASCII BANNER
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

# Yönetici kontrolü
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "Run this script as Administrator."
    exit
}

Write-Output "`n🔧 Configuring audit logging via registry..."

# === Process Command Line Logging ===
try {
    $auditPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\Audit"
    if (!(Test-Path $auditPath)) {
        New-Item -Path $auditPath -Force | Out-Null
    }
    Set-ItemProperty -Path $auditPath -Name "ProcessCreationIncludeCmdLine_Enabled" -Value 1 -Type DWord
    Write-Host "✅ Process Creation Command Line logging enabled (4688)." -ForegroundColor Green
} catch {
    Write-Host "❌ Failed to set ProcessCreationIncludeCmdLine_Enabled: $_" -ForegroundColor Red
}

# === PowerShell ScriptBlock Logging ===
try {
    $sbPath = "HKLM:\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging"
    if (!(Test-Path $sbPath)) {
        New-Item -Path $sbPath -Force | Out-Null
    }
    Set-ItemProperty -Path $sbPath -Name "EnableScriptBlockLogging" -Value 1 -Type DWord
    Set-ItemProperty -Path $sbPath -Name "EnableScriptBlockInvocationLogging" -Value 1 -Type DWord
    Write-Host "✅ PowerShell Script Block Logging enabled." -ForegroundColor Green
} catch {
    Write-Host "❌ Failed to enable ScriptBlockLogging: $_" -ForegroundColor Red
}

# === PowerShell Module Logging ===
try {
    $modPath = "HKLM:\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\PowerShell\ModuleLogging"
    if (!(Test-Path $modPath)) {
        New-Item -Path $modPath -Force | Out-Null
    }
    Set-ItemProperty -Path $modPath -Name "EnableModuleLogging" -Value 1 -Type DWord

    $modNamesPath = "$modPath\ModuleNames"
    if (!(Test-Path $modNamesPath)) {
        New-Item -Path $modNamesPath -Force | Out-Null
    }
    New-ItemProperty -Path $modNamesPath -Name "*" -Value "*" -Force | Out-Null
    Write-Host "✅ PowerShell Module Logging enabled for all modules." -ForegroundColor Green
} catch {
    Write-Host "❌ Failed to enable Module Logging: $_" -ForegroundColor Red
}

# === PowerShell Transcription Logging ===
try {
    $transPath = "HKLM:\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\PowerShell\Transcription"
    $logDir = "C:\pstransactions\"
    if (!(Test-Path $transPath)) {
        New-Item -Path $transPath -Force | Out-Null
    }
    Set-ItemProperty -Path $transPath -Name "EnableTranscripting" -Value 1 -Type DWord
    Set-ItemProperty -Path $transPath -Name "EnableInvocationHeader" -Value 1 -Type DWord
    Set-ItemProperty -Path $transPath -Name "OutputDirectory" -Value $logDir

    if (!(Test-Path $logDir)) {
        New-Item -Path $logDir -ItemType Directory -Force | Out-Null
    }
    Write-Host "✅ PowerShell Transcript Logging enabled to: $logDir" -ForegroundColor Green
} catch {
    Write-Host "❌ Failed to enable Transcription Logging: $_" -ForegroundColor Red
}

Write-Output "`n🎉 All registry-based audit configurations applied successfully."

Write-Host "`n🧪 Checking GPO override status..."

$gpoOverride = Check-GPOAuditPolicyOverride
if ($gpoOverride -eq $false) {
    Apply-AuditPolSettings
} else {
    Write-Host "⚠️ Skipping auditpol because GPO override is active." -ForegroundColor Yellow
}


Write-Host "`n🔍 Checking Enabled Event Logs"
Check-EventIDStatus