# Structure Guide — Formats and Thresholds

## Thresholds

| Condition | Action |
|---|---|
| CLAUDE.md > 200 lines | Split required |
| ≥ 3 unrelated thematic blocks | Candidates for separate files |
| Rules that mention specific paths | Candidates for path-scoped rules |
| Personal preferences (tools, runner, style) | Candidates for `CLAUDE.local.md` |

Post-reorganization targets:
- Root `CLAUDE.md`: < 60 lines
- Each `.claude/rules/*.md`: < 150 lines

---

## Formats

### Root `CLAUDE.md` (after split)

```markdown
# [Project Name]

## Stack and commands
- Build: `npm run build`
- Test: `npm test`
- Dev: `npm run dev`

## Core conventions
- [Only instructions that apply everywhere, no exceptions]

## Imports

```

Files in `.claude/rules/` load automatically — no `@path` import needed for them.
Use `@path` only for files outside `.claude/rules/`.

---

### `.claude/rules/*.md` — Without path-scope

Loaded every session, for any file being edited.

```markdown
# [Domain Name]

[Rule content]
```

---

### `.claude/rules/*.md` — With path-scope

Loaded only when Claude is working on files matching the specified paths.
YAML frontmatter is required and must be the very first thing in the file.

```markdown
---
paths:
  - "src/api/**"
  - "src/handlers/**"
---

# [Domain Name]

[Rule content]
```

Supported glob syntax: `**` for any depth, `*` for any file at the same level.

---

### `CLAUDE.local.md`

File in the project root, for personal preferences. Never commit this file.

```markdown
# Local preferences

[Personal preferences: preferred tools, runner, output verbosity, temporary overrides]
```

Add to `.gitignore`:
```
CLAUDE.local.md
```

---

## What goes where

### Root `CLAUDE.md`
- Tech stack and essential commands (build, test, run, lint)
- Fundamental architectural conventions that apply everywhere
- `@path` imports for detail files outside `.claude/rules/`

### `.claude/rules/*.md`
- Rules for a single domain: testing, API design, code style, security, DB, infra
- One file per domain — not one file per individual rule
- Path-scoped rules for specific files or modules

### `CLAUDE.local.md`
- Personal preferences (editor, test runner, output verbosity)
- Temporary overrides during development
- Never commit, never share with the team

---

## What to NEVER put in memory files

- Secrets, API keys, connection strings
- Rules already enforced by a linter or formatter (point to the config file instead: `.eslintrc`, `pyproject.toml`, etc.)
- Knowledge Claude already has about the framework or language being used
- Project history, changelogs, or past decisions already implemented
- Verbose documentation: use `@path` to point to real docs or link to existing files

---

## Recursive imports

`@path` imports are resolved recursively up to **5 levels deep**.
Avoid circular import chains. A file can import another file in `.claude/docs/`
which in turn imports a file in `.claude/references/` — but never loop back.
