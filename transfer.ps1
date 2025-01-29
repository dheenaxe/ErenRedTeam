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


        $chunkSize = 1048576  # 1 MB
        $fileSize = [System.Int64]$file.Length  # Force conversion to Int64
        $bytesUploaded = 0

        $fileStream = [System.IO.File]::OpenRead($filePath)

        $ftpStream = $ftpRequest.GetRequestStream()

        while ($bytesUploaded -lt $fileSize) {

            # Update the chunkSize handling
            $bytesToRead = [System.Math]::Min($chunkSize, $fileSize - $bytesUploaded)
            
            # Create buffer of appropriate size for each chunk
            $buffer = New-Object byte[] $bytesToRead

            # Read the data into the buffer
            $fileStream.Read($buffer, 0, $bytesToRead)

            # Write the data to the FTP stream
            $ftpStream.Write($buffer, 0, $bytesToRead)

            # Update the uploaded bytes
            $bytesUploaded += $bytesToRead

            # Show upload progress
            Write-Progress -PercentComplete (($bytesUploaded / $fileSize) * 100) -Status "Uploading..." -Activity "$bytesUploaded of $fileSize bytes uploaded"
        }

        # Close the streams
        $ftpStream.Close()
        $fileStream.Close()

        # Get response from the FTP server
        $ftpResponse = $ftpRequest.GetResponse()
        Write-Output "File uploaded successfully to FTP server (10.12.0.26)"
    } else {
        Write-Output ".vhdx file not found."
    }
} else {
    Write-Output "Unable to reach the network path 10.12.0.26"
}
