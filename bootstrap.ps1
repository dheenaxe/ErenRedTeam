New-Item -Path "C:\eren" -ItemType Directory -Force

Get-ChildItem "C:\eren"

Start-Process "https://github.com/dheenaxe/ErenRedTeam/raw/refs/heads/main/7zr.exe" -ArgumentList "x", "http://10.12.2.88/cyberpipe/Cyber.7z", "-oC:\eren\", "-y" -Wait
 
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned
 
Unblock-File -Path "C:\eren\Cyber\CyberPipeEren.ps1"

powershell -ep bypass C:\eren\Cyber\CyberPipeEren.ps1
