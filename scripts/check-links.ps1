$ErrorActionPreference = "Stop"

$Root = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
$Failures = 0

Write-Host "== CHECK LINKS ==" -ForegroundColor Cyan

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

        $Matches = [regex]::Matches(
            $Content,
            '(?:href|src)\s*=\s*["'']([^"'']+)["'']',
            [System.Text.RegularExpressions.RegexOptions]::IgnoreCase
        )

        foreach ($Match in $Matches) {

            $Ref = $Match.Groups[1].Value

            if (
                [string]::IsNullOrWhiteSpace($Ref) -or
                $Ref.StartsWith("#") -or
                $Ref -match '^(https?:|mailto:|tel:|javascript:|data:)'
            ) {
                continue
            }

            $CleanRef = ($Ref -split '[?#]')[0]

            if ([string]::IsNullOrWhiteSpace($CleanRef)) {
                continue
            }

            $Target = Join-Path $File.DirectoryName $CleanRef

            if (-not (Test-Path -LiteralPath $Target)) {
                Write-Host "BROKEN: $($File.FullName.Replace($Root,'')) -> $Ref" -ForegroundColor Red
                $Failures++
            }
        }
    }

if ($Failures -gt 0) {
    throw "check-links: $Failures broken local reference(s)."
}

Write-Host "PASS: no broken local links found." -ForegroundColor Green
