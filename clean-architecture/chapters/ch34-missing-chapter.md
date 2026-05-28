# Chapter 34: The Missing Chapter (by Simon Brown)

## Core Idea
The devil is in the implementation details: even with correct architectural intent, the chosen code organization strategy (package by layer, feature, ports & adapters, or component) determines whether the architecture is actually enforced — and most approaches create opportunities for structural violations that only discipline or tooling can prevent.

## Frameworks Introduced
- **Four Code Organization Strategies**:
  1. *Package by Layer*: Horizontal slices — web / service / repository packages. Dependencies point downward. Simple to start; doesn't scream domain; allows layer-skipping violations.
  2. *Package by Feature*: Vertical slices — one package per domain concept (e.g., `orders/`). Screams domain; easier to find related code; all types visible, still allows internal coupling.
  3. *Ports and Adapters (Inside/Outside)*: Domain "inside" (`com.mycompany.domain`); infrastructure "outside" (web, DB, integrations). Inside never depends on outside. Maps closely to Clean Architecture.
  4. *Package by Component* (Simon Brown): Bundle coarse-grained components (business logic + persistence together) behind a clean interface. Monolith stepping stone to microservices. `OrdersComponent` is the single entry point for orders.
- **C4 Model (Simon Brown)**: System → Containers → Components → Classes. A hierarchical way to think about software structure that is language-agnostic.

## Key Concepts
- **Layered architecture problem**: "Relaxed layers" — a new developer bypasses `OrdersService` and injects `OrdersRepository` directly into `OrdersController`. The dependency graph is still acyclic but the architectural constraint is violated.
- **Enforcement gap**: Architecture principles enforced only by developer discipline degrade under deadline pressure. Options: code reviews, static analysis tools (NDepend, Structure101, Checkstyle), or compiler-enforced encapsulation.
- **Public vs. package-private**: In Java, making too many types `public` removes the compiler as an enforcement mechanism. Package-private classes within a component enforce the component boundary at compile time.
- **Package by component advantage**: By bundling `OrdersServiceImpl` and `JdbcOrdersRepository` as package-private within the `OrdersComponent` package, the compiler prevents direct access from outside the component — the architectural constraint is enforced.
- **Context matters**: No universal best approach. The right strategy depends on team size, codebase maturity, language features, and whether the team actually enforces the rules.

## Reference Tables

| Strategy | Screams Domain? | Compiler Enforcement | Violation Risk | Best For |
|---|---|---|---|---|
| Package by Layer | No | Low (public types) | High (layer skipping) | Simple early projects |
| Package by Feature | Yes | Low (still public) | Medium | Growing codebases |
| Ports and Adapters | Yes | Medium | Low (discipline needed) | Clean Architecture adoption |
| Package by Component | Yes | High (package-private) | Low (compiler enforced) | Monolith → microservice paths |

## Anti-patterns
- **All types public**: Removes the compiler as an enforcement mechanism; any code can access any other code.
- **Discipline-only enforcement**: Architecture enforced only through code reviews fails under pressure.
- **Package by layer in a large system**: Three big buckets (web/service/repository) don't scale; too many things in each bucket; violations multiply.
- **Ignoring the implementation step**: Agreeing on architectural principles without deciding how to enforce them in code — the gap where architecture erodes.

## Key Takeaways
1. Architecture only exists if the implementation enforces it — intent is not enough.
2. Four strategies: package by layer (simple, prone to violations), feature (domain-visible), ports & adapters (Clean Arch), component (compiler-enforced).
3. Package by component + package-private types = compiler-enforced architectural boundaries.
4. Static analysis tools (Checkstyle, NDepend) are second-best to compiler enforcement.
5. The missing chapter: "It doesn't matter how much you follow the principles unless you also think carefully about how to map them to the package structure in your programming language."

## Connects To
- **Ch 21**: Screaming Architecture — package by feature and package by component both make the domain visible.
- **Ch 13**: CCP — package by component is CCP applied: classes that change together, deploy together.
- **Ch 18**: Boundary Anatomy — package-private in Java is a source-level boundary enforced by the compiler.
