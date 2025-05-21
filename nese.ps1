Clear-Host
Write-Host ""
Write-Host ""
Write-Host -Fore Red 
"
                                                                                                                     
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
                                                                                                                                                                                        
"
Write-Host -Fore Red "          Eren Perakende Red Team" 
Write-Host -Fore Gray "          https://github.com/dheenaxe/ErenRedTeam"
Write-Host ""
Write-Host ""


# Ensure Administrator privileges
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "Run this script as Administrator."
    exit
}

Write-Output "🔧 Applying audit policy settings for security-critical Event IDs..."

# Subcategories supported by your system (from auditpol /get /category:*)
$ValidAuditSubcategories = @(
    # System
    "Security System Extension",
    "System Integrity",
    "IPsec Driver",
    "Other System Events",
    "Security State Change",

    # Logon/Logoff
    "Logon",
    "Logoff",
    "Account Lockout",
    "Special Logon",
    "Other Logon/Logoff Events",
    "Network Policy Server",

    # Object Access
    "File System",
    "File Share",
    "Detailed File Share",
    "Removable Storage",

    # Privilege Use
    "Sensitive Privilege Use",

    # Detailed Tracking
    "Process Creation",
    "Process Termination",
    "DPAPI Activity",

    # Policy Change
    "Audit Policy Change",
    "Authentication Policy Change",

    # Account Management
    "Computer Account Management",
    "Security Group Management",
    "Other Account Management Events",
    "User Account Management",

    # DS Access
    "Directory Service Access",

    # Account Logon
    "Kerberos Service Ticket Operations",
    "Kerberos Authentication Service",
    "Credential Validation"
)

foreach ($subcategory in $ValidAuditSubcategories) {
    try {
        $result = auditpol /set /subcategory:"$subcategory" /success:enable /failure:enable 2>&1
        if ($LASTEXITCODE -eq 0) {
            Write-Host "✅ Enabled auditing for: $subcategory" -ForegroundColor Green
        } else {
            Write-Host "⚠️  Failed to set auditing for: $subcategory" -ForegroundColor Yellow
            Write-Host "    ↳ Details: $result"
        }
    } catch {
        Write-Host "❌ Exception occurred while setting: $subcategory" -ForegroundColor Red
        Write-Host "    ↳ $_"
    }
}

Write-Output "`n🛡️ Enabling PowerShell ScriptBlock and Module Logging..."

# Script Block Logging
try {
    New-Item -Path HKLM:\Software\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging -Force | Out-Null
    Set-ItemProperty -Path HKLM:\Software\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging -Name "EnableScriptBlockLogging" -Value 1
    Write-Host "✅ ScriptBlockLogging enabled." -ForegroundColor Green
} catch {
    Write-Host "❌ Failed to enable ScriptBlockLogging: $_" -ForegroundColor Red
}

# Module Logging
try {
    New-Item -Path HKLM:\Software\Policies\Microsoft\Windows\PowerShell\ModuleLogging -Force | Out-Null
    Set-ItemProperty -Path HKLM:\Software\Policies\Microsoft\Windows\PowerShell\ModuleLogging -Name "EnableModuleLogging" -Value 1
    New-Item -Path HKLM:\Software\Policies\Microsoft\Windows\PowerShell\ModuleLogging\ModuleNames -Force | Out-Null
    Set-ItemProperty -Path HKLM:\Software\Policies\Microsoft\Windows\PowerShell\ModuleLogging\ModuleNames -Name "*" -Value "*"
    Write-Host "✅ ModuleLogging enabled for all modules." -ForegroundColor Green
} catch {
    Write-Host "❌ Failed to enable ModuleLogging: $_" -ForegroundColor Red
}

Write-Output "`n🎉 Audit policies and PowerShell logging successfully configured."
