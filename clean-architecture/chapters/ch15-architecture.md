# Chapter 15: What Is Architecture?

## Core Idea
Architecture is the shape given to a system by its builders — the division into components, their arrangement, and the ways they communicate — with the primary purpose of supporting the system's lifecycle, not making it work; the strategy is to leave as many options open as possible, for as long as possible.

## Frameworks Introduced
- **Leave Options Open**: Good architecture delays decisions about details (DB, web framework, UI) so they can be made later with more information.
  - When to use: As the driving strategy at every decision point.
  - How: Identify what is "policy" (business rules) and what is "detail" (database, framework, UI); protect policy from depending on detail.
- **Policy vs. Details**: All software decomposes into policy (rules, procedures, value) and details (I/O devices, databases, web systems, frameworks, protocols).
  - When to use: When deciding where to draw boundaries.
  - How: Policy should be independent of details; details communicate with policy via abstractions.

## Key Concepts
- **Architecture**: The shape of the system — division into components, arrangement, communication. Purpose: facilitate the lifecycle (development, deployment, operation, maintenance).
- **The lifecycle goal**: Minimize lifetime cost and maximize programmer productivity.
- **Development**: Architecture must make the system easy to develop by the team(s) building it. Small team → little architecture needed. Multiple teams → strong component boundaries required.
- **Deployment**: Architecture must enable single-action deployment. Micro-service premature decomposition can make deployment harder, not easier.
- **Operation**: Least impacted by architecture; hardware is cheap. But architecture should make the operational intent of the system obvious to developers.
- **Maintenance**: The most costly lifecycle phase — "spelunking" (exploring existing code for safe change locations) + risk of inadvertent defects. Good architecture illuminates pathways and reduces spelunking cost.
- **Keeping options open**: Details (DB, UI, framework) are the "options." Good architecture makes them easy to swap out because the policy doesn't depend on them.

## Mental Models
- Think of architecture as a shape that facilitates change, not one that makes the system work.
- "The strategy is to leave as many options open as possible, for as long as possible" — delay irreversible decisions.
- Operation vs. maintenance trade-off: hardware is cheap, developers are expensive — optimize for maintenance.

## Anti-patterns
- **Architecture as feature support**: Designing components around features/functions rather than around change axes.
- **Premature detail decisions**: Choosing a database, framework, or deployment model before understanding the policy requirements.
- **Component-per-team architecture**: Teams designing one component each to minimize coordination — produces a structure driven by Conway's Law, not by architectural intent.

## Key Takeaways
1. Architecture's purpose: facilitate development, deployment, operation, and maintenance — in that priority order.
2. Strategy: leave options open by separating policy (the "what") from detail (the "how").
3. Maintenance is the most expensive lifecycle phase; architecture that reduces spelunking and risk is the most valuable.
4. A good architect continues to write code — they cannot guide others without experiencing the problems they create.

## Connects To
- **Ch 2**: The "two values" — architecture is the greater value because it keeps options open.
- **Ch 17**: Drawing the actual lines (boundaries) between policy and detail.
- **Ch 20**: Business Rules define what "policy" means concretely.
