# Validates fixture pack schema (P1 #3 + absorbed #5). Exit 0 on success.
$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
$fixRoot = Join-Path $root 'fixtures'

$required = @(
    'T-G01-spelling',
    'T-G02-layout',
    'T-G03-hallucination',
    'T-A00-clean',
    'T-A01-wrong-hex',
    'T-A02-1px',
    'T-A03-invented-logo'
)

function Get-YamlScalar([string]$text, [string]$key) {
    if ($text -match "(?m)^${key}:\s*(.+?)\s*$") { return $Matches[1].Trim() }
    return $null
}

function Get-NitBlocks([string]$text) {
    $idx = $text.IndexOf("nits:")
    if ($idx -lt 0) { return @() }
    return $text.Substring($idx)
}

foreach ($id in $required) {
    $dir = Join-Path $fixRoot $id
    foreach ($rel in @('brief.md', 'screenshot.png', 'expected-nits.yaml')) {
        $p = Join-Path $dir $rel
        if (-not (Test-Path $p)) {
            Write-Error "Missing: fixtures/$id/$rel"
            exit 1
        }
    }
    $yamlPath = Join-Path $dir 'expected-nits.yaml'
    $yaml = Get-Content $yamlPath -Raw
    $case = Get-YamlScalar $yaml 'case'
    if ($case -ne $id) {
        Write-Error "fixtures/$id/expected-nits.yaml case=$case expected $id"
        exit 1
    }
    $nits = Get-NitBlocks $yaml
    if ($id -eq 'T-A00-clean') {
        if ($nits -notmatch 'nits:\s*\[\s*\]') {
            Write-Error "T-A00-clean must have nits: []"
            exit 1
        }
        continue
    }
    if ($nits -notmatch '(?m)^\s+-\s+gate:\s+(G1|G2|G3|brief)\s*$') {
        Write-Error "fixtures/$id expected at least one nit with gate G1|G2|G3|brief"
        exit 1
    }
}

$g01 = Get-Content (Join-Path $fixRoot 'T-G01-spelling\expected-nits.yaml') -Raw
if ($g01 -notmatch 'gate:\s+G1' -or $g01 -notmatch 'class:\s+spelling') {
    Write-Error 'T-G01-spelling must declare G1 spelling'
    exit 1
}
$g02 = Get-Content (Join-Path $fixRoot 'T-G02-layout\expected-nits.yaml') -Raw
if ($g02 -notmatch 'gate:\s+G2' -or $g02 -notmatch '24px' -or $g02 -notmatch '#0A5C3A') {
    Write-Error 'T-G02-layout must declare G2 px/hex vs brief'
    exit 1
}
$g03 = Get-Content (Join-Path $fixRoot 'T-G03-hallucination\expected-nits.yaml') -Raw
if ($g03 -notmatch 'gate:\s+G3' -or $g03 -notmatch 'NOT_IN_BRIEF') {
    Write-Error 'T-G03-hallucination must declare G3 NOT_IN_BRIEF'
    exit 1
}

Write-Output 'Validate-DesignUatFixtures: OK'
exit 0
