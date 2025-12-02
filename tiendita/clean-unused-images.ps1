$data = Get-Content -Raw -Path ".\products.json" | ConvertFrom-Json | Select-Object -ExpandProperty items
$images = $data | ForEach-Object { $_.images } | Select-Object -Unique | Where-Object { $_ }
$unusedImages = Get-ChildItem -Path ".\img" -File | Where-Object { $images -notcontains $_.Name }
$unusedImages | ForEach-Object {
    Write-Host "Removing unused image: $($_.FullName)"
    Remove-Item -Path $_.FullName
}