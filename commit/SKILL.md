---
name: commit
description: "Execute atomic commits — one logical change at a time. Use when the user wants to commit, save changes, or run git commit."
argument-hint: "[scope] e.g. 'only staged files' or 'only files in src/auth/'"
allowed-tools:
  - "Bash(git add:*)"
  - "Bash(git status:*)"
  - "Bash(git commit:*)"
  - "Bash(git diff:*)"
---

# Atomic Commit

## Arguments

If `$ARGUMENTS` is provided, use it to restrict the scope of this commit run.
Parse the instruction and apply the matching rule **before doing anything else**:

| Instruction pattern                     | Behaviour                                                          |
|-----------------------------------------|--------------------------------------------------------------------|
| *(empty)*                               | Default: commit all modified files, grouped by logical concern     |
| `only staged` / `staged files`          | Skip `git add` entirely — commit only what is already in stage     |
| `only files in <path>` / `only <path>`  | Restrict to files under that path; ignore everything else          |
| `only <file1> <file2> …`                | Restrict to the listed files exactly                               |
| Any other free-text instruction         | Interpret it as an additional constraint and apply it literally    |

## Mandatory Process

1. Read `$ARGUMENTS` and determine the active scope (see table above)
2. Run `git status` to inspect all modified files
3. Run `git diff` (scoped to the active scope if needed) to analyze the relevant changes
4. **Group files by logical responsibility** — not by folder proximity or file type
5. For each logical group:
   a. `git add <file1> <file2>` (only the files in that group — skip entirely if `only staged`)
   b. `git diff --cached` — verify the staged diff is coherent and scoped
   c. `git commit -m "<emoji> <imperative description>"`
6. Repeat until every file in the active scope is committed

## Hard Rules

- NEVER use `git add .` or `git add -A`
- If a single file contains changes that serve different purposes, flag it and ask how to proceed before staging
- Commit message: max 72 characters, imperative mood ("Add" not "Added", "Fix" not "Fixed")
- If changes are too interleaved to split cleanly, warn the user before proceeding
- No commit should contain changes that belong to different logical concerns
- NEVER append attribution lines to the commit message — no `Co-Authored-By`, no `Generated with Claude Code`, no AI-related trailers of any kind
- The commit message must contain ONLY the emoji and the description of the change, nothing else

## Commit Message Format (Gitmoji)

```
<emoji> <short description>
```

Analyze the diff carefully and pick the **single most fitting emoji**:

| Emoji | When to use                                        |
|-------|----------------------------------------------------|
| ✨    | New feature or capability                          |
| 🐛    | Bug fix                                            |
| ♻️    | Code restructuring, no behavior change             |
| 📝    | Documentation only                                 |
| ✅    | Adding or updating tests                           |
| 🔧    | Config files, tooling, build scripts               |
| 📦    | Dependency add, update, or removal                 |
| 💄    | Formatting, whitespace, naming (no logic change)   |
| ⚡️    | Performance improvement                            |
| 🔥    | Removing code or files                             |
| 🚚    | Moving or renaming files                           |
| 🏗️    | Architectural change                               |
| 🔒️    | Security fix                                       |
| 🚑️    | Critical hotfix                                    |
| 🎉    | Initial commit                                     |
| ⏪️    |  Revert changes                                    |
| 🩹    | Simple fix, not a full bug fix                     |
| 💡    | Adding or updating comments in code                |
| 🏷️    | Adding or updating types / interfaces              |
| 🌱    | Seed files or initial data                         |
