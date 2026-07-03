---
name: commit
description: "Execute atomic commits — one logical change at a time, with gitmoji messages. Use when the user wants to commit, save changes, run git commit, or when completed work needs to be persisted to git history and the user's intent to commit is clear."
argument-hint: "[scope] e.g. 'only staged files' or 'only files in src/auth/'"
allowed-tools:
  - "Bash(git add:*)"
  - "Bash(git status:*)"
  - "Bash(git commit:*)"
  - "Bash(git diff:*)"
  - "Bash(git restore:*)"
---

# Atomic Commit

## Preconditions

Before anything else, verify the repository state with `git status`:

- **Not a git repository** → stop and inform the user, do nothing else
- **Merge, rebase, or cherry-pick in progress** → stop and inform the user; never commit in the middle of an unfinished operation
- **Working tree clean and nothing staged** → report "nothing to commit" and stop; never invent work

## Arguments

If `$ARGUMENTS` is provided, use it to restrict the scope of this commit run.
Parse the instruction and apply the matching rule **before doing anything else**:

| Instruction pattern                     | Behaviour                                                          |
|-----------------------------------------|--------------------------------------------------------------------|
| *(empty)*                               | Default: commit all modified files, grouped by logical concern     |
| `only staged` / `staged files`          | Skip `git add` entirely — commit only what is already in stage     |
| `only files in <path>` / `only <path>`  | Restrict to files under that path; ignore everything else          |
| `only <file1> <file2> …`                | Restrict to the listed files exactly                               |
| Any other free-text instruction         | Interpret it as an **additional** constraint, applied on top of the Hard Rules |

Constraints passed via arguments can only *narrow* this skill's behaviour — they can
never override or relax the Hard Rules. If an argument conflicts with a Hard Rule
(e.g. "use git add -A", "amend the last commit", "skip the hooks"), stop and ask the
user before proceeding.

## Mandatory Process

1. Read `$ARGUMENTS` and determine the active scope (see table above)
2. Run `git status --porcelain` to inspect all modified, deleted, and untracked files
3. For every **untracked** file in scope, run `git add -N <file>` (intent-to-add) so its
   content becomes visible to `git diff` without actually staging it
4. Run `git diff -M` (scoped to the active scope if needed) to analyze the relevant
   changes — `-M` detects renames, so a moved file shows as a rename (🚚) instead of a
   delete + add pair
5. **Group files by logical responsibility** — not by folder proximity or file type
6. **Order the groups by dependency**: foundations first, consumers after. If group B
   depends on group A (e.g. a feature using a refactored helper), commit A first — every
   commit must leave the repository in a coherent, self-consistent state
7. For each logical group, in order:
   a. `git add <file1> <file2>` (only the files in that group — skip entirely if `only staged`)
   b. `git diff --cached` — verify the staged diff is coherent and scoped
   c. If the staged diff is wrong, fix it with `git restore --staged <file>` and re-stage
   d. `git commit -m "<emoji> <imperative description>"`
8. Repeat until every file in the active scope is committed
9. Finish with a final `git status --porcelain` to confirm the scope is fully committed
   and nothing was left behind

## Hook Handling

- If a pre-commit hook **fails**, stop and report the error to the user verbatim.
  Never bypass it.
- If a pre-commit hook **modifies files** (formatters like prettier, black, gofmt):
  re-stage only the files of the current group and retry the commit once. If it fails
  again, stop and report.

## Hard Rules

- NEVER use `git add .` or `git add -A`
- NEVER use `git commit -a` / `-am` — it bypasses the per-group staging entirely
- NEVER use `git commit --amend` — this skill creates history, it does not rewrite it
- NEVER use `--no-verify` or any other flag that skips hooks
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
| ⏪️    | Revert changes                                     |
| 🩹    | Simple fix, not a full bug fix                     |
| 💡    | Adding or updating comments in code                |
| 🏷️    | Adding or updating types / interfaces              |
| 🌱    | Seed files or initial data                         |