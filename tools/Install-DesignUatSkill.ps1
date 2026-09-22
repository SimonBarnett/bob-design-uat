# Copy design-uat + pdf/illustrator/graphics skills into ~/.grok/skills.
$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
$names = @('design-uat', 'pdf-uat', 'illustrator-uat', 'graphics-uat')
foreach ($name in $names) {
    $src = Join-Path $root ".grok\skills\$name"
    $dest = Join-Path $HOME ".grok\skills\$name"
    if (-not (Test-Path (Join-Path $src 'SKILL.md'))) {
        Write-Error "Missing skill source: $src\SKILL.md"
        exit 1
    }
    New-Item -ItemType Directory -Force -Path $dest | Out-Null
    Copy-Item -Force (Join-Path $src 'SKILL.md') (Join-Path $dest 'SKILL.md')
    Write-Output "Installed $name -> $dest"
}
exit 0
