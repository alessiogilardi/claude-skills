# Chapter 22: The Clean Architecture

## Core Idea
The Clean Architecture integrates Hexagonal, DCI, and BCE architectures into a single model: four concentric rings (Entities → Use Cases → Interface Adapters → Frameworks & Drivers) governed by one overriding rule — the Dependency Rule: source code dependencies must point only inward, toward higher-level policy.

## Frameworks Introduced
- **The Dependency Rule**: Source code dependencies must point only inward. Nothing in an inner circle can know anything about something in an outer circle — no names, no functions, no classes, no variables.
  - When to use: As the universal architectural rule that governs every boundary crossing.
  - How: If an outer-circle thing must communicate with an inner circle, use DIP — define an interface in the inner circle, implement it in the outer circle.
- **The Four Rings**:
  1. *Entities* (innermost): Enterprise-wide Critical Business Rules. Encapsulate the most stable, general business objects. Change only when fundamental business rules change.
  2. *Use Cases*: Application-specific business rules. Orchestrate the flow of data to/from Entities. Contain input/output ports (interfaces for crossing the boundary).
  3. *Interface Adapters*: Converters between use-case/entity data formats and external formats (web, DB). Controllers, Presenters, Gateways, and Data Mappers live here.
  4. *Frameworks & Drivers* (outermost): Web frameworks, databases, UI. Glue code. Details.

## Key Concepts
- **Independent of frameworks**: The architecture does not depend on any particular library or framework. Frameworks are tools — not the architecture.
- **Testable**: Business rules can be tested without UI, DB, web server, or any external element.
- **Independent of UI**: The UI can change without changing business rules.
- **Independent of Database**: Oracle, MySQL, Mongo — swappable without affecting business rules.
- **Independent of external agency**: Business rules don't know the interfaces to the outside world.
- **Crossing boundaries**: Flow of control (e.g., controller → use case → presenter) must comply with Dependency Rule. Use DIP when flow opposes dependency direction.
- **Data across boundaries**: Simple data structures (structs, DTOs) only — no Entity objects, no DB rows, no framework types. Always in the form most convenient to the inner circle.
- **Use Case Input Port**: Interface defined in the Use Case layer; called by the Controller (outer ring).
- **Use Case Output Port**: Interface defined in the Use Case layer; implemented by the Presenter (outer ring). Enables the use case to call the presenter without depending on it.

## Reference Tables

| Ring | Examples | Change Driver |
|---|---|---|
| Entities | `Loan`, `Order`, `Customer` | Fundamental business rules |
| Use Cases | `CreateLoan`, `ProcessPayment` | Application workflow requirements |
| Interface Adapters | Controller, Presenter, Gateway, Data Mapper | UI or external format changes |
| Frameworks & Drivers | Flask, Django ORM, PostgreSQL, React | Tool/library version changes |

| Data type | Where allowed |
|---|---|
| Entity objects | Entities layer only — never cross outward boundaries |
| Use case request/response DTOs | Use Case layer and Interface Adapters |
| Framework types (ORM rows, HttpRequest) | Outermost ring only |
| Simple structs / plain data | Anywhere when crossing boundaries |

## Anti-patterns
- **Entity depends on DB framework**: ORM entity inheriting from `models.Model` — framework contaminates the innermost ring.
- **Use case imports HttpRequest**: Use case knows about HTTP — couples application logic to the web framework.
- **Presenter in the use case**: Use case calls `self.presenter.display(data)` on a concrete type — violates Dependency Rule.
- **Controller creates Entity directly with new**: Entity creation inside a controller — wrong level.
- **DB rows crossing the boundary inward**: Passing ORM query results into use cases — use cases now know about DB schema.

## Key Takeaways
1. **The Dependency Rule**: All source code dependencies point inward. Nothing in an inner ring can know about an outer ring — ever.
2. Four rings: Entities (business rules) → Use Cases (orchestration) → Interface Adapters (data conversion) → Frameworks (glue).
3. Boundary crossings: use DIP — inner circle defines the interface; outer circle implements it.
4. Data crossing boundaries: plain DTOs/structs only; never pass Entity objects or framework types across boundaries.
5. Four independence properties: independent of frameworks, testable without infrastructure, independent of UI, independent of DB.

## Connects To
- **Ch 11**: DIP is the mechanism for the Dependency Rule.
- **Ch 19**: Level maps directly to rings — Entities farthest from I/O.
- **Ch 20**: Entities and Use Cases are formally defined here in the context of the rings.
- **Ch 23**: Humble Object Pattern implements the output port crossing between Use Cases and Presenters.
