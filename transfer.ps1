$file = Get-ChildItem -Path "C:\eren\" -Filter "*.vhdx" -Recurse

$ftpServer = "ftp://10.21.0.13"
$ftpUsername = "tester"
$ftpPassword = "password"
$ftpPath = "/"

if (Test-Connection -ComputerName 10.21.0.13  -Count 2 -Quiet) {
    if ($file) {
        $filePath = $file.FullName
        $ftpUri = New-Object System.Uri("$ftpServer$ftpPath/$($file.Name)")
        $ftpRequest = [System.Net.FtpWebRequest]::Create($ftpUri)
        $ftpRequest.Method = [System.Net.WebRequestMethods+Ftp]::UploadFile
        $ftpRequest.Credentials = New-Object System.Net.NetworkCredential($ftpUsername, $ftpPassword)
        $ftpRequest.UseBinary = $true
        $ftpRequest.UsePassive = $true
        $ftpRequest.KeepAlive = $false
        $bufferSize = 8192
        $fs = [System.IO.File]::OpenRead($filePath)
        $ftpStream = $ftpRequest.GetRequestStream()

        $buffer = New-Object byte[] $bufferSize
        $bytesRead = 0
        while (($bytesRead = $fs.Read($buffer, 0, $bufferSize)) -gt 0) {
            $ftpStream.Write($buffer, 0, $bytesRead)
        }

        $ftpStream.Close()
        $fs.Close()

        $ftpResponse = $ftpRequest.GetResponse()
        Write-Output "File uploaded successfully to FTP server (10.21.0.13)"
    } else {
        Write-Output ".vhdx file not found."
    }
} else {
    Write-Output "Unable to reach the network path 10.21.0.13"
}
