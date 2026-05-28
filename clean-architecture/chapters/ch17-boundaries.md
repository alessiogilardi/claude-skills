# Chapter 17: Boundaries — Drawing Lines

## Core Idea
Software architecture is the art of drawing lines (boundaries) that separate elements and restrict knowledge across them — drawn early to defer decisions, eliminating premature coupling to frameworks, databases, and tools; the FitNesse case study proves that deferring the database decision for 18 months is achievable and beneficial.

## Frameworks Introduced
- **The Boundary Pattern**: Draw a line between business rules and every premature decision (database, framework, UI, web server). Business rules must not know about anything on the other side.
  - When to use: Whenever a component of uncertain choice (DB, framework, web) would couple to core business logic.
  - How: Define an interface in the business rules layer; put the concrete implementation (DB, filesystem, mock) behind it.
- **Plugin Architecture as the Default**: Details (DB, UI, web) are plugins that implement interfaces defined by the policy; they can be swapped without changing the core.
  - When to use: As the design stance for every external dependency.
  - How: Draw the boundary so that the dependency arrow points FROM the plugin TOWARD the core policy.

## Key Concepts
- **Boundary**: A line that separates elements, restricting knowledge on each side. Business rules know only the abstraction; details know only how to implement it.
- **Premature coupling** = coupling to decisions that are not yet necessary (framework, DB, UI). This is the primary sapper of architect productivity.
- **Company P tragedy**: Premature three-tier architecture forced tripling of development effort for every simple change — for a server farm that never existed.
- **Company W tragedy**: Premature enterprise SOA forced enormous overhead for every feature — the "service registry hell."
- **FitNesse success**: DB decision deferred 18 months via `WikiPage` interface. Flat files used in production for years; MySQL added by a customer in one day when needed.
- **Plugin dependency direction**: The plugin depends on the core; the core does not depend on the plugin.

## Code Examples
```java
// Core business rule — knows nothing about storage
interface WikiPage {
    WikiPage getChildPage(String name);
    void save();
    // ...
}

// Plugins implement the interface — business logic never changes
class MockWikiPage implements WikiPage { ... }        // for testing
class InMemoryPage implements WikiPage { ... }        // for early development
class FileSystemWikiPage implements WikiPage { ... }  // for production (flat files)
class MySqlWikiPage implements WikiPage { ... }        // added by a customer, later
```
- **What it demonstrates**: The boundary keeps the DB choice as a plugin — all implementations are interchangeable.

## Anti-patterns
- **Premature framework adoption**: Designing the system around a framework before understanding use cases couples you to the framework permanently.
- **Database in the core**: Importing DB abstractions (SQLAlchemy, Hibernate) into business logic couples the domain to the storage mechanism.
- **No boundary before deployment**: Building without boundaries "because we're small" accrues coupling that becomes expensive to remove later.

## Key Takeaways
1. Boundaries separate elements and restrict knowledge — business rules must not know about details.
2. Premature coupling to decisions (DB, framework, UI) is the primary cause of unnecessary development cost.
3. Plugin architecture: details (DB, UI, web) are plugins to core business logic, not the other way around.
4. The FitNesse case: 18 months without a DB, deferring to flat files, with MySQL added in one day when needed — proves the approach works.
5. Draw boundaries early to defer decisions; the boundary costs little, the premature coupling costs greatly.

## Connects To
- **Ch 11**: DIP is the mechanism for drawing boundaries — the interface defines the seam.
- **Ch 18**: Boundary Anatomy — the different forms a boundary can take.
- **Ch 22**: The Clean Architecture formalizes the boundary structure into four concentric rings.
