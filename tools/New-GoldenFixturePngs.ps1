# Writes the golden/adversarial PNG stills (System.Drawing). Run from repo root.
$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.Drawing

$root = Split-Path -Parent $PSScriptRoot
$font = New-Object System.Drawing.Font 'Segoe UI', 16, ([System.Drawing.FontStyle]::Bold)
$small = New-Object System.Drawing.Font 'Segoe UI', 11

function Write-UiPng {
    param(
        [string]$RelDir,
        [string]$Title,
        [string]$Cta,
        [string]$Nav,
        [string]$BarHex,
        [int]$CtaPadLeft = 24
    )
    $dir = Join-Path $root $RelDir
    if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir | Out-Null }
    $path = Join-Path $dir 'screenshot.png'
    $bmp = New-Object System.Drawing.Bitmap 480, 160
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.Clear([System.Drawing.Color]::FromArgb(255, 248, 248, 246))
    $bar = [System.Drawing.ColorTranslator]::FromHtml($BarHex)
    $g.FillRectangle((New-Object System.Drawing.SolidBrush $bar), 0, 0, 480, 36)
    $white = [System.Drawing.Brushes]::White
    $ink = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(255, 24, 24, 24))
    $g.DrawString($Nav, $small, $white, 12, 8)
    $g.DrawString($Title, $font, $ink, 16, 52)
    $ctaBrush = New-Object System.Drawing.SolidBrush $bar
    $g.FillRectangle($ctaBrush, $CtaPadLeft, 108, 180, 36)
    $g.DrawString($Cta, $small, $white, ($CtaPadLeft + 12), 116)
    $g.Dispose()
    $bmp.Save($path, [System.Drawing.Imaging.ImageFormat]::Png)
    $bmp.Dispose()
    Write-Output $path
}

# T-G01: misspelled CTA vs brief "Start campaign"
Write-UiPng 'fixtures/T-G01-spelling' 'Episode 01' 'Start campiagn' 'Club Madeira' '#0A5C3A'

# T-G02: layout — CTA 8px from left, bar #FF0000 vs brief 24px / #0A5C3A
Write-UiPng 'fixtures/T-G02-layout' 'Episode 01' 'Start campaign' 'Club Madeira' '#FF0000' -CtaPadLeft 8

# T-G03: invented Admin nav + ACME logo text
Write-UiPng 'fixtures/T-G03-hallucination' 'Episode 01' 'Start campaign' 'Admin | ACME Corp' '#0A5C3A'

# T-A01: wrong hex only (bar #1122FF vs #0A5C3A)
Write-UiPng 'fixtures/T-A01-wrong-hex' 'Episode 01' 'Start campaign' 'Club Madeira' '#1122FF'

# T-A02: 1px-class misalignment — CTA at x=23 not 24
Write-UiPng 'fixtures/T-A02-1px' 'Episode 01' 'Start campaign' 'Club Madeira' '#0A5C3A' -CtaPadLeft 23

# T-A03: invented logo wordmark
Write-UiPng 'fixtures/T-A03-invented-logo' 'Episode 01' 'Start campaign' 'Club Madeira  |  NITSA UK' '#0A5C3A'

# T-G04: overlap — CTA drawn over title (violates brief no-intersection)
function Write-OverlapPng {
    $dir = Join-Path $root 'fixtures/T-G04-overlap'
    if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir | Out-Null }
    $path = Join-Path $dir 'screenshot.png'
    $bmp = New-Object System.Drawing.Bitmap 480, 160
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.Clear([System.Drawing.Color]::FromArgb(255, 248, 248, 246))
    $bar = [System.Drawing.ColorTranslator]::FromHtml('#0A5C3A')
    $g.FillRectangle((New-Object System.Drawing.SolidBrush $bar), 0, 0, 480, 36)
    $white = [System.Drawing.Brushes]::White
    $ink = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(255, 24, 24, 24))
    $g.DrawString('Club Madeira', $small, $white, 12, 8)
    $g.DrawString('Episode 01', $font, $ink, 16, 52)
    $g.FillRectangle((New-Object System.Drawing.SolidBrush $bar), 24, 48, 180, 44)
    $g.DrawString('Start campaign', $small, $white, 36, 58)
    $g.Dispose()
    $bmp.Save($path, [System.Drawing.Imaging.ImageFormat]::Png)
    $bmp.Dispose()
    Write-Output $path
}
Write-OverlapPng

# T-A00: clean control — matches brief
Write-UiPng 'fixtures/T-A00-clean' 'Episode 01' 'Start campaign' 'Club Madeira' '#0A5C3A' -CtaPadLeft 24

$font.Dispose()
$small.Dispose()
Write-Output 'New-GoldenFixturePngs: OK'
