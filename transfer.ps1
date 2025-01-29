$file = Get-ChildItem -Path "C:\eren\" -Filter "*.vhdx" -Recurse

$ftpServer = "ftp://10.12.0.26"
$ftpUsername = "tester"
$ftpPassword = "password"
$ftpPath = "/"

if (Test-Connection -ComputerName 10.12.0.26 -Count 2 -Quiet) {
    if ($file) {
        $filePath = $file.FullName
        $ftpUri = New-Object System.Uri("$ftpServer$ftpPath/$($file.Name)")

        $ftpRequest = [System.Net.FtpWebRequest]::Create($ftpUri)
        $ftpRequest.Method = [System.Net.WebRequestMethods+Ftp]::UploadFile
        $ftpRequest.Credentials = New-Object System.Net.NetworkCredential($ftpUsername, $ftpPassword)
        $ftpRequest.UseBinary = $true
        $ftpRequest.UsePassive = $true


        $chunkSize = 1048576  
        $fileSize = [System.Int64]$file.Length  
        $bytesUploaded = 0

        $fileStream = [System.IO.File]::OpenRead($filePath)

        $ftpStream = $ftpRequest.GetRequestStream()

        while ($bytesUploaded -lt $fileSize) {

            $bytesToRead = [Math]::Min($chunkSize, $fileSize - $bytesUploaded)
            $buffer = New-Object byte[] $bytesToRead

            $fileStream.Read($buffer, 0, $bytesToRead)

            $ftpStream.Write($buffer, 0, $bytesToRead)

            $bytesUploaded += $bytesToRead

            Write-Progress -PercentComplete (($bytesUploaded / $fileSize) * 100) -Status "Uploading..." -Activity "$bytesUploaded of $fileSize bytes uploaded"
        }

        $ftpStream.Close()
        $fileStream.Close()

        $ftpResponse = $ftpRequest.GetResponse()
        Write-Output "File uploaded successfully to FTP server (10.12.0.26)"
    }
