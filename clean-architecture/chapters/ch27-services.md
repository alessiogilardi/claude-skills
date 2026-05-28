# Chapter 27: Services — Great and Small

## Core Idea
Services are not inherently an architecture — they are expensive function calls; services can be just as coupled as monolithic code (the Decoupling Fallacy and the Kitty Problem); the architectural principles (SOLID, Dependency Rule) apply within services just as within monoliths.

## Frameworks Introduced
- **The Decoupling Fallacy**: Services seem decoupled because they run in separate processes. But they are strongly coupled through shared data — adding a field to a shared record forces changes in every service that touches it.
  - When to use: When evaluating whether microservice decomposition provides real architectural value.
  - How: Ask — "If I add a feature that cuts across multiple service boundaries, how many services must change?" If the answer is "many" — the decoupling is illusory.
- **Component-Based Services**: Services can be designed with SOLID principles and component structures internally — new features added as new components (JARs, DLLs) without changing the service itself.
  - When to use: When designing a service that must accommodate multiple cross-cutting features.
  - How: Define abstract base classes for the core service; use OCP/Template Method/Strategy to extend behavior via new components.

## Key Concepts
- **Service ≠ Architecture**: Architecture is defined by boundaries that separate high-level policy from low-level detail, following the Dependency Rule. A service that just separates functionality without enforcing the Dependency Rule adds cost without architectural value.
- **The Kitty Problem**: A taxi aggregator with 5 services (UI, Finder, Selector, Dispatcher, Supplier) all must change when "kitten delivery" is added — they are all coupled through the shared data record. Microservices don't escape cross-cutting concerns.
- **Independent development/deployment fallacy**: Services can only be independently developed if they don't share data schemas or coordinated behavior. Cross-cutting features break this assumption.
- **Objects solve cross-cutting concerns**: SOLID + polymorphism can isolate new features into new components (one new JAR = one new feature), loaded dynamically at runtime — achievable with services too.
- **Architectural boundaries within services**: A service is not an architectural boundary by itself. The architectural boundaries live inside the service, between its components.

## Anti-patterns
- **Microservices as the default**: Choosing microservices for scalability or team autonomy without ensuring true decoupling — results in distributed monolith with network latency.
- **Service-per-team organization**: Each team owns one service → Conway's Law produces coupling organized by team, not by business logic.
- **Assuming process separation = architectural decoupling**: Two services that share a data schema are tightly coupled regardless of their physical separation.
- **No SOLID within services**: A monolithic service that grows organically without internal component discipline has all the problems of a monolithic application plus network overhead.

## Key Takeaways
1. Services are not inherently architectural — they are expensive function calls across process boundaries.
2. The Decoupling Fallacy: services coupled through shared data are as coupled as a monolith — just with latency.
3. The Kitty Problem: cross-cutting features touch all functionally-decomposed services simultaneously.
4. Solution: apply SOLID within services; cross-cutting behavior = new component, not service changes.
5. Architectural boundaries live inside services, not at service edges.

## Connects To
- **Ch 18**: Service-level boundaries are the most expensive boundary type — high cost, high latency.
- **Ch 14**: ADP/SDP apply to services too — the component dependency graph within a service must remain acyclic.
- **Ch 22**: Dependency Rule applies at service level — higher-level services should not depend on lower-level ones.
