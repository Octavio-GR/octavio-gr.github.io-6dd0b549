$ErrorActionPreference = "Stop"

$Root = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
$Failures = 0

Write-Host "== CHECK ENCODING ==" -ForegroundColor Cyan

Get-ChildItem -Path $Root -Recurse -File |
    Where-Object {
        $_.FullName -notmatch "\\.git\\" -and
        $_.Extension -in ".html",".css",".md",".txt",".xml",".json",".yml",".yaml",".ps1"
    } |
    ForEach-Object {

        $Bytes = [System.IO.File]::ReadAllBytes($_.FullName)

        if ($Bytes.Length -ge 3) {
            $HasUtf8Bom =
                $Bytes[0] -eq 0xEF -and
                $Bytes[1] -eq 0xBB -and
                $Bytes[2] -eq 0xBF

            if ($HasUtf8Bom) {
                Write-Host "UTF-8 BOM: $($_.FullName.Replace($Root,''))" -ForegroundColor Yellow
            }
        }

        try {
            $Utf8 = New-Object System.Text.UTF8Encoding($false, $true)
            [void]$Utf8.GetString($Bytes)
        }
        catch {
            Write-Host "INVALID UTF-8: $($_.FullName.Replace($Root,''))" -ForegroundColor Red
            $Failures++
        }
    }

if ($Failures -gt 0) {
    throw "check-encoding: $Failures invalid UTF-8 file(s)."
}

Write-Host "PASS: text files are valid UTF-8." -ForegroundColor Green
