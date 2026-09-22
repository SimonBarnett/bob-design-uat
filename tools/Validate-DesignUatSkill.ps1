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
Require-File '.grok\skills\pdf-design\SKILL.md'
Require-File '.grok\skills\illustrator-design\SKILL.md'
Require-File '.grok\skills\graphics-design\SKILL.md'
Require-File 'docs\functional-spec.md'
Require-File 'docs\feature-request-design-uat-skill-2026-09-22.md'
Require-File 'docs\feature-request-golden-fixture-pack-2026-09-22.md'
Require-File 'docs\feature-request-hallucination-inventory-2026-09-22.md'
Require-File 'docs\feature-request-pixel-perfect-deltas-2026-09-22.md'
Require-File 'docs\feature-request-pdf-illustrator-graphics-skills-2026-09-22.md'
Require-File 'docs\build-and-test-plan.md'
Require-File 'docs\templates\design-uat-report.md'
Require-File 'docs\expected-nits.schema.md'
Require-File '.github\workflows\bt0.yml'
Require-File 'tools\Install-DesignUatSkill.ps1'
Require-File 'docs\feature-request-three-gates-2026-09-22.md'
Require-File 'fixtures\README.md'

$skill = Get-Content (Join-Path $root '.grok\skills\design-uat\SKILL.md') -Raw
foreach ($needle in @(
        'name: design-uat', 'G1', 'G2', 'G3', 'OCR', 'ready for human UAT',
        'Severity rubric', 'Per-image walk',
        'Fail-closed', 'Deltas (#8)', 'delta_px', 'Inventory', 'NOT_IN_BRIEF',
        'chrome', 'copy', 'image', 'flow',
        'pdf-design', 'illustrator-design', 'graphics-design'
    )) {
    if ($skill -notmatch [regex]::Escape($needle)) {
        Write-Error "SKILL.md missing expected text: $needle"
        exit 1
    }
}

foreach ($pair in @(
        @{ rel = '.grok\skills\pdf-design\SKILL.md'; name = 'pdf-design' },
        @{ rel = '.grok\skills\illustrator-design\SKILL.md'; name = 'illustrator-design' },
        @{ rel = '.grok\skills\graphics-design\SKILL.md'; name = 'graphics-design' }
    )) {
    $text = Get-Content (Join-Path $root $pair.rel) -Raw
    foreach ($needle in @("name: $($pair.name)", 'design-uat', 'G1', 'ready for human UAT')) {
        if ($text -notmatch [regex]::Escape($needle)) {
            Write-Error "$($pair.rel) missing expected text: $needle"
            exit 1
        }
    }
}

$report = Get-Content (Join-Path $root 'docs\templates\design-uat-report.md') -Raw
foreach ($needle in @(
        'G3 inventory (required)', 'in_brief', 'NOT_IN_BRIEF',
        'chrome / copy / image / flow'
    )) {
    if ($report -notmatch [regex]::Escape($needle)) {
        Write-Error "design-uat-report.md missing T-S07 text: $needle"
        exit 1
    }
}

$schema = Get-Content (Join-Path $root 'docs\expected-nits.schema.md') -Raw
foreach ($needle in @('G2 deltas (#8)', 'G3 inventory (#7)', 'delta_px', 'delta_hex', 'inventory', 'NOT_IN_BRIEF', 'fail-closed')) {
    if ($schema -notmatch [regex]::Escape($needle)) {
        Write-Error "expected-nits.schema.md missing expected text: $needle"
        exit 1
    }
}

foreach ($needle in @('delta_px', 'delta_hex')) {
    if ($report -notmatch [regex]::Escape($needle)) {
        Write-Error "design-uat-report.md missing T-S08 text: $needle"
        exit 1
    }
}

$scanFiles = @(
    'docs\functional-spec.md',
    '.grok\skills\design-uat\SKILL.md',
    '.grok\skills\pdf-design\SKILL.md',
    '.grok\skills\illustrator-design\SKILL.md',
    '.grok\skills\graphics-design\SKILL.md',
    'docs\build-and-test-plan.md',
    'docs\feature-request-design-uat-skill-2026-09-22.md',
    'docs\feature-request-hallucination-inventory-2026-09-22.md',
    'docs\feature-request-pixel-perfect-deltas-2026-09-22.md',
    'docs\feature-request-pdf-illustrator-graphics-skills-2026-09-22.md'
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

$fx = Join-Path $PSScriptRoot 'Validate-DesignUatFixtures.ps1'
& powershell -NoProfile -ExecutionPolicy Bypass -File $fx
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

Write-Output 'Validate-DesignUatSkill: OK'
exit 0
