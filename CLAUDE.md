# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

A personal collection of Claude Code **skills** — self-contained directories loaded on demand
via `/skill-name` to extend Claude's behavior with domain-specific knowledge or tightly scoped
workflows. Skills live here in version control and are deployed to `~/.claude/skills/` (or a
custom target) via `skills.ps1`.

## Commands

All management goes through `skills.ps1` (PowerShell 7+, uses `robocopy` for sync):

```powershell
.\skills.ps1 list                                  # list skills available in this repo
.\skills.ps1 status                                # compare repo skills vs deployed target
.\skills.ps1 deploy                                # sync all skills to ~/.claude/skills/
.\skills.ps1 deploy -Skills commit,memory-architect # sync specific skills only
.\skills.ps1 deploy -Dest C:\path\to\target          # sync to a custom target
.\skills.ps1 deploy -DryRun                          # preview without writing
.\skills.ps1 help <command>                          # full options/examples for a command
```

`deploy` mirrors each skill directory (`/MIR`) into the target — additions, edits, and
deletions inside a skill are synced. Skills already in the target but absent from this repo
are left untouched (reported as `external` by `status`). There is no build, lint, or test
suite for the PowerShell tooling itself; verify changes to `skills.ps1` by running the
relevant command with `-DryRun` first.

Some skills ship their own Python scripts run via `uv run` (see `write-plan/scripts/`) —
those are invoked by the skill's own instructions, not by any repo-level command.

## Architecture: skill anatomy

Each top-level directory (except `.claude/`, `.git/`) is one deployable skill:

```
<skill-name>/
  SKILL.md              # required — frontmatter (name, description, allowed-tools,
                         #   argument-hint) + the instructions Claude follows when invoked
  references/*.md        # optional — supporting docs the skill reads on demand, not
                         #   preloaded (keeps SKILL.md itself lean)
  scripts/*.py            # optional — mechanical helpers a skill shells out to (validation,
                         #   scaffolding); Claude follows the script's stdout, never hand-edits
                         #   what the script owns
```

`SKILL.md` frontmatter conventions used across this repo:
- `description` states *when* to trigger, phrased so Claude's router can match on user intent
  — not just what the skill does
- `allowed-tools` restricts a skill to the minimum toolset it needs (e.g. `commit` only gets
  git subcommands; `clean-architecture` is read-only: `Read`, `Grep`)
- `argument-hint` documents the optional `$ARGUMENTS` a skill accepts

New skills should follow this same shape: a `SKILL.md` at the top, heavy reference material
split into `references/`, and any mechanically-enforced step (file scaffolding, validation)
implemented as a script rather than left to freeform generation.

## Existing skills (for context, not exhaustive detail)

- **commit** — atomic, Gitmoji-tagged commits; hard rules against `git add -A`, `--amend`,
  `--no-verify`, and mixed-concern commits.
- **clean-architecture** — read-only knowledge base (34 chapters + glossary/patterns/cheatsheet)
  from Robert C. Martin's *Clean Architecture*.
- **memory-architect** — analyzes and reorganizes a *target* project's `CLAUDE.md` /
  `.claude/rules/` files (three-phase: analyze → propose → execute on confirmation). Its
  `references/structure-guide.md` defines the thresholds and file formats it enforces
  elsewhere — treat that file as the source of truth if asked to reorganize memory here too.
  Note: this repo's own `CLAUDE.md` is intentionally short-form documentation, not a target
  for that skill's split thresholds.
- **brainstorm** — pure discovery conversation that runs *before* `write-plan`. Explores
  project context, asks scoping questions one at a time (multiple-choice via
  `AskUserQuestion`), and ends at a confirmed Understanding card (Problem/Non-Goals/Affected
  Areas/Success Criteria/Effort + slug) persisted to the target project's
  `docs/plans/.brainstorm/<slug>.md` via its own `scripts/create_card.py` — the skill's only
  write path (otherwise read-only + `AskUserQuestion`). Never writes plan files or code.
- **write-plan** — governs writing/updating technical plans under a *target* project's
  `docs/plans/`. Delegates all discovery/scoping to `brainstorm` (invoking it unless a
  confirmed card file already exists for the slug), then runs approach exploration,
  design, scaffolding, and a Draft → Reviewed → Implemented → Archived lifecycle with
  mechanical validation via its own `scripts/create_plan.py` / `generate_index.py` /
  `validate_plan.py`. `create_plan.py` enforces the brainstorm gate mechanically: it
  refuses to scaffold without a confirmed card, pre-fills the plan from it, then deletes
  it (the plan becomes the single source of truth). `_index.md` is always generated,
  never hand-edited.

When modifying a skill's `SKILL.md`, keep the frontmatter `description` accurate — that field
is what determines whether Claude reaches for the skill in an unrelated conversation.
