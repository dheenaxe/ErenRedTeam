New-Item -Path "C:\eren" -ItemType Directory -Force

Get-ChildItem "C:\eren"

# $path_cyber = "C:\ProgramData\Microsoft\Windows Defender Advanced Threat Protection\Cyber.7z"  
# $path_7z = "C:\ProgramData\Microsoft\Windows Defender Advanced Threat Protection\7zr.exe" 

# Copy-Item $path_cyber -Destination "C:\eren\Cyber.7z" -Force
# Copy-Item $path_7z  -Destination "C:\eren\7zr.exe" -Force

Start-Process "http://10.12.2.88/cyberpipe/7zr.exe" -ArgumentList "x", "http://10.12.2.88/cyberpipe/Cyber.7z", "-oC:\eren\", "-y" -Wait
 
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned
 
Unblock-File -Path "C:\eren\Cyber\CyberPipeEren.ps1"

powershell -ep bypass C:\eren\Cyber\CyberPipeEren.ps1