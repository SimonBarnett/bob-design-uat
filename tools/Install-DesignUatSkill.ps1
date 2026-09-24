# Copy design-uat + companion skills into ~/.grok/skills (local Bob).
$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
$names = @('design-uat', 'playwright-design', 'pdf-design', 'illustrator-design', 'graphics-design', 'mrb-project-management', 'harvest-agent-skills')
foreach ($name in $names) {
    $src = Join-Path $root ".grok\skills\$name"
    $dest = Join-Path $HOME ".grok\skills\$name"
    if (-not (Test-Path $src)) {
        Write-Error "Missing skill source: $src"
        exit 1
    }
    New-Item -ItemType Directory -Force -Path $dest | Out-Null
    Copy-Item -Force (Join-Path $src 'SKILL.md') (Join-Path $dest 'SKILL.md')
    Write-Output "Installed $name -> $dest"
}
exit 0
