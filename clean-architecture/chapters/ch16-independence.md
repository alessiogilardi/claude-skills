# Chapter 16: Independence

## Core Idea
A good architecture decouples the system along two axes — horizontal layers (UI, business rules, database) and vertical use cases — so that teams can develop independently, components can be deployed independently, and the decoupling mode (monolith/services) can be chosen and changed later.

## Frameworks Introduced
- **Decoupling Layers**: Separate horizontal layers by change axis — UI, application-specific business rules, application-independent business rules, database.
  - When to use: When structuring any system to support multiple teams and long-term maintenance.
  - How: Identify what changes for different reasons; separate those into different layers.
- **Decoupling Use Cases**: Separate vertical use cases that cut through all horizontal layers.
  - When to use: When adding features should not interfere with existing features.
  - How: Each use case has its own UI slice, business logic slice, and data slice — kept separate vertically.
- **Decoupling Mode**: The physical separation mode (source, deployment, service) is a deferred option.
  - When to use: As an architectural option left open until operational needs are better understood.
  - How: Design for source-level decoupling first; escalate to deployment or service level if operational needs demand it.

## Key Concepts
- **Conway's Law**: Any organization designing a system will produce a design whose structure copies the organization's communication structure. Good architecture counters this by making decoupling intentional, not organizational.
- **True vs. Accidental Duplication**: True duplication = every change to one must change the other. Accidental duplication = two similar-looking things that evolve for different reasons. Don't eliminate accidental duplication — it's not duplication.
- **Decoupling Mode levels**:
  - *Source level*: Classes/modules decoupled at compile time (monolith).
  - *Deployment level*: Components in separate JARs/DLLs but same process.
  - *Service level*: Components communicate via network (microservices, SOA).
- **Micro-service trap**: Premature decomposition into services before understanding use cases can make both deployment and development harder.
- **Independent develop-ability**: Decoupled use cases mean separate teams can work without interfering.
- **Independent deployability**: Decoupled components can be hot-swapped without redeploying the whole system.

## Mental Models
- Think of the system as a matrix: rows = horizontal layers, columns = vertical use cases. Each cell is an independently changeable unit.
- Decoupling mode is a spectrum: source → binary → service. Move toward the right only when operational need justifies it.
- "A good architecture leaves options open — the decoupling mode is one of those options."

## Anti-patterns
- **Fear of duplication leading to premature unification**: Two similar-looking slices of code that change for different reasons should NOT be merged — merging creates coupling.
- **All-or-nothing service decomposition**: Jumping to microservices prematurely over-engineers the deployment and communication complexity.
- **Layer-only decoupling (missing use cases)**: Separating layers but not use cases means adding a new use case still touches many components.

## Key Takeaways
1. Decouple horizontally by layer (UI, business rules, DB) AND vertically by use case.
2. Conway's Law: intentional decoupling counters accidental organizational coupling.
3. True vs. accidental duplication — resist merging things that only look the same but change for different reasons.
4. Decoupling mode (source/deployment/service) is an option to leave open — do not prematurely commit to microservices.
5. Good horizontal+vertical decoupling supports independent development, deployment, and operation.

## Connects To
- **Ch 15**: Architecture's purpose is to support the lifecycle — independence is the mechanism.
- **Ch 22**: The Clean Architecture implements this dual-axis decoupling in its layered ring model.
- **Ch 27**: Services: Great and Small — the decoupling mode as it applies to service-based systems.
