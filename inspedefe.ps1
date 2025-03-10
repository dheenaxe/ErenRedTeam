param (
    [string]$FolderPath = "."
)

Clear-Host
Write-Host ""
Write-Host ""
Write-Host -Fore Red 
"
inspedefe.ps1
" 

Write-Host -Fore Red "          Eren Perakende Red Team" 
Write-Host -Fore Gray "          https://github.com/dheenaxe/ErenRedTeam"
Write-Host ""
Write-Host ""

$PdfFiles = Get-ChildItem -Path $FolderPath -Recurse -Filter "*.pdf" -File

if ($PdfFiles.Count -eq 0) {
    Write-Host "No PDF files found in the specified directory." -ForegroundColor Yellow
    exit
}

$keywords = @(
    "obj", "endobj", "stream", "endstream", "xref", "trailer", "startxref",
    "/Page", "/Encrypt", "/ObjStm", "/JS", "/JavaScript", "/AA", "/OpenAction",
    "/AcroForm", "/JBIG2Decode", "/RichMedia", "/Launch", "/EmbeddedFile", "/XFA"
)

foreach ($Pdf in $PdfFiles) {
    try {
        $fs = [System.IO.File]::OpenRead($Pdf.FullName)
        $buffer = New-Object byte[] 4096
        $fs.Read($buffer, 0, 4096) | Out-Null
        $fs.Close()

        $TextContent = [System.Text.Encoding]::ASCII.GetString($buffer)

        Write-Host "File: $($Pdf.FullName)"

        foreach ($keyword in $keywords) {
            $found = $TextContent -match $keyword
            if ($found) {
                Write-Host " - $keyword : Detected" -ForegroundColor Red
            } else {
                Write-Host " - $keyword : Not Detected"  -ForegroundColor Green
            }
        }

        Write-Host "--------------------------------------"
    }
    catch {
        Write-Host "Error reading file: $($Pdf.FullName) - $($_.Exception.Message)" -ForegroundColor Yellow
    }
}

Write-Host "Scan completed."
