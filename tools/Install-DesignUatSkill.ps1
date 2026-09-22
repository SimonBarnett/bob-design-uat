# Copy design-uat skill into the current user's ~/.grok/skills (local Bob).
$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
$src = Join-Path $root '.grok\skills\design-uat'
$dest = Join-Path $HOME '.grok\skills\design-uat'
if (-not (Test-Path $src)) {
    Write-Error "Missing skill source: $src"
    exit 1
}
New-Item -ItemType Directory -Force -Path $dest | Out-Null
Copy-Item -Force (Join-Path $src 'SKILL.md') (Join-Path $dest 'SKILL.md')
Write-Output "Installed design-uat -> $dest"
exit 0
