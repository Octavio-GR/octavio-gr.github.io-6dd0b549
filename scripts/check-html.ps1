$ErrorActionPreference = "Stop"

$Root = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
$Failures = 0

Write-Host "== CHECK HTML ==" -ForegroundColor Cyan

# Only validate published HTML documents.
# components/ contains reusable fragments/templates and is not itself a published route.
Get-ChildItem -Path $Root -Recurse -File -Filter *.html |
    Where-Object {
        $_.FullName -notmatch "\\.git\\" -and
        $_.FullName -notmatch "\\components\\"
    } |
    ForEach-Object {

        $File = $_
        $Content = Get-Content -Raw -LiteralPath $File.FullName
        $Name = $File.FullName.Replace($Root,'')

        if ($Content -notmatch '(?i)<!DOCTYPE\s+html') {
            Write-Host "MISSING DOCTYPE: $Name" -ForegroundColor Red
            $Failures++
        }

        if ($Content -notmatch '(?i)<html\b[^>]*\blang\s*=') {
            Write-Host "MISSING LANG: $Name" -ForegroundColor Red
            $Failures++
        }

        if ($Content -notmatch '(?i)<title>.*?</title>') {
            Write-Host "MISSING TITLE: $Name" -ForegroundColor Red
            $Failures++
        }

        $H1Count = ([regex]::Matches($Content, '(?i)<h1\b')).Count

        if ($H1Count -ne 1) {
            Write-Host "EXPECTED ONE H1, FOUND $H1Count : $Name" -ForegroundColor Red
            $Failures++
        }
    }

if ($Failures -gt 0) {
    throw "check-html: $Failures issue(s) found."
}

Write-Host "PASS: HTML structural checks passed." -ForegroundColor Green
