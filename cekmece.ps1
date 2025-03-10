function Show-Menu {
    Write-Host "Select an option:" -ForegroundColor Cyan
    Write-Host "1: Hayabusa CSV Timeline"
    Write-Host "2: Hayabusa Logon Analyze"
    Write-Host "3: Chainsaw Hunt"
    Write-Host "4: PDF Header Analyze"
    Write-Host "5: Olevba"
    Write-Host "Çıkmak için CTRL + C"
}

# Chainsaw kuralları güncellerken, bir yandan da Net6 indirilsin.

while ($true) {
    
    if (-not (Test-Path "C:\eren")) {
    New-Item -Path "C:\eren" -ItemType Directory -Force
    }

    if (-not (Test-Path "C:\eren\cekmece.7z")) {
        Start-BitsTransfer -Source "http://78.129.240.79:8080/cekmece.7z" -Destination "C:\eren\cekmece.7z"
    }

    if (-not (Test-Path "C:\eren\7zr.exe")) {
        Start-BitsTransfer -Source "http://78.129.240.79:8080/7zr.exe" -Destination "C:\eren\7zr.exe"
    }
    if (-not (Test-Path "C:\eren\cekmece\inspedefe.ps1")) {
        Start-BitsTransfer -Source "https://raw.githubusercontent.com/dheenaxe/ErenRedTeam/refs/heads/main/inspedefe.ps1" -Destination "C:\eren\cekmece\inspedefe.ps1"
    }
    if (-not (Test-Path "C:\eren\cekmece\korktunmu.ps1")) {
        Start-BitsTransfer -Source "https://raw.githubusercontent.com/dheenaxe/ErenRedTeam/refs/heads/main/korktunmu.ps1" -Destination "C:\eren\cekmece\korktunmu.ps1"
    }
     if (-not (Test-Path "C:\eren\cekmece\output")) {
        New-Item -Path "C:\eren\cekmece\output" -ItemType Directory -Force
    }
    if (-not (Test-Path "C:\eren\cekmece\hayabusa")) {
        Start-Process "C:\eren\7zr.exe" -ArgumentList "x", "C:\eren\cekmece.7z", "-oC:\eren\cekmece\", "-y" -Wait
    } else {
        Write-Host "Delete cekmece folder and try again."
    }
    if (-not (Test-Path "C:\eren\cekmece\output")) {
        New-Item -Path "C:\eren\cekmece\output" -ItemType Directory -Force
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

   
    Show-Menu
    $choice = Read-Host "Enter your choice"
    
    switch ($choice) {
        "1" {
            $exePath = "C:\eren\cekmece\hayabusa\hayabusa-3.1.0-win-x64.exe"
            if (Test-Path $exePath) {
                $csvpath = Read-Host ".evtx File Destination"
                if ($csvpath) {
                    Invoke-Expression "$exePath csv-timeline -f $csvpath -o C:\eren\cekmece\output\csv-timeline.csv -H C:\eren\cekmece\output\csv-timeline.html"
                    Invoke-Expression "C:\eren\cekmece\net6\TimelineExplorer\TimelineExplorer.exe  C:\eren\cekmece\output\csv-timeline.csv"
                }
                Invoke-Expression "$exePath csv-timeline -l -o C:\eren\cekmece\output\csv-timeline.csv -H C:\eren\cekmece\output\csv-timeline.html"
                Invoke-Expression "C:\eren\cekmece\net6\TimelineExplorer\TimelineExplorer.exe  C:\eren\cekmece\output\csv-timeline.csv"
            } else {
                Write-Host "Invalid path! Please try again." -ForegroundColor Red
            }
        }
        "2" {
            $exePath = "C:\eren\cekmece\hayabusa\hayabusa-3.1.0-win-x64.exe"
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
            $exePath = "C:\eren\cekmece\chainsaw\chainsaw.exe"
            if (Test-Path $exePath) {
                $csvpath = Read-Host ".evtx File Destination"
                Invoke-Expression "$exePath hunt $csvpath -s C:/eren/cekmece/chainsaw/sigma_all_rules/ --mapping C:/eren/cekmece/chainsaw/mappings/sigma-event-logs-all.yml -o C:\eren\cekmece\output\hunt.csv"
                Invoke-Expression "C:\eren\cekmece\net6\TimelineExplorer\TimelineExplorer.exe  C:\eren\cekmece\output\hunt.csv"
            } else {
                Write-Host "Invalid path! Please try again." -ForegroundColor Red
            }
        }"4" {
            $exePath = "C:\eren\cekmece\inspedefe.ps1"
            if (Test-Path $exePath) {
                $csvpath = Read-Host "Folder Destination"
                Invoke-Expression "$exePath $csvpath -o C:\eren\cekmece\output\pdfheader.txt"
            } else {
                Write-Host "Invalid path! Please try again." -ForegroundColor Red
            }
        }"5" {
            $exePath = "C:\eren\cekmece\korktunmu.ps1"
            if (Test-Path $exePath) {
                 $csvpath = Read-Host "File Destination"
                Invoke-Expression "$exePath $csvpath"
            } else {
                Write-Host "Invalid path! Please try again." -ForegroundColor Red
            }
        }
    }
    Write-Host "Press Enter to continue..."
    Read-Host
}