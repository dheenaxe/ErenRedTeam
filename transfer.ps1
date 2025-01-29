$file = Get-ChildItem -Path "C:\eren\" -Filter "*.vhdx" -Recurse

if ($file) {
    $vhdxFileName = $file.FullName  # Get the full path of the file

    $destinationPath = "O:\ortak_haftalik\RedTeam"

    Copy-Item -Path $vhdxFileName -Destination $destinationPath

    Write-Output "Copied to $destinationPath"
} else {
    Write-Output ".vhdx not found."
}
