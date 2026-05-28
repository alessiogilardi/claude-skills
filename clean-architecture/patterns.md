# Patterns & Techniques — Clean Architecture

## Plugin Architecture
**When to use**: Any time you need to isolate business policy from a detail (DB, UI, framework, external service).
**How**: Define an interface in the high-level (inner) component. Implement it in the low-level (outer) component. The low-level component is a plugin — swappable without changing the core.
**Trade-offs**: Adds indirection; justified whenever the detail is volatile or replaceable.

---

## Dependency Inversion at Boundaries
**When to use**: When control flow must cross an architectural boundary in the "wrong" direction (outward).
**How**: Define an interface (or abstract class) in the inner ring. The outer ring implements it. The inner ring calls through the interface — never importing the outer implementation.
**Trade-offs**: More interfaces and files; mandatory at every boundary crossing where the Dependency Rule would otherwise be violated.

---

## Humble Object Pattern
**When to use**: At every architectural boundary where one side is hard to test (UI renderer, GPIO driver, database row mapper).
**How**: Split the component into two. The **Humble Object** does the mechanical work (render pixels, write to disk) and contains no logic. The **testable part** receives/produces plain data structures and contains all logic. Connect them through a simple protocol (ViewModel, plain DTO).
**Trade-offs**: More classes; worth it because it makes all logic testable without touching the boundary infrastructure.

---

## Request/Response Model (Input/Output Port)
**When to use**: When crossing from the Interface Adapters ring into the Use Cases ring.
**How**: Define two plain data structures (no framework types, no entity references): `InputData` (request model) and `OutputData` (response model). The Controller packages user input into `InputData`. The Use Case produces `OutputData`. The Presenter formats `OutputData` into a ViewModel.
**Trade-offs**: More types; prevents leaking entities or framework objects across the boundary.

---

## Presenter + ViewModel
**When to use**: At the UI boundary in a Clean Architecture system.
**How**: Use Case calls `OutputBoundary.present(OutputData)`. The Presenter converts domain values into displayable strings/booleans and assembles a `ViewModel`. The View (humble) copies the ViewModel to the screen with no logic.
**Trade-offs**: Requires one extra class per use case; View becomes trivially simple and the Presenter is fully unit-testable.

---

## Gateway Interface
**When to use**: Whenever a Use Case needs data from a database, cache, or external service.
**How**: Define a Gateway interface in the Use Case package (`OrdersGateway`). Implement it in the DB layer (`JdbcOrdersGateway`). The Use Case depends only on the interface — the actual DB technology is hidden.
**Trade-offs**: One interface per use-case-data-access pair; enables replacing DB technology without touching use cases.

---

## Abstract Use Case (Inheritance for Shared Structure)
**When to use**: When two actors share a use-case structure but require different behavior or data.
**How**: Create an abstract base use case capturing the shared flow. Derive actor-specific concrete use cases that override the variant behavior. Each concrete use case lives in its actor's component.
**Trade-offs**: Inheritance hierarchy; justified only when the structural overlap is genuine and actors genuinely share a base flow.

---

## Main Component as Composition Root
**When to use**: Always — in every application.
**How**: `Main` is the only place where concrete implementations are instantiated and wired. Every other component receives dependencies through interfaces. `Main` reads config, creates factories, injects dependencies, then hands control to high-level policy.
**Trade-offs**: `Main` becomes "the dirtiest component"; it knows everything. Acceptable — it is a plugin and can be replaced per environment (test Main, prod Main, integration Main).

---

## Framework at Arm's Length
**When to use**: Every time you adopt a framework (web, ORM, DI container).
**How**: Create thin proxy/adapter classes that extend framework base classes. Put these adapters in the outermost ring. Business objects never `import` or annotate with framework symbols. DI wiring happens in `Main`, not in domain classes.
**Trade-offs**: Extra adapter layer; prevents the framework from contaminating inner rings and makes migration possible.

---

## Partial Boundary — Skip-Last-Step
**When to use**: When full boundary overhead is premature but the seam must be preserved.
**How**: Implement both sides of the interface and the data structures, but package them together (no separate deployable). When the boundary matures, extract into a separate component without changing the interfaces.
**Trade-offs**: No deployment isolation; the seam can degrade if discipline is absent. Use static analysis tools to guard it.

---

## Partial Boundary — Strategy Pattern
**When to use**: One dimension of variability needs to be isolated without a full boundary.
**How**: Extract the varying behavior behind an interface. Inject the implementation. One interface, one concrete class, no separate deployment unit.
**Trade-offs**: Lighter than a full boundary; protects only one axis of change.

---

## Partial Boundary — Facade Pattern
**When to use**: When many external dependencies must be hidden behind a single point of access.
**How**: Define a Facade class in the inner ring that delegates to a set of outer services. Inner components call the Facade; outer services are invisible to them.
**Trade-offs**: Facade must be updated as outer services evolve; provides no deployment isolation.

---

## Acyclic Component Graph (Breaking Cycles)
**When to use**: When a dependency cycle is detected in the component dependency graph.
**How**: Two options — (1) apply DIP: extract an interface from the lower-level component and put it in the higher-level one; (2) extract a new shared component that both original components depend on.
**Trade-offs**: DIP adds an interface; new component adds a package. Both are preferable to a cycle, which forces simultaneous releases.

---

## Hardware Abstraction Layer (HAL)
**When to use**: In embedded systems, whenever business logic might otherwise call hardware-specific APIs directly.
**How**: Define a HAL interface that expresses what the application needs (not what the hardware offers). Implement the HAL for each hardware target. Business logic depends only on the HAL interface and can be compiled and tested on a development machine without hardware.
**Trade-offs**: Design effort upfront; pays off when porting to new hardware or running unit tests off-device.

---

## Testing API
**When to use**: When tests are tightly coupled to application structure and break on refactoring.
**How**: Define a separate API surface for tests that allows them to verify business rules while bypassing volatile UI and infrastructure layers. The API evolves with the business rules, not the structural implementation.
**Trade-offs**: Requires maintaining a parallel API surface; eliminates the Fragile Tests Problem and decouples test suites from UI/DB.

---

## Package by Component (Compiler-Enforced Boundary)
**When to use**: In Java/Kotlin (or any language with access modifiers) when you want compiler-enforced architectural boundaries in a monolith.
**How**: Bundle business logic and its persistence implementation together in one package. Make everything except the public component interface `package-private`. External packages can only call the public interface — the compiler prevents bypassing it.
**Trade-offs**: Language-specific (Java/Kotlin package-private); highly effective; gives monolith the same enforcement strength as microservices without the deployment overhead.
