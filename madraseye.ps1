function Show-Menu {
    Write-Host "Select an option:" -ForegroundColor Cyan
    Write-Host "0: Remove all custom Firewall rules"
    Write-Host "1: Add all custom Firewall IP rules"
    Write-Host "2: Add all custom Firewall FQDN rules"
    Write-Host "Çıkmak için CTRL + C"
}

while ($true) {
    
    Clear-Host
    Write-Host ""
    Write-Host ""
    Write-Host -Fore Red 
    "

                                   █████                                                                               ████ 
                                  ░░███                                                                               ░░███ 
     █████████████    ██████    ███████  ████████   ██████    █████   ██████  █████ ████  ██████     ████████   █████  ░███ 
    ░░███░░███░░███  ░░░░░███  ███░░███ ░░███░░███ ░░░░░███  ███░░   ███░░███░░███ ░███  ███░░███   ░░███░░███ ███░░   ░███ 
     ░███ ░███ ░███   ███████ ░███ ░███  ░███ ░░░   ███████ ░░█████ ░███████  ░███ ░███ ░███████     ░███ ░███░░█████  ░███ 
     ░███ ░███ ░███  ███░░███ ░███ ░███  ░███      ███░░███  ░░░░███░███░░░   ░███ ░███ ░███░░░      ░███ ░███ ░░░░███ ░███ 
     █████░███ █████░░████████░░████████ █████    ░░████████ ██████ ░░██████  ░░███████ ░░██████  ██ ░███████  ██████  █████
    ░░░░░ ░░░ ░░░░░  ░░░░░░░░  ░░░░░░░░ ░░░░░      ░░░░░░░░ ░░░░░░   ░░░░░░    ░░░░░███  ░░░░░░  ░░  ░███░░░  ░░░░░░  ░░░░░ 
                                                                               ███ ░███              ░███                   
                                                                              ░░██████               █████                  
                                                                               ░░░░░░               ░░░░░                   
    " 
    Write-Host -Fore Red "          Eren Perakende Red Team" 
    Write-Host -Fore Gray "          https://github.com/dheenaxe/ErenRedTeam"
    Write-Host ""
    Write-Host ""

   
    Show-Menu
    $choice = Read-Host "Enter your choice"
    
    switch ($choice) {
        "0" {
            Get-NetFirewallRule | Where-Object { $_.DisplayName -match "^\[ErenRedTeam\]" } | Remove-NetFirewallRule
            Write-Host "`n[ErenRedTeam] rules deleted successfully!" -ForegroundColor Green
        }
        "1" {

            $ipAddresses = @(
                "213.74.174.212",
                "213.14.77.133",
                "213.74.174.217",
                "213.74.174.218",
                "213.74.174.224",
                "213.74.174.225",
                "217.169.192.99",
                "37.140.208.222",
                "62.108.64.138",
                "194.29.211.40",
                "193.108.213.169",
                "212.127.96.56",
                "213.161.144.89",
                "213.148.68.25",
                "77.72.184.61",
                "195.142.246.30",
                "193.254.228.149",
                "195.177.206.34",
                "93.94.192.82",
                "213.74.177.240",
                "195.214.186.155"
            )

            foreach ($ip in $ipAddresses) {
                $ruleName = "[ErenRedTeam] Allow Outbound $ip"
                New-NetFirewallRule `
                    -DisplayName $ruleName `
                    -Direction Outbound `
                    -Action Allow `
                    -RemoteAddress $ip `
                    -Protocol Any `
                    -Profile Any `
                    -Enabled True
            }
        } "2" {
            
            $fqdns = @(
                "ic2integra.globalblue.com",
                "img-erenperakende.mncdn.com",
                "vhq.tr.verifone.com"
            )

            foreach ($fqdn in $fqdns) {
                $ruleName = "[ErenRedTeam] Allow Outbound $fqdn"
                New-NetFirewallRule `
                    -DisplayName $ruleName `
                    -Direction Outbound `
                    -Action Allow `
                    -RemoteAddress $fqdn `
                    -Protocol Any `
                    -Profile Any `
                    -Enabled True
            }
        }
    }
    Write-Host "Press Enter to continue..."
    Read-Host
}