---
name: brainstorm
description: Open a broad, mentor-led exploratory discussion to deeply understand a task before any plan is written — the problem and its context, constraints, risks, and the possible directions of intervention with their trade-offs. Use when the user wants to think through, scope out, or clarify requirements for a feature/refactor/bug — "let's brainstorm X", "help me figure out what's needed for X", "before we plan this, let's talk through X". Always run before write-plan when no confirmed Understanding card file exists yet for the slug (docs/plans/.brainstorm/<slug>.md with confirmed true). Explores widely and challenges assumptions, but never writes plan files or code and never produces the detailed plan (precise files, tests, DoD) — that is write-plan's job. Its only artifact is the Understanding card, written exclusively via its own create_card.py script and consumed by the write-plan skill next.
allowed-tools:
  - Read
  - Grep
  - Glob
  - AskUserQuestion
  - "Bash(git log:*)"
  - "Bash(git status:*)"
  - "Bash(git diff:*)"
  - "Bash(uv run .claude/skills/brainstorm/scripts/*)"
---

# Brainstorming

> This skill is a **mentor-led exploration**, not a form to fill in as fast as possible. Explore the problem widely — its real motivation, context, constraints, edge cases, risks — and the candidate **directions of intervention** with their trade-offs. Challenge the user's framing; propose alternatives they have not considered. Converge only once the space is genuinely understood. Stop short of the detailed plan (precise file list, tests, DoD) — that belongs to `write-plan`. The only artifact is a confirmed **Understanding card** — Problem/Motivation, Non-Goals, Affected Areas, Success Criteria, **leaning Direction**, Effort, and slug — persisted at `docs/plans/.brainstorm/<slug>.md` via `create_card.py` (the skill's only write path). The card survives session restarts, so planning can resume in a fresh conversation with the chosen direction intact.

## Workflow

1. **Context exploration**: Read the relevant files, docs, and recent commits (`git log`, `git status`, `git diff`) to build a real mental model of what exists — never ask the user something you can answer yourself by reading the code.
2. **Scope assessment and decomposition**: Assess the breadth of the request before asking anything. If it describes multiple independent subsystems (e.g. "build a platform with chat, file storage, billing, and analytics"), flag it immediately and help the user decompose it into independent sub-projects, defining relationships and development order. Each sub-project gets its own cycle (brainstorm → plan → implementation).
3. **Explore broadly — as a mentor, not an interrogator**: This is the heart of the skill. Do not rush to the card. Open the space:
   - Dig past the stated request to the real problem behind it; surface hidden constraints, edge cases, risks, dependencies, and what should be *out* of scope.
   - Put candidate **directions of intervention** on the table and discuss their trade-offs at a conceptual level. Challenge weak framings and propose options the user has not considered.
   - Keep it a dialogue: mix open discussion in prose with focused questions. You are helping the user think, not extracting the minimum to unlock the gate.
4. **Ask focused questions — one decision per turn**: When a question has cleanly enumerable alternatives, use `AskUserQuestion` with multiple-choice options, one decision per turn; wait for the answer before asking the next. Fall back to open prose only when the answer space can't be enumerated. Ask as many questions as genuine understanding requires — do **not** minimize question count to reach the gate faster.
5. **Calibrate depth to effort** (see table below): depth scales with effort, but even a small task earns a real (if short) exchange — never zero exploration.
6. **Converge — the Understanding card**: Once the problem *and* a leaning direction are genuinely clear, present the fields below in a single chat message AND persist them by running:
   `uv run .claude/skills/brainstorm/scripts/create_card.py <slug> --effort <S|M|L|XL> --problem "..." --non-goals "..." --affected-areas "..." [--direction "..."] [--success-criteria "..."]`
   The card is written with `confirmed: false`. If the user asks for changes, re-run the same command — it overwrites an unconfirmed card. (`--direction` and `--success-criteria` are mandatory for L/XL.)
7. **Blocking gate**: Get the user's explicit confirmation on *slug* and *effort*, then — and only then — run `uv run .claude/skills/brainstorm/scripts/create_card.py <slug> --confirm`. Never run `--confirm` without that explicit confirmation in chat: the gate is enforced mechanically — `write-plan`'s scaffolding script refuses to run without a confirmed card.
8. **Hand-off**: Once confirmed, tell the user brainstorming is complete and to invoke `/write-plan`, which consumes the card and turns the leaning direction into a concrete, detailed plan (confirming and detailing it, then scaffolding). Leave the file-level design to `write-plan`.

---

## Required Output: the Understanding Card

Every brainstorming session ends with these fields — presented in one chat message and persisted to `docs/plans/.brainstorm/<slug>.md` via `create_card.py`. They map directly to the future plan: Problem/Affected Areas/Success Criteria pre-fill *Context and motivation*, Non-Goals pre-fills *Non-goals*, the leaning Direction seeds *Decisions*, Effort becomes the frontmatter.

* **Problem / Motivation**: The business value or bug to fix (extreme summary).
* **Non-Goals (Draft)**: What is explicitly excluded from this intervention.
* **Affected Areas**: Modules, files, or code components impacted.
* **Leaning Direction**: The direction of intervention you and the user are converging on, plus the main alternatives weighed and why they were set aside (mandatory for L/XL). This is a *starting direction*, not a detailed design — `write-plan` confirms and details it.
* **Success Criteria** (mandatory for L/XL): Observable outcomes that define success.
* **Effort Estimate**: Proposed sizing (S, M, L, XL).

Alongside it, propose a plan *slug* (kebab-case, matching `write-plan`'s scaffolding conventions). When Scope Assessment decomposed the request into multiple sub-projects, produce one card file per sub-project, each with its own slug, and state the recommended development order in chat.

## Depth of Exploration Proportional to Effort

Calibrate how deep to go — but regardless of effort, every question that *is* asked follows the one-decision-per-turn, multiple-choice rule above.

| Effort Level | Depth of exploration |
| :--- | :--- |
| **S** | Brief but real: confirm the problem and the single obvious direction, check for hidden edge cases, then propose slug and effort *S*. A short exchange, not zero. |
| **M** | Moderate: clarify ambiguous affected areas and weigh one or two candidate directions before converging. |
| **L / XL** | Deep and mandatory: thoroughly map scope, constraints, technical risks, critical dependencies, breaking changes, non-goals, and success criteria; debate multiple directions with their trade-offs before landing on a leaning one. |

## Blocking Gate (Non-Negotiable Rule)

Exploring directions and their trade-offs **is** this skill's job — do it fully. What this skill must **never** do:

- Produce the **detailed plan**: precise files to create/modify, the test list, or the DoD. That is `write-plan`.
- Write plan files or code, or run any scaffolding command.

This skill's scope ends at a confirmed card — problem, leaning direction, slug, and effort. The model proposes the Understanding card and the necessary questions; the user unlocks the hand-off by explicitly confirming slug and effort in chat. Only after that confirmation may `create_card.py <slug> --confirm` be run — the confirmed card is what `write-plan`'s scaffolding checks for. Never run `--confirm` preemptively or "to save a step".
