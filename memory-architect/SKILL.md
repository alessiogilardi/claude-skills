---
name: memory-architect
description: >
  Analyzes and reorganizes Claude Code memory files (CLAUDE.md and .claude/rules/)
  to optimize context window usage. Use this skill when the user asks to reorganize,
  split, optimize, or refactor project memory, or when a CLAUDE.md exceeds 200 lines,
  contains heterogeneous thematic blocks, or includes rules that only apply to specific
  paths. Typical triggers: "reorganize CLAUDE.md", "split the instructions", "optimize
  memory", "my CLAUDE.md is too long", "how do I organize Claude Code rules".
---

# Memory Architect

Three-phase workflow to analyze and reorganize Claude Code memory files.
Read `references/structure-guide.md` for file format details and thresholds.

---

## Phase 1 — Analysis (read only, no changes)

Read all existing memory files in order:
1. `~/.claude/CLAUDE.md` (global user config, if accessible)
2. `CLAUDE.md` in the project root
3. All files under `.claude/rules/*.md`
4. Every file referenced via `@path` in the above files

For each file, calculate and note:
- Total line count
- Number of distinct thematic blocks (e.g. code style, testing, architecture, commands)
- Whether it contains rules that mention specific paths (`src/api/`, `tests/`, etc.)
- Whether it contains personal preferences (tools, test runner, output verbosity)

Identify **split signals** — see `references/structure-guide.md#thresholds`.

---

## Phase 2 — Proposal (show the plan, do not modify anything)

Present the plan in the format below, then wait for explicit confirmation:

```
REORGANIZATION PLAN
───────────────────
Files analyzed: [list with line count for each]

Proposed structure:
  CLAUDE.md                      ← index + core instructions  (target: < 60 lines)
  .claude/rules/[domain-a].md    ← [content description]
  .claude/rules/[domain-b].md    ← [content description, path-scoped if applicable]
  CLAUDE.local.md                ← personal preferences (gitignored)  [only if needed]

Rationale:
  - "[block name]" → rules/[file].md because [specific reason]
  - "[block name]" → path-scoped because it only applies to [path]
  - "[block name]" → CLAUDE.local.md because it is a personal preference

Proceed? (yes / modify the plan / cancel)
```

Do not proceed without explicit confirmation. If the user modifies the plan,
restate it and ask for confirmation again before executing.

---

## Phase 3 — Execution (only after confirmation)

Execute in strict order:

**1. Create destination files first**
Never delete or overwrite the source until all content has been written to the new files.

**2. Write `.claude/rules/*.md` files**
Consult `references/structure-guide.md#formats` for the exact syntax of:
- Files without path-scope (always loaded)
- Files with path-scope (loaded only for matching files, require YAML frontmatter)

**3. Update root `CLAUDE.md`**
Reduce to a clean index with core instructions only. Files in `.claude/rules/` load
automatically — do not add `@path` imports for them. Use `@path` only for files
outside `.claude/rules/` (e.g. architecture docs, ADRs).

**4. Handle `CLAUDE.local.md`**
If needed, create the file and automatically add it to `.gitignore`. Inform the user
that this file is excluded from version control.

**5. Final verification**
After writing all files, re-read each one and verify:
- No content was lost compared to the original files
- Root `CLAUDE.md` is under 60 lines
- No `.claude/rules/*.md` exceeds 150 lines
- Path-scoped files have correct YAML frontmatter
- No duplicate rules exist across files

Show a summary of created/modified files with the line-count delta from the initial state.

---

## Passive monitoring

During normal work (outside this skill), if you notice any of the signals below,
flag it to the user with a short message — do not execute anything automatically:

| Condition | Message |
|---|---|
| CLAUDE.md > 200 lines | "CLAUDE.md exceeds 200 lines. Would you like me to reorganize it?" |
| Thematic block > 50 lines in an already large file | "This block could become a separate file under `.claude/rules/`." |
| Path-specific rule in root CLAUDE.md | "This rule only applies to [path] — want to move it to a path-scoped rule?" |
| Same rule duplicated across two files | "Found a duplication between [file A] and [file B]." |
