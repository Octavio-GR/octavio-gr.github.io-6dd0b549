$ErrorActionPreference = "Stop"

$Root = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
$Failures = 0

Write-Host "== CHECK DUPLICATES ==" -ForegroundColor Cyan

Get-ChildItem -Path $Root -Recurse -File -Include *.css |
    Where-Object { $_.FullName -notmatch "\\.git\\" } |
    ForEach-Object {

        $File = $_
        $Lines = Get-Content -LiteralPath $File.FullName

        $PropertyLines = $Lines |
            Where-Object {
                $_ -match '^\s*[a-zA-Z-]+\s*:\s*[^;{}]+;?\s*$'
            } |
            ForEach-Object { $_.Trim() }

        $Duplicates = $PropertyLines |
            Group-Object |
            Where-Object { $_.Count -gt 1 }

        foreach ($Duplicate in $Duplicates) {
            Write-Host "REPEATED DECLARATION: $($File.FullName.Replace($Root,'')) -> $($Duplicate.Name)" -ForegroundColor Yellow
        }
    }

Write-Host "PASS: duplicate scan completed." -ForegroundColor Green
Write-Host "NOTE: repeated CSS declarations are reported as warnings, not automatic failures." -ForegroundColor DarkYellow
