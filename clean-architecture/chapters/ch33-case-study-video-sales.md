# Chapter 33: Case Study — Video Sales

## Core Idea
A worked example of applying Clean Architecture principles to a real system (video sales website): start with actors and use cases, partition by SRP, then layer the component architecture so the Dependency Rule is satisfied — keeping options open for future deployment configurations.

## Frameworks Introduced
- **Use Case Analysis → Component Architecture process**:
  1. Identify actors (sources of change): Viewer, Purchaser, Author, Administrator.
  2. Identify use cases per actor.
  3. Create abstract use cases where actors share behavior.
  4. Design component boundaries: Views/Presenters/Interactors/Controllers per actor group.
  5. Ensure all dependencies follow the Dependency Rule (pointing toward higher-level policy).

## Key Concepts
- **Four actors**: Viewer (watches videos), Purchaser (buys videos for themselves), Author (uploads content), Administrator (manages catalog and pricing). Each = separate source of change per SRP.
- **Actor partitioning**: Component boundaries drawn along actor lines — change for one actor (e.g., Purchaser pricing change) must not require change to another actor's component (e.g., Viewer).
- **Abstract use cases**: `View Catalog` is an abstract use case inherited by both `View Catalog as Viewer` and `View Catalog as Purchaser` — different behavior (different options available) but shared structure.
- **Business rules (pricing)**: Individual pricing (stream/download) vs. business pricing (bulk, streaming-only, quantity discounts) — different actors, different rules, different components.
- **Deployment flexibility**: Component boundaries enable mixing and matching deployment units:
  - Option 1: One component per actor group (maximum decoupling).
  - Option 2: Five JARs (Views, Presenters, Interactors, Controllers, Utilities).
  - Option 3: Two JARs (Views+Presenters vs. everything else).
  - Option 4: Single monolith.
  All are valid depending on current deployment needs.
- **Dependency direction in the diagram**: Flow of control goes right to left (Controller → Interactor → Presenter → View); dependencies (arrows) go left to right toward higher-level policy (Dependency Rule).
- **Open-Closed Principle in action**: Inheritance relationships (closed arrows) point against flow of control — subclasses extend abstract base classes, allowing new use cases to be added as new JARs without changing existing components.

## Reference Tables

| Actor | Primary Use Cases | Change Driver |
|---|---|---|
| Viewer | Watch videos, view catalog | Content consumption experience |
| Purchaser | Buy stream/download license, view catalog | Purchasing flow, pricing |
| Author | Upload videos, manage descriptions | Content creation tools |
| Administrator | Manage catalog, set prices | Business operations |

| Deployment Configuration | Files | Trade-off |
|---|---|---|
| Per-actor JARs | Many small JARs | Maximum independence |
| 5 JARs | Medium | Balanced |
| 2 JARs | 2 JARs | Simpler deployment |
| Monolith | 1 JAR | Simplest deployment |

## Key Takeaways
1. Start with actors (SRP) to identify change sources; each actor becomes an axis of partitioning.
2. Use cases drive the component architecture, not framework choices.
3. Abstract use cases capture shared structure between similar actor-specific use cases.
4. Dependency Rule: flow of control → left to right; dependency arrows → right to left (toward policy).
5. Good component boundaries enable multiple valid deployment configurations — keep options open.

## Connects To
- **Ch 7**: SRP — actors are the "reasons to change" at the system level.
- **Ch 22**: The Clean Architecture implemented for a real system: Controller → Interactor → Presenter → View per actor.
- **Ch 16**: Dual-axis decoupling (horizontal layers + vertical use cases) fully applied in Figure 33.2.
