# Glossary — Clean Architecture

**A (Abstractness metric)** — A = Na / Nc. Ratio of abstract classes and interfaces to total classes in a component. Range [0, 1]. (Ch 14)

**Accidental Duplication** — Two code sections that look similar but change for different reasons; should NOT be unified because they evolve independently. (Ch 16)

**Actor** — A group of one or more stakeholders who require the same change to a module. SRP: a module should be responsible to one, and only one, actor. (Ch 7)

**ADP (Acyclic Dependencies Principle)** — Allow no cycles in the component dependency graph. Break cycles via DIP or by extracting a new component. (Ch 14)

**Architecture** — The shape given to a system by its builders — the division into components, their arrangement, and their communication pathways. Purpose: facilitate the system lifecycle. (Ch 15)

**App-titude Test** — Kent Beck's three phases: make it work, make it right, make it fast. Most embedded code stops at phase 1. (Ch 29)

**Boundary** — A line that separates software elements, restricting knowledge on each side. Business rules must not know about details on the other side. (Ch 17)

**CCP (Common Closure Principle)** — Gather into components those classes that change for the same reasons at the same times. SRP at the component level. (Ch 13)

**Clean Architecture** — An architecture organized in four concentric rings (Entities, Use Cases, Interface Adapters, Frameworks & Drivers) governed by the Dependency Rule. (Ch 22)

**Component** — The smallest independently deployable unit (JAR, DLL, shared library). The physical manifestation of a collection of classes. (Ch 12)

**Conway's Law** — Any organization designing a system will produce a design whose structure mirrors the organization's communication structure. (Ch 16)

**CRP (Common Reuse Principle)** — Don't force users of a component to depend on things they don't need. ISP at the component level. (Ch 13)

**Critical Business Data** — The data that Critical Business Rules operate on; would exist even in a manual system. (Ch 20)

**Critical Business Rules** — Rules that make or save money for the business, independent of automation. Live in Entities. (Ch 20)

**Decoupling Fallacy** — The false belief that services are decoupled because they run in separate processes; they remain coupled through shared data. (Ch 27)

**Decoupling Mode** — Source-level (monolith), deployment (JARs/DLLs), or service-level. An option to be kept open and decided late. (Ch 16)

**Dependency Inversion Principle (DIP)** — High-level modules should not depend on low-level modules; both should depend on abstractions. Abstractions should not depend on details. (Ch 11)

**Dependency Rule** — Source code dependencies must point only inward, toward higher-level policies. Nothing in an inner ring can know about something in an outer ring. (Ch 22)

**Entity** — An object within a system that embodies Critical Business Rules operating on Critical Business Data. Framework-independent. (Ch 20)

**Fan-in** — Number of incoming dependencies to a component (other components that depend on it). (Ch 14)

**Fan-out** — Number of outgoing dependencies from a component (components it depends on). (Ch 14)

**Firmware** — Code so tightly coupled to hardware that it cannot outlive the hardware; a consequence of design choice, not a requirement. (Ch 29)

**Fragile Tests Problem** — Tests coupled to application structure break whenever the structure changes, making developers afraid to refactor. (Ch 28)

**Gateway** — A polymorphic interface in the Use Case layer that defines data access operations; implemented in the database layer. (Ch 23)

**HAL (Hardware Abstraction Layer)** — A boundary interface that separates business logic from hardware-specific code in embedded systems. (Ch 29)

**Humble Object Pattern** — Split a hard-to-test component into a humble part (mechanical, minimal) and a testable part (all logic). Reveals architectural boundaries. (Ch 23)

**I (Instability metric)** — I = Fan-out / (Fan-in + Fan-out). Range [0, 1]. 0 = maximally stable, 1 = maximally unstable. (Ch 14)

**Interface Adapters** — The third ring of Clean Architecture. Converts data between use-case format and external formats (web, DB). Contains Controllers, Presenters, Gateways. (Ch 22)

**ISP (Interface Segregation Principle)** — No client should be forced to depend on methods it does not use. Split fat interfaces into client-specific interfaces. (Ch 10)

