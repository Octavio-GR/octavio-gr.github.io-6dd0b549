$ErrorActionPreference = "Stop"

$Scripts = @(
    "check-links.ps1",
    "check-assets.ps1",
    "check-html.ps1",
    "check-css.ps1",
    "check-encoding.ps1",
    "check-duplicates.ps1"
)

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host " TOROIDE VALIDATION SUITE" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

foreach ($Script in $Scripts) {

    $ScriptPath = Join-Path $PSScriptRoot $Script

    try {
        & $ScriptPath
    }
    catch {
        Write-Host ""
        Write-Host "FAIL: $Script" -ForegroundColor Red
        throw
    }

    Write-Host ""
}

Write-Host "========================================" -ForegroundColor Green
Write-Host " VALIDATION COMPLETE" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
