Param(
    [switch]$Delete
)

$archive = Join-Path $PSScriptRoot '..\archive_20250923_0000' | Resolve-Path -ErrorAction SilentlyContinue
if (-not $archive) {
    Write-Host "No archive_20250923_0000 found."
    exit 0
}
$archive = $archive.Path
Write-Host "Archive path: $archive"
Get-ChildItem -Path $archive -Recurse | Select-Object FullName, Mode | Format-Table -AutoSize
if ($Delete) {
    Write-Host "Deleting archive..."
    Remove-Item -LiteralPath $archive -Recurse -Force
    Write-Host "Deleted."
}