**Kitty Problem** — Adding kitten delivery to a taxi service requires changing all services — demonstrating that functional decomposition into services does not achieve decoupling for cross-cutting concerns. (Ch 27)

**Level** — Distance from the inputs and outputs. Higher level = farther from I/O. Source code dependencies must point toward higher-level components. (Ch 19)

**LSP (Liskov Substitution Principle)** — Subtypes must be substitutable for their base types without altering program correctness. Applies to interfaces, REST contracts, and service boundaries too. (Ch 9)

**Main Component** — The dirtiest component. Creates all factories, injects dependencies, then hands control to the high-level abstract portions. A plugin to the application. (Ch 26)

**Main Sequence** — The ideal line in the A/I graph where A + I ≈ 1. Stable components should be abstract; unstable components should be concrete. (Ch 14)

**OCP (Open-Closed Principle)** — A software artifact should be open for extension but closed for modification. Achieved via abstract interfaces that shield higher-level policy from lower-level changes. (Ch 8)

**OSAL (Operating System Abstraction Layer)** — A boundary interface separating OS-dependent code (threads, mutexes, timers) from business logic in embedded systems. (Ch 29)

**Package by Component** — An organization strategy where all responsibilities for a coarse-grained domain component (business logic + persistence) are bundled behind a clean interface in a single package. (Ch 34)

**Partial Boundary** — A lightweight architectural seam that holds the place for a full boundary without full implementation cost. Three forms: skip-last-step, Strategy pattern, Facade. (Ch 24)

**Plugin Architecture** — High-level policy modules define interfaces; low-level detail modules implement them as plugins. Details can be swapped without changing the core. (Ch 5)

**Policy** — The business rules and procedures — the true value of the system. Must be independent of details. (Ch 15)

**Presenter** — A testable object that accepts domain data from a use case and formats it into ViewModel strings/booleans. The testable half of the Humble Object pattern at the UI boundary. (Ch 23)

**REP (Reuse/Release Equivalence Principle)** — The granule of reuse is the granule of release. Classes grouped in a component must be releasable together. (Ch 13)

**SAP (Stable Abstractions Principle)** — A component should be as abstract as it is stable. Stable components should consist of interfaces and abstract classes. (Ch 14)

**SDP (Stable Dependencies Principle)** — Depend in the direction of stability. I metrics should decrease in the direction of dependency. (Ch 14)

**Screaming Architecture** — An architecture whose top-level structure reveals the system's domain and use cases, not its frameworks. (Ch 21)

**Signature of a Mess** — Rising engineering headcount + declining lines of code per person + rising cost per line. Indicates structural rot. (Ch 1)

**SOLID** — Five design principles: SRP, OCP, LSP, ISP, DIP. Applied together, they guide mid-level software structure toward systems that are maintainable, flexible, and understandable. (Ch 7-11)

**SRP (Single Responsibility Principle)** — A module should be responsible to one, and only one, actor. NOT "does only one thing." (Ch 7)

**Square/Rectangle Problem** — The canonical LSP violation: `Square` inherits `Rectangle` but violates its behavioral contract (independent width/height). (Ch 9)

**Stability** — Amount of work required to change a component. High Fan-in = stable (many dependents resist change). (Ch 14)

**Testing API** — A specialized interface that allows tests to verify business rules while bypassing volatile UI and infrastructure. (Ch 28)

**Use Case** — An object that encodes application-specific business rules for how an automated system is used. Orchestrates Entities. Does not specify UI. (Ch 20)

**View** — The humble object at the UI boundary. Receives a ViewModel and mechanically renders it. No logic. Hard to unit test. (Ch 23)

**ViewModel** — A plain data structure (strings, booleans, enums) that the View copies to the screen. Assembled by the Presenter. (Ch 23)

**Zone of Pain** — Stable + Concrete (I≈0, A≈0). A component that is hard to change and cannot be extended — the rigid dead zone. (Ch 14)

**Zone of Uselessness** — Abstract + Unstable (I≈1, A≈1). A component that is never depended on. (Ch 14)
