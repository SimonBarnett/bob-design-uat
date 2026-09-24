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
Require-File '.grok\skills\playwright-design\SKILL.md'
Require-File '.grok\skills\mrb-project-management\SKILL.md'
Require-File '.grok\skills\uat-video-pack\SKILL.md'
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
Require-File 'docs\feature-request-playwright-visual-uat-2026-09-22.md'
Require-File 'docs\feature-request-mrb-project-management-harvest-2026-09-22.md'
Require-File 'docs\feature-request-screen-layout-overlap-2026-09-22.md'
Require-File 'docs\jester-uat-video-pack-harvest-2026-09-24.md'
Require-File 'fixtures\README.md'
Require-File 'tools\LayoutOverlap-PlaywrightHook.example.mjs'

$skill = Get-Content (Join-Path $root '.grok\skills\design-uat\SKILL.md') -Raw
foreach ($needle in @(
        'name: design-uat', 'G1', 'G2', 'G3', 'OCR', 'ready for human UAT',
        'Severity rubric', 'Per-image walk',
        'Fail-closed', 'Deltas (#8)', 'delta_px', 'Inventory', 'NOT_IN_BRIEF',
        'chrome', 'copy', 'image', 'flow',
        'playwright-design', 'pdf-design', 'illustrator-design', 'graphics-design', 'mrb-project-management', 'uat-video-pack',
        'Overlap (#71)', 'T-G04-overlap'
    )) {
    if ($skill -notmatch [regex]::Escape($needle)) {
        Write-Error "SKILL.md missing expected text: $needle"
        exit 1
    }
}

foreach ($pair in @(
        @{ rel = '.grok\skills\playwright-design\SKILL.md'; name = 'playwright-design' },
        @{ rel = '.grok\skills\pdf-design\SKILL.md'; name = 'pdf-design' },
        @{ rel = '.grok\skills\illustrator-design\SKILL.md'; name = 'illustrator-design' },
        @{ rel = '.grok\skills\graphics-design\SKILL.md'; name = 'graphics-design' }
    )) {
    $text = Get-Content (Join-Path $root $pair.rel) -Raw
    $needles = @("name: $($pair.name)", 'design-uat', 'G1', 'ready for human UAT')
    if ($pair.name -eq 'playwright-design') {
        $needles += @('Layout overlap', 'T-G04-overlap', 'LayoutOverlap-PlaywrightHook.example.mjs')
    }
    foreach ($needle in $needles) {
        if ($text -notmatch [regex]::Escape($needle)) {
            Write-Error "$($pair.rel) missing expected text: $needle"
            exit 1
        }
    }
}

$mrbPm = Get-Content (Join-Path $root '.grok\skills\mrb-project-management\SKILL.md') -Raw
foreach ($needle in @(
        'name: mrb-project-management', 'bob-hostile-mrb', 'feature-request',
        'Validate-DesignUatSkill.ps1', 'ready for human UAT', 'build-and-test-plan.md'
    )) {
    if ($mrbPm -notmatch [regex]::Escape($needle)) {
        Write-Error "mrb-project-management SKILL.md missing expected text: $needle"
        exit 1
    }
}

$uatVideo = Get-Content (Join-Path $root '.grok\skills\uat-video-pack\SKILL.md') -Raw
foreach ($needle in @(
        'name: uat-video-pack', 'human speed', 'draw_mouse', 'ready for human UAT', 'design-uat'
    )) {
    if ($uatVideo -notmatch [regex]::Escape($needle)) {
        Write-Error "uat-video-pack SKILL.md missing expected text: $needle"
        exit 1
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
    '.grok\skills\playwright-design\SKILL.md',
    '.grok\skills\mrb-project-management\SKILL.md',
    '.grok\skills\uat-video-pack\SKILL.md',
    'docs\build-and-test-plan.md',
    'docs\feature-request-design-uat-skill-2026-09-22.md',
    'docs\feature-request-hallucination-inventory-2026-09-22.md',
    'docs\feature-request-pixel-perfect-deltas-2026-09-22.md',
    'docs\feature-request-pdf-illustrator-graphics-skills-2026-09-22.md',
    'docs\feature-request-playwright-visual-uat-2026-09-22.md',
    'docs\feature-request-mrb-project-management-harvest-2026-09-22.md',
    'docs\feature-request-screen-layout-overlap-2026-09-22.md',
    'docs\jester-uat-video-pack-harvest-2026-09-24.md'
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
