Clear-Host
Write-Host ""
Write-Host ""
Write-Host -Fore Red 
"
                                                                                                                            
@@@  @@@   @@@@@@   @@@@@@@   @@@  @@@  @@@@@@@  @@@  @@@  @@@  @@@  @@@@@@@@@@   @@@  @@@       @@@@@@@    @@@@@@     @@@  
@@@  @@@  @@@@@@@@  @@@@@@@@  @@@  @@@  @@@@@@@  @@@  @@@  @@@@ @@@  @@@@@@@@@@@  @@@  @@@       @@@@@@@@  @@@@@@@    @@@@  
@@!  !@@  @@!  @@@  @@!  @@@  @@!  !@@    @@!    @@!  @@@  @@!@!@@@  @@! @@! @@!  @@!  @@@       @@!  @@@  !@@       @@@!!  
!@!  @!!  !@!  @!@  !@!  @!@  !@!  @!!    !@!    !@!  @!@  !@!!@!@!  !@! !@! !@!  !@!  @!@       !@!  @!@  !@!         !@!  
@!@@!@!   @!@  !@!  @!@!!@!   @!@@!@!     @!!    @!@  !@!  @!@ !!@!  @!! !!@ @!@  @!@  !@!       @!@@!@!   !!@@!!      @!@  
!!@!!!    !@!  !!!  !!@!@!    !!@!!!      !!!    !@!  !!!  !@!  !!!  !@!   ! !@!  !@!  !!!       !!@!!!     !!@!!!     !@!  
!!: :!!   !!:  !!!  !!: :!!   !!: :!!     !!:    !!:  !!!  !!:  !!!  !!:     !!:  !!:  !!!       !!:            !:!    !!:  
:!:  !:!  :!:  !:!  :!:  !:!  :!:  !:!    :!:    :!:  !:!  :!:  !:!  :!:     :!:  :!:  !:!  :!:  :!:           !:!     :!:  
 ::  :::  ::::: ::  ::   :::   ::  :::     ::    ::::: ::   ::   ::  :::     ::   ::::: ::  :::   ::       :::: ::     :::  
 :   :::   : :  :    :   : :   :   :::     :      : :  :   ::    :    :      :     : :  :   :::   :        :: : :       ::  
                                                                                                                            
" 
Write-Host -Fore Red "          Eren Perakende Red Team" 
Write-Host -Fore Gray "          https://github.com/dheenaxe/ErenRedTeam"
Write-Host ""
Write-Host ""


Invoke-Expression "Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))"
Invoke-Expression "choco upgrade chocolatey"
Invoke-Expression "choco install -y python3"
Invoke-Expression "python3 --version"
Invoke-Expression "python -m pip install --upgrade pip"
Invoke-Expression "pip3 install oletools"
Invoke-Expression "pip3 show oletools"
$oletoolsPath = python -c "import oletools; print(oletools.__file__)"
Write-Host "Oletools is installed at: $oletoolsPath"
