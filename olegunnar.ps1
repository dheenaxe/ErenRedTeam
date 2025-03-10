param (
    [string]$FilePath = "."
)

Clear-Host
Write-Host ""
Write-Host ""
Write-Host -Fore Red 
"
                                                                                                                           
 @@@@@@   @@@       @@@@@@@@   @@@@@@@@  @@@  @@@  @@@  @@@  @@@  @@@   @@@@@@   @@@@@@@        @@@@@@@    @@@@@@     @@@  
@@@@@@@@  @@@       @@@@@@@@  @@@@@@@@@  @@@  @@@  @@@@ @@@  @@@@ @@@  @@@@@@@@  @@@@@@@@       @@@@@@@@  @@@@@@@    @@@@  
@@!  @@@  @@!       @@!       !@@        @@!  @@@  @@!@!@@@  @@!@!@@@  @@!  @@@  @@!  @@@       @@!  @@@  !@@       @@@!!  
!@!  @!@  !@!       !@!       !@!        !@!  @!@  !@!!@!@!  !@!!@!@!  !@!  @!@  !@!  @!@       !@!  @!@  !@!         !@!  
@!@  !@!  @!!       @!!!:!    !@! @!@!@  @!@  !@!  @!@ !!@!  @!@ !!@!  @!@!@!@!  @!@!!@!        @!@@!@!   !!@@!!      @!@  
!@!  !!!  !!!       !!!!!:    !!! !!@!!  !@!  !!!  !@!  !!!  !@!  !!!  !!!@!!!!  !!@!@!         !!@!!!     !!@!!!     !@!  
!!:  !!!  !!:       !!:       :!!   !!:  !!:  !!!  !!:  !!!  !!:  !!!  !!:  !!!  !!: :!!        !!:            !:!    !!:  
:!:  !:!   :!:      :!:       :!:   !::  :!:  !:!  :!:  !:!  :!:  !:!  :!:  !:!  :!:  !:!  :!:  :!:           !:!     :!:  
::::: ::   :: ::::   :: ::::   ::: ::::  ::::: ::   ::   ::   ::   ::  ::   :::  ::   :::  :::   ::       :::: ::     :::  
 : :  :   : :: : :  : :: ::    :: :: :    : :  :   ::    :   ::    :    :   : :   :   : :  :::   :        :: : :       ::  
                                                                                                                           
" 
Write-Host -Fore Red "          Eren Perakende Red Team" 
Write-Host -Fore Gray "          https://github.com/dheenaxe/ErenRedTeam"
Write-Host ""
Write-Host ""

Invoke-Expression "pip3 install oletools"
$oletoolsPath = python -c "import oletools, os; print(os.path.dirname(oletools.__file__))"
Write-Host "Oletools is installed at: $oletoolsPath" -Fore Green
Invoke-Expression "python $oletoolsPath/olevba.py $FilePath"