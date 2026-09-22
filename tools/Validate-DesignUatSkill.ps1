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
Require-File 'docs\functional-spec.md'
Require-File 'docs\feature-request-design-uat-skill-2026-09-22.md'
Require-File 'docs\build-and-test-plan.md'
Require-File 'docs\templates\design-uat-report.md'
Require-File 'fixtures\brief.md'
Require-File 'fixtures\expected-nits.yaml'
Require-File 'fixtures\clean-control.png'
Require-File 'fixtures\g1-spelling.png'
Require-File 'fixtures\g2-layout-color.png'
Require-File 'fixtures\g3-hallucination.png'
Require-File 'fixtures\README.md'
Require-File 'tools\make_golden_fixtures.py'

$skill = Get-Content (Join-Path $root '.grok\skills\design-uat\SKILL.md') -Raw
foreach ($needle in @('name: design-uat', 'G1', 'G2', 'G3', 'ready for human UAT')) {
    if ($skill -notmatch [regex]::Escape($needle)) {
        Write-Error "SKILL.md missing expected text: $needle"
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
