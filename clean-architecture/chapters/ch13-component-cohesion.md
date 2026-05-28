# Chapter 13: Component Cohesion

## Core Idea
Three principles govern which classes belong together in a component — REP, CCP, CRP — and they are in tension: REP/CCP make components larger (inclusive), CRP makes them smaller (exclusive); good architects find the right balance for the project's current maturity.

## Frameworks Introduced
- **REP — Reuse/Release Equivalence Principle**: The granule of reuse is the granule of release.
  - When to use: When deciding what classes to put in a released library/component.
  - How: Classes grouped in a component must be releasable together — they should share theme, version, and release documentation.
- **CCP — Common Closure Principle**: Gather into components those classes that change for the same reasons and at the same times. Separate into different components those that change for different reasons.
  - When to use: When maintainability is the primary concern (early project phases).
  - How: Group classes by change axis — if a requirement change touches multiple classes, they should be in the same component.
- **CRP — Common Reuse Principle**: Don't force users of a component to depend on things they don't need.
  - When to use: When designing reusable library components.
  - How: Classes that aren't tightly coupled should not share a component — minimize transitive coupling from unused classes.

## Key Concepts
- **Tension Triangle**: REP and CCP are inclusive (larger components); CRP is exclusive (smaller components). Optimizing all three simultaneously is impossible.
- **Early project**: Favor CCP — maintainability matters more than reuse; large components minimize change-propagation.
- **Mature project (reused by others)**: Favor REP + CRP — releasability and minimal unnecessary coupling matter more.
- **CCP ↔ SRP**: CCP is the component-level SRP. "Gather together those things that change at the same times and for the same reasons."
- **CRP ↔ ISP**: CRP is the component-level ISP. "Don't depend on things you don't need."

## Reference Tables

| Principle | Level | Rule | Force |
|---|---|---|---|
| REP | Component | Classes must be releasable together | Inclusive |
| CCP | Component | Classes that change together stay together | Inclusive |
| CRP | Component | Don't force dependencies on unused classes | Exclusive |

| If you neglect... | You get... |
|---|---|
| REP | Components that are hard to reuse/release |
| CCP | Many components touched by single changes |
| CRP | Too many unneeded recompilations/redeployments |

## Anti-patterns
- **Miscellaneous component**: Classes thrown together with no unifying theme — violates REP.
- **Cross-actor component**: Classes that change for different reasons in one component — violates CCP (and SRP).
- **Fat component with unused classes**: Forces all dependents to rebuild when any part changes — violates CRP.

## Key Takeaways
1. REP: Release together = cohesive; no random hodgepodge.
2. CCP: Change together = cohesive; SRP at component level.
3. CRP: Don't couple to what you don't use; ISP at component level.
4. The tension: CCP/REP grow components; CRP shrinks them. Balance depends on project maturity.
5. Early in a project: favor CCP (develop-ability). Later: slide toward REP+CRP (reusability).

## Connects To
- **Ch 7**: SRP → CCP (same axis: "same reason to change," different levels).
- **Ch 10**: ISP → CRP (same axis: "don't depend on what you don't use," different levels).
- **Ch 14**: Component Coupling — after deciding what goes in a component, decide how components depend on each other.
