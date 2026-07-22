$csv = Get-Content "C:\Users\Hernan\Downloads\Encuetas Concierge.csv" -Encoding UTF8
$separator = ';'

$results = @()
foreach($line in $csv[2..($csv.Length-1)]) {
    if([string]::IsNullOrWhiteSpace($line)) { continue }
    $parts = $line.Split($separator)
    if($parts.Length -lt 27) { continue }
    
    $n = $parts[0].Trim()
    $nombre = $parts[1].Trim()
    $fecha = $parts[2].Trim()
    $hab = $parts[3].Trim()
    
    # Ratings are from index 4 to 26 (VG through Av)
    $ratings = @()
    for($i = 4; $i -lt 27; $i++) {
        $val = $parts[$i].Trim()
        if($val -match '^[1-5]$') {
            $ratings += [int]$val
        }
    }
    
    if($ratings.Count -eq 0) { continue }
    
    $avg = ($ratings | Measure-Object -Average).Average
    
    # Text fields at indices 30-33
    $masGusto = if($parts.Length -gt 30) { $parts[30].Trim() } else { '' }
    $menosGusto = if($parts.Length -gt 31) { $parts[31].Trim() } else { '' }
    $sugerencias = if($parts.Length -gt 32) { $parts[32].Trim() } else { '' }
    $comentarios = if($parts.Length -gt 33) { $parts[33].Trim() } else { '' }
    
    $results += [PSCustomObject]@{
        N = $n
        Nombre = $nombre
        Fecha = $fecha
        Habitacion = $hab
        Promedio = [Math]::Round($avg, 2)
        Calificaciones = $ratings.Count
        MasGusto = $masGusto
        MenosGusto = $menosGusto
        Sugerencias = $sugerencias
        Comentarios = $comentarios
    }
}

Write-Host "=== TOTAL REGISTROS: $($results.Count) ==="
Write-Host ""

Write-Host "=== TOP 5 MEJORES (Promedio mas bajo = mejor, 1=excelente) ==="
Write-Host "---"
$best = $results | Sort-Object Promedio, N | Select-Object -First 5
$i = 1
$best | ForEach-Object {
    Write-Host "$i. Promedio: $($_.Promedio) | Hab: $($_.Habitacion) | $($_.Nombre) | $($_.Fecha)"
    if($_.MasGusto) { Write-Host "   [+] Lo mas gustado: $($_.MasGusto)" }
    if($_.MenosGusto) { Write-Host "   [-] Lo menos gustado: $($_.MenosGusto)" }
    if($_.Sugerencias) { Write-Host "   [~] Sugerencias: $($_.Sugerencias)" }
    if($_.Comentarios) { Write-Host "   [*] Comentarios: $($_.Comentarios)" }
    Write-Host ""
    $i++
}

Write-Host "=== TOP 5 PEORES (Promedio mas alto = peor, 5=deficiente) ==="
Write-Host "---"
$worst = $results | Sort-Object Promedio -Descending | Select-Object -First 5
$i = 1
$worst | ForEach-Object {
    Write-Host "$i. Promedio: $($_.Promedio) | Hab: $($_.Habitacion) | $($_.Nombre) | $($_.Fecha)"
    if($_.MasGusto) { Write-Host "   [+] Lo mas gustado: $($_.MasGusto)" }
    if($_.MenosGusto) { Write-Host "   [-] Lo menos gustado: $($_.MenosGusto)" }
    if($_.Sugerencias) { Write-Host "   [~] Sugerencias: $($_.Sugerencias)" }
    if($_.Comentarios) { Write-Host "   [*] Comentarios: $($_.Comentarios)" }
    Write-Host ""
    $i++
}
