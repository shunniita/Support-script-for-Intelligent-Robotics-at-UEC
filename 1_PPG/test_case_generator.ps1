
# 乱数の範囲
$xyminRandomValue = -6
$xymaxRandomValue = 6
$zminRandomValue = 1
$zmaxRandomValue = 8

# ひとつめのwaypoint
$x1 = 10 * (Get-Random -Minimum $xyminRandomValue -Maximum $xymaxRandomValue)
$y1 = 10 * (Get-Random -Minimum $xyminRandomValue -Maximum $xymaxRandomValue)
$z1 = 10 * (Get-Random -Minimum $zminRandomValue -Maximum $zmaxRandomValue)

Write-Host "waypoint_1 = [$x1, $y1, $z1];"

# ふたつめのwaypoint
$x2 = 10 * (Get-Random -Minimum $xyminRandomValue -Maximum $xymaxRandomValue)
$y2 = 10 * (Get-Random -Minimum $xyminRandomValue -Maximum $xymaxRandomValue)
$z2 = 10 * (Get-Random -Minimum $zminRandomValue -Maximum $zmaxRandomValue)

Write-Host "waypoint_2 = [$x2, $y2, $z2];"

# みっつめのwaypoint
$x3 = 10 * (Get-Random -Minimum $xyminRandomValue -Maximum $xymaxRandomValue)
$y3 = 10 * (Get-Random -Minimum $xyminRandomValue -Maximum $xymaxRandomValue)
$z3 = 10 * (Get-Random -Minimum $zminRandomValue -Maximum $zmaxRandomValue)

Write-Host "waypoint_3 = [$x3, $y3, $z3];"

Write-Host ""

# 風の設定
## 風速[m/s]   ( 0 ～ 3 の間に設定)
$wind_v = 3 # Get-Random -Minimum 0.0 -Maximum 3.0

## 風向[deg.]   ( 0 ～ 360 の間に設定)
$wind_d = 0 # Get-Random -Minimum 0 -Maximum 360

Write-Host "param.wind_v = $wind_v;"
Write-Host "param.wind_d = $wind_d;"
