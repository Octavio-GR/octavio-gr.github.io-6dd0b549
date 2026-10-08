$ErrorActionPreference = "Stop"

$Root = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
$Failures = 0

Write-Host "== CHECK CSS ==" -ForegroundColor Cyan

Get-ChildItem -Path $Root -Recurse -File -Filter *.css |
    Where-Object { $_.FullName -notmatch "\\.git\\" } |
    ForEach-Object {

        $File = $_
        $Content = Get-Content -Raw -LiteralPath $File.FullName
        $Name = $File.FullName.Replace($Root,'')

        # Detect accidental duplicate @import statements.
        $Imports = [regex]::Matches(
            $Content,
            '(?im)^\s*@import\s+url\(["'']?([^"'')]+)',
            [System.Text.RegularExpressions.RegexOptions]::IgnoreCase
        ) | ForEach-Object { $_.Groups[1].Value.Trim() }

        $Duplicates = $Imports |
            Group-Object |
            Where-Object { $_.Count -gt 1 }

        foreach ($Duplicate in $Duplicates) {
            Write-Host "DUPLICATE IMPORT: $Name -> $($Duplicate.Name)" -ForegroundColor Red
            $Failures++
        }
    }

if ($Failures -gt 0) {
    throw "check-css: $Failures issue(s) found."
}

Write-Host "PASS: CSS checks passed." -ForegroundColor Green
