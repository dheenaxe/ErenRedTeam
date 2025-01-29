$file = Get-ChildItem -Path "C:\eren\" -Filter "*.vhdx" -Recurse

$networkPath = "http://127.0.0.1:80/upload"

if (Test-Connection -ComputerName 127.0.0.1 -Count 2 -Quiet) {
    if ($file) {
        $filePath = $file.FullName

        $fileContent = [System.IO.File]::ReadAllBytes($filePath)
        $headers = @{"Content-Type" = "multipart/form-data"}
        $body = @{
                    "files" = [System.Convert]::ToBase64String($fileContent)
                }

        $response = Invoke-RestMethod -Uri $uri -Method Post -Body $body -Headers $headers
    } else {
        Write-Output ".vhdx file not found."
    }
} else {
    Write-Output "Unable to reach the network path 127.0.0.1"
}