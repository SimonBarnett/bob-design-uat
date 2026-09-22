# Validates design-uat repo structure (BT0). Exit 0 on success.
$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
if (-not (Test-Path (Join-Path $root '.grok\skills\design-uat\SKILL.md'))) {
    $root = Split-Path -Parent $PSScriptRoot
}
$fail = 0

function Require-File($rel) {
    $p = Join-Path $root $rel
    if (-not (Test-Path $p)) {
        Write-Error "Missing: $rel"
        $script:fail = 1
    }
}

Require-File '.grok\skills\design-uat\SKILL.md'
Require-File 'docs\functional-spec.md'
Require-File 'docs\feature-request-design-uat-skill-2026-09-22.md'
Require-File 'docs\build-and-test-plan.md'
Require-File 'docs\templates\design-uat-report.md'

$skill = Get-Content (Join-Path $root '.grok\skills\design-uat\SKILL.md') -Raw
foreach ($needle in @('name: design-uat', 'G1', 'G2', 'G3', 'ready for human UAT')) {
    if ($skill -notmatch [regex]::Escape($needle)) {
        Write-Error "SKILL.md missing expected text: $needle"
        $fail = 1
    }
}
if ($skill -match '(?i)workers.*stamp.*ready for human UAT') {
    Write-Error 'SKILL.md must not instruct workers to stamp ready for human UAT'
    $fail = 1
}

$forbidden = @(
    (Join-Path $root 'docs\functional-spec.md'),
    (Join-Path $root '.grok\skills\design-uat\SKILL.md'),
    (Join-Path $root 'docs\build-and-test-plan.md')
)
$secretPatterns = @('password\s*=', 'XAI_API_KEY\s*=')
foreach ($f in $forbidden) {
    if (-not (Test-Path $f)) { continue }
    $text = Get-Content $f -Raw
    foreach ($pat in $secretPatterns) {
        if ($text -match $pat) {
            Write-Error "Forbidden secret assignment pattern in $(Split-Path $f -Leaf): $pat"
            $fail = 1
        }
    }
}

if ($fail -ne 0) { exit 1 }
Write-Output 'Validate-DesignUatSkill: OK'
exit 0
