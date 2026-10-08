$ErrorActionPreference = "Stop"

$Root = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
$Failures = 0

Write-Host "== CHECK ASSETS ==" -ForegroundColor Cyan

# Only validate published HTML/CSS documents.
# components/ contains reusable fragments/templates and is not itself a published route.
Get-ChildItem -Path $Root -Recurse -File -Include *.html,*.css |
    Where-Object {
        $_.FullName -notmatch "\\.git\\" -and
        $_.FullName -notmatch "\\components\\"
    } |
    ForEach-Object {

        $File = $_
        $Content = Get-Content -Raw -LiteralPath $File.FullName

        $Matches = [regex]::Matches(
            $Content,
            '(?:href|src|url)\s*(?:=|\()\s*["'']?([^"''\)\s]+)',
            [System.Text.RegularExpressions.RegexOptions]::IgnoreCase
        )

        foreach ($Match in $Matches) {

            $Ref = $Match.Groups[1].Value.Trim("'`"")

            if (
                [string]::IsNullOrWhiteSpace($Ref) -or
                $Ref.StartsWith("#") -or
                $Ref -match '^(https?:|data:|mailto:|tel:)'
            ) {
                continue
            }

            $CleanRef = ($Ref -split '[?#]')[0]

            if ([string]::IsNullOrWhiteSpace($CleanRef)) {
                continue
            }

            if ($CleanRef.StartsWith("/")) {
                $Target = Join-Path $Root $CleanRef.TrimStart("/")
            }
            else {
                $Target = Join-Path $File.DirectoryName $CleanRef
            }

            if (-not (Test-Path -LiteralPath $Target)) {
                Write-Host "MISSING ASSET: $($File.FullName.Replace($Root,'')) -> $Ref" -ForegroundColor Red
                $Failures++
            }
        }
    }

if ($Failures -gt 0) {
    throw "check-assets: $Failures missing asset/reference(s)."
}

Write-Host "PASS: referenced assets appear to exist." -ForegroundColor Green
