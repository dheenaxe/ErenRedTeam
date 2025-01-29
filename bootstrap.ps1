New-Item -Path "C:\eren" -ItemType Directory -Force

Get-ChildItem "C:\eren"

Invoke-WebRequest "https://github.com/dheenaxe/ErenRedTeam/raw/refs/heads/main/Cyber.7z" -OutFile "C:\eren\Cyber.7z"

Invoke-WebRequest "https://github.com/dheenaxe/ErenRedTeam/raw/refs/heads/main/7zr.exe" -OutFile "C:\eren\7zr.exe"

Start-Process "C:\eren\7zr.exe" -ArgumentList "x", "C:\eren\Cyber.7z", "-oC:\eren\", "-y" -Wait
 
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned
 
Unblock-File -Path "C:\eren\Cyber\CyberPipeEren.ps1"

powershell -ep bypass C:\eren\Cyber\CyberPipeEren.ps1
