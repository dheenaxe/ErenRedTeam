function Show-Menu {
    Write-Host "Select an option:" -ForegroundColor Cyan
    Write-Host "1: Hayabusa CSV Timeline"
    Write-Host "2: Hayabusa Logon Analyze"
    Write-Host "3: Chainsaw Hunt"
    Write-Host "Çıkmak için CTRL + C"
}

while ($true) {
      if (-not (Test-Path "output")) {
        New-Item -Path "output" -ItemType Directory -Force
    }
    Clear-Host
    Write-Host ""
    Write-Host ""
    Write-Host -Fore Red 
    "
    ╔═══════════════════════════════════════════════════════════════════════════════════════════════════╗
    ║                   █████                                                                      ████ ║
    ║                  ░░███                                                                      ░░███ ║
    ║  ██████   ██████  ░███ █████ █████████████    ██████   ██████   ██████     ████████   █████  ░███ ║
    ║ ███░░███ ███░░███ ░███░░███ ░░███░░███░░███  ███░░███ ███░░███ ███░░███   ░░███░░███ ███░░   ░███ ║
    ║░███ ░░░ ░███████  ░██████░   ░███ ░███ ░███ ░███████ ░███ ░░░ ░███████     ░███ ░███░░█████  ░███ ║
    ║░███  ███░███░░░   ░███░░███  ░███ ░███ ░███ ░███░░░  ░███  ███░███░░░      ░███ ░███ ░░░░███ ░███ ║
    ║░░██████ ░░██████  ████ █████ █████░███ █████░░██████ ░░██████ ░░██████  ██ ░███████  ██████  █████║
    ║ ░░░░░░   ░░░░░░  ░░░░ ░░░░░ ░░░░░ ░░░ ░░░░░  ░░░░░░   ░░░░░░   ░░░░░░  ░░  ░███░░░  ░░░░░░  ░░░░░ ║
    ║                                                                            ░███                   ║
    ║                                                                            █████                  ║
    ║                                                                           ░░░░░                   ║
    ╚═══════════════════════════════════════════════════════════════════════════════════════════════════╝
    " 
    Write-Host -Fore Red "          Eren Perakende Red Team" 
    Write-Host -Fore Gray "          https://github.com/dheenaxe/ErenRedTeam"
    Write-Host ""
    Write-Host ""

    # iex (New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/dheenaxe/ErenRedTeam/refs/heads/main/menu.ps1') 

    Show-Menu
    $choice = Read-Host "Enter your choice"
    
    switch ($choice) {
        "3" {
            $exePath = "C:\Users\HPRKIT31\Documents\2025-03-06\script\chainsaw\chainsaw.exe"
            if (Test-Path $exePath) {
                $csvpath = Read-Host ".evtx File Destination"
                Invoke-Expression "$exePath hunt $csvpath -s chainsaw/sigma_all_rules/ --mapping chainsaw/mappings/sigma-event-logs-all.yml -o output\hunt.csv"
                Invoke-Expression "net6\TimelineExplorer\TimelineExplorer.exe  output\hunt.csv"
            } else {
                Write-Host "Invalid path! Please try again." -ForegroundColor Red
            }
        }
        "1" {
            $exePath = "C:\Users\HPRKIT31\Documents\2025-03-06\script\hayabusa\hayabusa-3.1.0-win-x64.exe"
            if (Test-Path $exePath) {
                $csvpath = Read-Host ".evtx File Destination"
                if ($csvpath) {
                    Invoke-Expression "$exePath csv-timeline -f $csvpath -o output\csv-timeline.csv -H output\csv-timeline.html"
                    Invoke-Expression "net6\TimelineExplorer\TimelineExplorer.exe  output\csv-timeline.csv"
                }
                Invoke-Expression "$exePath csv-timeline -l -o output\csv-timeline.csv -H output\csv-timeline.html"
                Invoke-Expression "net6\TimelineExplorer\TimelineExplorer.exe  output\csv-timeline.csv"
            } else {
                Write-Host "Invalid path! Please try again." -ForegroundColor Red
            }
        }
        "2" {
            $exePath = "C:\Users\HPRKIT31\Documents\2025-03-06\script\hayabusa\hayabusa-3.1.0-win-x64.exe"
            if (Test-Path $exePath) {
                $csvpath = Read-Host ".evtx File Destination"
                if ($csvpath) {
                    Invoke-Expression "$exePath logon-summary -f $csvpath"
                }
                Invoke-Expression "$exePath logon-summary -l"
            } else {
                Write-Host "Invalid path! Please try again." -ForegroundColor Red
            }
        }
        "3" {
            $exePath = "C:\Users\HPRKIT31\Documents\2025-03-06\script\chainsaw\chainsaw.exe"
            if (Test-Path $exePath) {
                $csvpath = Read-Host ".evtx File Destination"
                Invoke-Expression "$exePath hunt $csvpath -s chainsaw/sigma_all_rules/ --mapping chainsaw/mappings/sigma-event-logs-all.yml -o output\hunt.csv"
                Invoke-Expression "net6\TimelineExplorer\TimelineExplorer.exe  output\hunt.csv"
            } else {
                Write-Host "Invalid path! Please try again." -ForegroundColor Red
            }
        }
        default {
            Write-Host "Invalid selection. Please try again." -ForegroundColor Red
        }
    }
    
    Write-Host "Press Enter to continue..."
    Read-Host
}