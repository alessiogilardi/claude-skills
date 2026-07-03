# claude-skills

A personal collection of Claude Code skills. Each skill is a self-contained
directory that Claude can load on demand via `/skill-name` to extend its
behaviour with domain-specific knowledge or tightly scoped workflows.

Skills live here in version control and are deployed to `~/.claude/skills/`
with the included [`skills.ps1`](#skillsps1) CLI.

---

## Skills

### `commit`

Enforces atomic, well-scoped git commits.
Trigger: `/commit`

Groups modified files by logical responsibility (not by folder), stages each
group independently, and writes a Gitmoji commit message in imperative mood.
Hard rules: never uses `git add .`, never mixes concerns in a single commit,
never appends AI attribution trailers.

---

### `clean-architecture`

Knowledge base from *Clean Architecture* by Robert C. Martin (Uncle Bob).
Trigger: `/clean-architecture [topic | chapter | pattern]`

Covers the full 34-chapter book: Dependency Rule, the four rings, SOLID
principles, component cohesion and coupling, boundary anatomy, and the
case-study chapters. Without arguments it loads the core frameworks; with a
topic (`DIP`, `boundaries`, `ch22`, …) it reads the relevant chapter file
before answering.

---

### `memory-architect`

Analyzes and reorganizes Claude Code memory files to reduce context-window
bloat.
Trigger: `/memory-architect`

Three-phase workflow: (1) read and measure every `CLAUDE.md` and
`.claude/rules/*.md`; (2) propose a split plan and wait for explicit
confirmation; (3) execute the restructuring without losing any content.
Also passively flags oversized files and duplicated rules during normal work.

---

## `skills.ps1`

A PowerShell 7 CLI for managing skill deployments.

### Prerequisites

- PowerShell 7+ (`pwsh`)
- `robocopy` (included with Windows)

### Commands

```
.\skills.ps1 <command> [options]

  deploy   Sync skills from this repo to the target directory
  list     List skills available in this repo
  status   Compare repo skills against the deployed target
  help     Show help, or details for a specific command
```

Run `.\skills.ps1 help <command>` for full options and examples.

### Deploy all skills

```powershell
.\skills.ps1 deploy
```

Mirrors every skill directory into `~/.claude/skills/` using `robocopy /MIR`.
Files added, modified, or deleted inside a skill are synced; skills not
present in this repo (e.g. skills installed from other sources) are left
untouched.

### Deploy specific skills

```powershell
.\skills.ps1 deploy -Skills commit,memory-architect
```

### Deploy to a custom location

```powershell
.\skills.ps1 deploy -Dest "C:\path\to\target"
```

### Preview without writing

```powershell
.\skills.ps1 deploy -DryRun
.\skills.ps1 deploy -Skills clean-architecture -DryRun
```

### Check sync status

```powershell
.\skills.ps1 status
```

Reports each skill as one of:

| Symbol | Meaning |
|--------|---------|
| `[+]` | Up to date — all files match |
| `[~]` | Modified — one or more files differ from the target |
| `[?]` | Not deployed — skill directory does not exist in target |
| `[o]` | External — present in target but not managed by this repo |

### List available skills

```powershell
.\skills.ps1 list
```
