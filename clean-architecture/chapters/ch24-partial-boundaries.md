# Chapter 24: Partial Boundaries

## Core Idea
Full architectural boundaries are expensive — three lighter approaches let you hold a place for a future full boundary without the full cost: skip the last step (deploy as one), one-dimensional interface (Strategy pattern), or Facade (no DIP at all).

## Frameworks Introduced
- **Three Partial Boundary Strategies** (in decreasing strength):
  1. *Skip the Last Step*: Build reciprocal interfaces and data structures for a full boundary, but compile and deploy as one component. Zero release management overhead; ready to split later.
  2. *One-Dimensional Boundary* (Strategy pattern): Create a `ServiceBoundary` interface on one side only; `ServiceImpl` implements it. Client is insulated from `ServiceImpl`, but no reciprocal interface protects the other direction — discipline required.
  3. *Facade pattern*: No DIP at all. `Facade` class lists all services; clients call through it. Simplest but leaves transitive dependencies and easy backchannels.

## Key Concepts
- **YAGNI tension**: Agile says "You Aren't Going to Need It" — but architects sometimes see potential future boundaries and make a judgment call to partially implement them.
- **FitNesse lesson**: The web component of FitNesse was initially separated (partial boundary via skip-last-step). Over time, without active maintenance, dependencies started flowing the wrong direction. Partial boundaries degrade without discipline.
- **Boundary degradation**: Any partial boundary can degrade. Without the full deployment separation, nothing physically prevents wrong-direction dependencies — only developer discipline does.
- **Architect's judgment**: Deciding where a boundary *might* one day exist, and whether to implement it fully or partially, is a core architectural skill.

## Reference Tables

| Strategy | DIP Present | Deploy Separate | Protection | Maintenance Cost |
|---|---|---|---|---|
| Skip last step | Yes (both directions) | No | Strong (code-level) | Medium |
| Strategy pattern | Yes (one direction) | No | Weak (discipline only) | Low |
| Facade | No | No | Minimal | Very Low |
| Full boundary | Yes (both directions) | Yes | Maximum | High |

## Anti-patterns
- **Partial boundary with no maintenance discipline**: Dependencies will leak in the wrong direction over time — a partial boundary without active maintenance becomes no boundary.
- **Always implementing full boundaries upfront**: Over-engineers the system with expensive release management for boundaries that may never be needed.
- **Facade as architecture**: The Facade gives clients a transitive dependency on all implementations — changes to any implementation force client recompilation.

## Key Takeaways
1. Full boundaries are expensive in code and release management — partial boundaries trade off protection for cost.
2. Three strategies: skip-last-step (compile together), Strategy pattern (one-way interface), Facade (no DIP).
3. Partial boundaries degrade without active maintenance — nothing physically enforces the contract.
4. The architect decides: where might a boundary be needed? How much protection is worth the cost today?

## Connects To
- **Ch 17**: Full boundaries drawn to defer decisions; partial boundaries acknowledge the cost-benefit trade-off.
- **Ch 22**: The Clean Architecture calls for full boundaries at the ring transitions; partial boundaries are a pragmatic intermediate.
