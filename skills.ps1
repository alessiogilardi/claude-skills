#Requires -Version 7
<#
.SYNOPSIS
    Manage Claude skill deployments.
.DESCRIPTION
    A CLI tool to deploy, inspect, and track Claude skills from this repo
    into the target directory (default: ~/.claude/skills).
.EXAMPLE
    .\skills.ps1 deploy
.EXAMPLE
    .\skills.ps1 deploy -Skills commit,memory-architect -DryRun
.EXAMPLE
    .\skills.ps1 status -Dest C:\custom\skills
#>
[CmdletBinding()]
param(
    [Parameter(Position = 0)]
    [string] $Command = 'help',

    [Parameter(Position = 1)]
    [string] $Topic = '',

    # deploy / status options
    [string] $Skills = '',
    [string] $Dest   = '',
    [switch] $DryRun
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

# ---------------------------------------------------------------------------
# Constants
# ---------------------------------------------------------------------------

$SCRIPT_NAME  = Split-Path -Leaf $PSCommandPath
$REPO_ROOT    = $PSScriptRoot
$DEFAULT_DEST = Join-Path $env:USERPROFILE '.claude\skills'
$SKIP_DIRS    = @('.claude', '.git')

# ---------------------------------------------------------------------------
# Output helpers
# ---------------------------------------------------------------------------

function Write-Rule {
    param([int] $Width = 52)
    Write-Host ('─' * $Width) -ForegroundColor DarkGray
}

function Write-Ok   ([string] $Msg) { Write-Host $Msg -ForegroundColor Green    }
function Write-Warn ([string] $Msg) { Write-Host $Msg -ForegroundColor Yellow   }
function Write-Err  ([string] $Msg) { Write-Host $Msg -ForegroundColor Red      }
function Write-Hi   ([string] $Msg) { Write-Host $Msg -ForegroundColor Cyan     }
function Write-Dim  ([string] $Msg) { Write-Host $Msg -ForegroundColor DarkGray }

# ---------------------------------------------------------------------------
# Shared utilities
# ---------------------------------------------------------------------------

function Get-RepoSkills {
    Get-ChildItem -Path $REPO_ROOT -Directory |
        Where-Object { $_.Name -notin $SKIP_DIRS } |
        Sort-Object Name
}

function Resolve-SkillFilter ($Filter, $AllSkills) {
    $filterList = @(@($Filter) | Where-Object { $_ })
    if ($filterList.Count -eq 0) { return $AllSkills }

    $allNames = @($AllSkills | ForEach-Object { $_.Name })
    $unknown  = $filterList | Where-Object { $_ -notin $allNames }
    if ($unknown) {
        foreach ($u in $unknown) { Write-Err "  error: skill not found in repo: '$u'" }
        Write-Host ''
        Write-Dim "  Available: $($allNames -join ', ')"
        Write-Host ''
        exit 1
    }

    return $AllSkills | Where-Object { $_.Name -in $filterList }
}

function Get-SyncStatus ([string] $SourcePath, [string] $DestPath) {
    if (-not (Test-Path $DestPath)) { return 'not-deployed' }

    foreach ($file in Get-ChildItem -Path $SourcePath -Recurse -File) {
        $rel      = $file.FullName.Substring($SourcePath.Length)
        $destFile = Join-Path $DestPath $rel
        if (-not (Test-Path $destFile)) { return 'modified' }
        $srcHash  = (Get-FileHash $file.FullName  -Algorithm MD5).Hash
        $dstHash  = (Get-FileHash $destFile -Algorithm MD5).Hash
        if ($srcHash -ne $dstHash) { return 'modified' }
    }

    return 'up-to-date'
}

# ---------------------------------------------------------------------------
# Command: help
# ---------------------------------------------------------------------------

function Invoke-Help ([string] $Topic) {
    Write-Host ''

    switch ($Topic.ToLower()) {

        'deploy' {
            Write-Ok   "  deploy"
            Write-Dim  "  Sync skills from this repo into the target directory."
            Write-Dim  "  Uses robocopy /MIR per skill: additions, updates and deletions"
            Write-Dim  "  inside a skill are synced. Skills not in this repo are untouched."
            Write-Host ''
            Write-Rule
            Write-Host ''
            Write-Host "  Usage"
            Write-Hi   "    .\$SCRIPT_NAME deploy [options]"
            Write-Host ''
            Write-Host "  Options"
            Write-Hi   "    -Skills <n1,n2,...>  Skills to deploy (default: all)"
            Write-Hi   "    -Dest   <path>       Target directory  (default: ~/.claude/skills)"
            Write-Hi   "    -DryRun              Preview changes without writing anything"
            Write-Host ''
            Write-Host "  Examples"
            Write-Dim  "    .\$SCRIPT_NAME deploy"
            Write-Dim  "    .\$SCRIPT_NAME deploy -Skills commit,memory-architect"
            Write-Dim  "    .\$SCRIPT_NAME deploy -Dest C:\my\skills"
            Write-Dim  "    .\$SCRIPT_NAME deploy -Skills clean-architecture -DryRun"
            Write-Host ''
        }

        'list' {
            Write-Ok   "  list"
            Write-Dim  "  List all skills available in this repo."
            Write-Host ''
            Write-Rule
            Write-Host ''
            Write-Host "  Usage"
            Write-Hi   "    .\$SCRIPT_NAME list"
            Write-Host ''
        }

        'status' {
            Write-Ok   "  status"
            Write-Dim  "  Compare each repo skill against the deployed target."
            Write-Dim  "  Also reports skills in the target that are not in this repo."
            Write-Host ''
            Write-Rule
            Write-Host ''
            Write-Host "  Usage"
            Write-Hi   "    .\$SCRIPT_NAME status [-Dest <path>]"
            Write-Host ''
            Write-Host "  Options"
            Write-Hi   "    -Dest <path>  Target directory to compare against (default: ~/.claude/skills)"
            Write-Host ''
            Write-Host "  Symbols"
            Write-Ok   "    [+]  up to date   — all files match"
            Write-Warn "    [~]  modified     — one or more files differ"
            Write-Hi   "    [?]  not deployed — skill not present in target"
            Write-Dim  "    [o]  external     — in target but not managed by this repo"
            Write-Host ''
        }

        default {
            Write-Ok   "  skills.ps1  —  Claude skills deployment CLI"
            Write-Host ''
            Write-Rule
            Write-Host ''
            Write-Host "  Usage"
            Write-Hi   "    .\$SCRIPT_NAME <command> [options]"
            Write-Host ''
            Write-Host "  Commands"
            Write-Hi   "    deploy   Sync skills from this repo to the target directory"
            Write-Hi   "    list     List skills available in this repo"
            Write-Hi   "    status   Compare repo skills against the deployed target"
            Write-Hi   "    help     Show this help, or details for a specific command"
            Write-Host ''
            Write-Host "  Run '.\$SCRIPT_NAME help <command>' for full options and examples."
            Write-Host ''
            Write-Dim  "  Default deploy target:  $DEFAULT_DEST"
            Write-Host ''
        }
    }
}

# ---------------------------------------------------------------------------
# Command: list
# ---------------------------------------------------------------------------

function Invoke-List {
    $skills = Get-RepoSkills

    Write-Host ''
    Write-Ok "  Skills in this repo  ($($skills.Count) found)"
    Write-Rule
    foreach ($s in $skills) {
        Write-Hi "    $($s.Name)"
    }
    Write-Host ''
}

# ---------------------------------------------------------------------------
# Command: status
# ---------------------------------------------------------------------------

function Invoke-Status ([string] $DestPath) {
    $repoSkills = Get-RepoSkills
    $destNames  = if (Test-Path $DestPath) {
        (Get-ChildItem -Path $DestPath -Directory | Sort-Object Name).Name
    } else { @() }

    Write-Host ''
    Write-Ok  "  Skills status"
    Write-Dim "  Dest: $DestPath"
    Write-Rule
    Write-Host ''

    $counts = @{ ok = 0; modified = 0; missing = 0; external = 0 }

    foreach ($skill in $repoSkills) {
        $skillDest = Join-Path $DestPath $skill.Name
        $sync      = Get-SyncStatus -SourcePath $skill.FullName -DestPath $skillDest

        switch ($sync) {
            'up-to-date'   {
                Write-Ok   ("  [+]  {0}" -f $skill.Name)
                $counts.ok++
            }
            'modified'     {
                Write-Warn ("  [~]  {0}" -f $skill.Name)
                $counts.modified++
            }
            'not-deployed' {
                Write-Hi   ("  [?]  {0}" -f $skill.Name)
                $counts.missing++
            }
        }
    }

    $repoNames = @($repoSkills.Name)
    foreach ($ext in ($destNames | Where-Object { $_ -notin $repoNames })) {
        Write-Dim ("  [o]  {0}  (external)" -f $ext)
        $counts.external++
    }

    Write-Host ''
    Write-Rule
    $summary = "  {0} up-to-date  |  {1} modified  |  {2} not deployed  |  {3} external" `
        -f $counts.ok, $counts.modified, $counts.missing, $counts.external
    Write-Dim $summary
    Write-Host ''
}

# ---------------------------------------------------------------------------
# Command: deploy
# ---------------------------------------------------------------------------

function Invoke-Deploy ($SkillFilter, [string] $DestPath, [bool] $IsDryRun) {
    $allSkills = Get-RepoSkills
    $targets   = @(Resolve-SkillFilter -Filter $SkillFilter -AllSkills $allSkills)
    $count     = $targets.Count

    Write-Host ''
    if ($IsDryRun) {
        Write-Warn "  [dry-run]  no changes will be written"
    }
    Write-Ok  "  Deploying $count skill(s)"
    Write-Dim "  Dest: $DestPath"
    Write-Rule
    Write-Host ''

    if (-not (Test-Path $DestPath)) {
        if ($IsDryRun) {
            Write-Dim "  would create: $DestPath"
        } else {
            New-Item -ItemType Directory -Path $DestPath -Force | Out-Null
        }
    }

    $deployed = [System.Collections.Generic.List[string]]::new()
    $errored  = [System.Collections.Generic.List[string]]::new()

    foreach ($skill in $targets) {
        $destSkill = Join-Path $DestPath $skill.Name

        if ($IsDryRun) {
            Write-Hi "    ~ $($skill.Name)"
            $deployed.Add($skill.Name)
            continue
        }

        $null = robocopy $skill.FullName $destSkill /MIR /NFL /NDL /NJH /NJS 2>&1

        if ($LASTEXITCODE -ge 8) {
            Write-Err "    x $($skill.Name)  (robocopy exit $LASTEXITCODE)"
            $errored.Add($skill.Name)
        } else {
            Write-Ok "    + $($skill.Name)"
            $deployed.Add($skill.Name)
        }
    }

    Write-Host ''
    Write-Rule

    if ($IsDryRun) {
        Write-Warn "  Would deploy $($deployed.Count) skill(s).  Run without -DryRun to apply."
    } elseif ($errored.Count -eq 0) {
        Write-Ok "  Done.  $($deployed.Count) skill(s) deployed to $DestPath"
    } else {
        Write-Warn "  $($deployed.Count) deployed, $($errored.Count) failed: $($errored -join ', ')"
    }

    Write-Host ''
    if ($errored.Count -gt 0) { exit 1 }
}

# ---------------------------------------------------------------------------
# Entry point
# ---------------------------------------------------------------------------

$resolvedDest = if ($Dest) { $Dest } else { $DEFAULT_DEST }

$skillFilter = if ($Skills) {
    @($Skills -split ',' | ForEach-Object { $_.Trim() } | Where-Object { $_ })
} else { @() }

switch ($Command.ToLower()) {
    'deploy' { Invoke-Deploy -SkillFilter $skillFilter -DestPath $resolvedDest -IsDryRun $DryRun.IsPresent }
    'list'   { Invoke-List }
    'status' { Invoke-Status -DestPath $resolvedDest }
    'help'   { Invoke-Help  -Topic $Topic }
    default  {
        Write-Host ''
        Write-Err "  error: unknown command '$Command'"
        Invoke-Help -Topic ''
        exit 1
    }
}
