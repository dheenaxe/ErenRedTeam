$file = Get-ChildItem -Path "C:\eren\" -Filter "*.vhdx" -Recurse

$networkPath = "\\10.1.1.1\Ortak\ortak_haftalik\RedTeam"

if (Test-Connection -ComputerName 10.1.1.1 -Count 2 -Quiet) {
    Write-Output "10.1.1.1 is in reach"
    if ($file) {
        $vhdxFileName = $file.FullName

        Copy-Item -Path $vhdxFileName -Destination $networkPath

        Write-Output "Copied to $networkPath"
    } else {
        Write-Output ".vhdx file not found."
    }
} else {
    Write-Output "Unable to reach the network path \\10.1.1.1"
}