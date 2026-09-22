# Validates design-uat repo structure (BT0). Exit 0 on success.
$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot

function Require-File($rel) {
    $p = Join-Path $root $rel
    if (-not (Test-Path $p)) {
        Write-Error "Missing: $rel"
        exit 1
    }
}

Require-File '.grok\skills\design-uat\SKILL.md'
Require-File '.grok\skills\pdf-uat\SKILL.md'
Require-File '.grok\skills\illustrator-uat\SKILL.md'
Require-File '.grok\skills\graphics-uat\SKILL.md'
Require-File 'docs\feature-request-harvest-pdf-illustrator-graphics-2026-09-22.md'
Require-File 'docs\fixtures\g1-svg-misspell.svg'
Require-File 'docs\functional-spec.md'
Require-File 'docs\feature-request-design-uat-skill-2026-09-22.md'
Require-File 'docs\build-and-test-plan.md'
Require-File 'docs\templates\design-uat-report.md'
Require-File 'docs\expected-nits.schema.md'
Require-File '.github\workflows\bt0.yml'
Require-File 'tools\Install-DesignUatSkill.ps1'

$skill = Get-Content (Join-Path $root '.grok\skills\design-uat\SKILL.md') -Raw
foreach ($needle in @(
        'name: design-uat', 'G1', 'G2', 'G3', 'ready for human UAT',
        'Severity rubric', 'Per-image walk',
        'Fail-closed', 'delta_px', 'Inventory',
        'pdf-uat', 'illustrator-uat', 'graphics-uat'
    )) {
    if ($skill -notmatch [regex]::Escape($needle)) {
        Write-Error "SKILL.md missing expected text: $needle"
        exit 1
    }
}

$schema = Get-Content (Join-Path $root 'docs\expected-nits.schema.md') -Raw
foreach ($needle in @('delta_px', 'delta_hex', 'inventory', 'NOT_IN_BRIEF', 'fail-closed')) {
    if ($schema -notmatch [regex]::Escape($needle)) {
        Write-Error "expected-nits.schema.md missing expected text: $needle"
        exit 1
    }
}

$scanFiles = @(
    'docs\functional-spec.md',
    '.grok\skills\design-uat\SKILL.md',
    'docs\build-and-test-plan.md',
    'docs\feature-request-design-uat-skill-2026-09-22.md'
)
$secretPatterns = @(
    '(?i)(?:^|[;\s])(?:password|XAI_API_KEY)\s*=\s*[''"]?[a-zA-Z0-9_./+-]{8,}'
)
foreach ($rel in $scanFiles) {
    $f = Join-Path $root $rel
    if (-not (Test-Path $f)) { continue }
    $text = Get-Content $f -Raw
    foreach ($pat in $secretPatterns) {
        if ($text -match $pat) {
            Write-Error "Forbidden secret assignment pattern in ${rel}: $pat"
            exit 1
        }
    }
}

Write-Output 'Validate-DesignUatSkill: OK'
exit 0
