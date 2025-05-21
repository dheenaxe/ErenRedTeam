Clear-Host
Write-Host ""
Write-Host ""
Write-Host -Fore Red 
"
@@@       @@@  @@@  @@@@@@@@@@   @@@@@@@   @@@@@@@@  @@@  @@@       @@@@@@@    @@@@@@     @@@ 
@@@       @@@  @@@  @@@@@@@@@@@  @@@@@@@@  @@@@@@@@  @@@@ @@@       @@@@@@@@  @@@@@@@    @@@@ 
@@!       @@!  @@@  @@! @@! @@!  @@!  @@@  @@!       @@!@!@@@       @@!  @@@  !@@       @@@!! 
!@!       !@!  @!@  !@! !@! !@!  !@!  @!@  !@!       !@!!@!@!       !@!  @!@  !@!         !@! 
@!!       @!@  !@!  @!! !!@ @!@  @!@@!@!   @!!!:!    @!@ !!@!       @!@@!@!   !!@@!!      @!@ 
!!!       !@!  !!!  !@!   ! !@!  !!@!!!    !!!!!:    !@!  !!!       !!@!!!     !!@!!!     !@! 
!!:       !!:  !!!  !!:     !!:  !!:       !!:       !!:  !!!       !!:            !:!    !!: 
 :!:      :!:  !:!  :!:     :!:  :!:       :!:       :!:  !:!  :!:  :!:           !:!     :!: 
 :: ::::  ::::: ::  :::     ::    ::        :: ::::   ::   ::  :::   ::       :::: ::     ::: 
: :: : :   : :  :    :      :     :        : :: ::   ::    :   :::   :        :: : :       ::                                                                                                          
" 
Write-Host -Fore Red "          Eren Perakende Red Team" 
Write-Host -Fore Gray "          https://github.com/dheenaxe/ErenRedTeam"
Write-Host ""
Write-Host ""

# Setup
$timestamp = Get-Date -Format "yyyyMMdd"
$computerName = $env:COMPUTERNAME
$outputDir = "C:\eren"
$outputFile = "$outputDir\${timestamp}_${computerName}.csv"
New-Item -Path $outputDir -ItemType Directory -Force | Out-Null

# Automation keyword patterns
$automationKeywords = @("UiPath", "Automation", "Bot", "Script", "Python", "PowerShell", "TaskEng", "schtasks", "atbroker", "AutoHotkey", "macro", "Wscript")

# Combined results
$allResults = @()

### --- PROCESS SCAN ---
$processes = Get-Process | Sort-Object ProcessName
foreach ($proc in $processes) {
    $match = $automationKeywords | Where-Object { $proc.ProcessName -like "*$_*" }
    $allResults += [PSCustomObject]@{
        ComputerName  = $computerName
        Source        = "Process"
        Name          = $proc.ProcessName
        Identifier    = $proc.Id
        Command       = ""  # Not directly available here
        Status        = "Running"
        RunAsUser     = ""
        LastRunTime   = ""
        NextRunTime   = ""
        IsAutomation  = ($match.Count -gt 0)
    }
}

### Write-Host "`n[+] Process Scan Results:"
### $allResults | Where-Object { $_.Source -eq "Process" } | ForEach-Object {
###     Write-Host "$($_.Name) (PID: $($_.Identifier)) - Automation: $($_.IsAutomation)"
### }

### --- SCHEDULED TASKS SCAN ---
$tasks = schtasks /Query /FO LIST /V 2>&1
$taskBlock = @{}

foreach ($line in $tasks) {
    if ($line -match "^([^\:]+):\s+(.*)$") {
        $taskBlock[$matches[1].Trim()] = $matches[2].Trim()
    }
    if ($line -eq "") {
        if ($taskBlock.Count -gt 0) {
            
            $taskName = $taskBlock["TaskName"]
            $taskCmd = $taskBlock["Task To Run"]
            $match = $automationKeywords | Where-Object { $taskCmd -like "*$_*" }
            $allResults += [PSCustomObject]@{
                ComputerName  = $computerName
                Source        = "ScheduledTask"
                Name          = $taskName
                Identifier    = ""
                Command       = $taskCmd
                Status        = $taskBlock["Status"]
                RunAsUser     = $taskBlock["Run As User"]
                LastRunTime   = $taskBlock["Last Run Time"]
                NextRunTime   = $taskBlock["Next Run Time"]
                IsAutomation  = ($match.Count -gt 0)
            }
            $taskBlock.Clear()
        }
    }
}

### Write-Host "`n[+] Raw Scheduled Tasks Output:"
### $tasks | ForEach-Object { Write-Host $_ }

# Save report
$allResults | Export-Csv -Path $outputFile -NoTypeInformation -Force
Write-Host "[+] Scan complete. Report saved to: $outputFile"