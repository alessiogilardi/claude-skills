---
name: clean-architecture
description: "Knowledge base from \"Clean Architecture: A Craftsman's Guide to Software Structure and Design\" by Robert C. Martin. Use when applying Martin's architectural frameworks (Dependency Rule, SOLID, component principles, boundary drawing), designing system structure, evaluating coupling and cohesion, or referencing specific chapters on architecture and design."
allowed-tools:
  - Read
  - Grep
argument-hint: [topic, principle name, chapter number, or pattern name]
---

# Clean Architecture: A Craftsman's Guide to Software Structure and Design
**Author**: Robert C. Martin (Uncle Bob) | **Pages**: ~364 | **Chapters**: 34 | **Generated**: 2026-05-28

## How to Use This Skill

- **Without arguments** — load core frameworks for reference and design guidance
- **With a topic** — ask about `SOLID`, `boundaries`, `components`, `DIP`, `SRP`, or another concept; I find and read the relevant chapter
- **With a chapter** — ask for `ch22` or "the Clean Architecture chapter"; I load it
- **Browse** — ask "what chapters do you have?" to see the full index

When a topic isn't fully covered below, I read the relevant chapter file before answering.

---

## Core Frameworks & Mental Models

### The One Rule: Dependency Rule
Source code dependencies must point **only inward**, toward higher-level policy. Nothing in an inner ring may name, import, or reference anything in an outer ring. Control flow crosses boundaries via interfaces; data crosses as plain DTOs only — never entities, never framework objects.

### The Four Rings (Clean Architecture)
1. **Entities** — Critical Business Rules + Critical Business Data. Framework-independent. Highest stability, slowest to change.
2. **Use Cases** — Application-specific rules. Orchestrate Entities. Know nothing about UI, DB, or framework.
3. **Interface Adapters** — Controllers, Presenters, Gateways, ViewModels. Convert between use-case data and external formats.
4. **Frameworks & Drivers** — Web framework, DB engine, UI, devices, Main. Everything volatile lives here.

### Plugin Architecture
High-level policy defines interfaces. Low-level details implement them as plugins. When a detail changes (swap DB, change UI, replace framework), only the plugin changes — the core is untouched. Every architectural boundary is a plugin seam.

### SOLID (Mid-Level Design)
- **SRP** — A module is responsible to one, and only one, **actor** (stakeholder group). Not "does one thing" — responsible to one source of change.
- **OCP** — Open for extension, closed for modification. Achieved via interfaces that shield higher-level policy. OCP is the goal; DIP is the mechanism.
- **LSP** — Subtypes must be substitutable for their base types. Applies to interfaces, REST contracts, and microservice APIs — not just class inheritance.
- **ISP** — No client depends on methods it does not use. Fat interfaces create hidden coupling. Split interfaces to client-specific shapes.
- **DIP** — Both high-level and low-level modules depend on abstractions. Interfaces belong in the high-level package — not the low-level one. Every DIP seam is a candidate boundary.

### Component Principles

**Cohesion (what belongs together):**
- **REP** — Granule of reuse = granule of release. A component must be releasable as a unit.
- **CCP** — Classes that change together, stay together. SRP at component scale.
- **CRP** — Don't force clients to depend on things they don't use. ISP at component scale.

**Coupling (dependency direction):**
- **ADP** — No cycles in the component dependency graph. Break cycles via DIP or new component.
- **SDP** — Depend in the direction of stability (lower I-metric). Never depend on something more unstable than yourself.
- **SAP** — Stable components should be abstract; unstable components should be concrete. I + A ≈ 1.

### Level and Stability
Level = distance from inputs and outputs. Higher level = closer to policy = more stable = more abstract. Source code dependencies must couple to **level**, not to data flow. Low-level volatile details must depend on high-level stable policy — never the reverse.

### Humble Object Pattern
At every hard-to-test boundary: split into (1) a **humble** mechanical part with no logic and (2) a **testable** part with all logic. The View is humble; the Presenter is testable. GPIO is humble; the business rule is testable. Reveals architectural boundaries — wherever you apply this pattern, a boundary belongs.

### Boundaries Are Lines
Draw a line between two things when they change for different reasons (different actors, different rates). The boundary restricts knowledge: each side knows nothing about the other. Details sit on the outer side; policy on the inner side. Cost is real — under-draw and you have a big ball of mud; over-draw and you have premature microservices.

### Decoupling Mode Spectrum
Source-level (monolith) → Deployment (JAR/DLL) → Local process → Service. Start at source-level. Promote only when the isolation benefit exceeds the communication cost. Keep the option open by drawing the right source-level boundaries first.

### Architecture's Purpose
Architecture is not about frameworks or technologies. It is the **shape** given to a system that minimizes the human resources required to build and maintain it. Good architecture leaves options open: defer the DB choice, defer the framework choice, defer the UI choice. Details are decisions that should be made as late as possible.

### Screaming Architecture
The top-level structure of the codebase should reveal the domain and use cases — not the framework. If your package tree screams "Rails" or "Spring", the framework has colonized your architecture. Use cases are first-class; frameworks are plugins.

---

## Chapter Index

| # | Title | Key Frameworks |
|---|-------|----------------|
| [ch01](chapters/ch01-design-and-architecture.md) | What Is Design and Architecture? | Signature of a Mess, Go-Fast-Go-Well |
| [ch02](chapters/ch02-two-values.md) | A Tale of Two Values | Behavior vs Architecture, Eisenhower Matrix |
| [ch03](chapters/ch03-paradigm-overview.md) | Paradigm Overview | Three Paradigms as Constraints |
| [ch04](chapters/ch04-structured-programming.md) | Structured Programming | Functional Decomposition, Falsifiability |
| [ch05](chapters/ch05-oop.md) | Object-Oriented Programming | Safe Polymorphism, Plugin Architecture |
| [ch06](chapters/ch06-functional-programming.md) | Functional Programming | Immutability, Segregation of Mutability, Event Sourcing |
| [ch07](chapters/ch07-srp.md) | The Single Responsibility Principle | SRP, Actor, Employee Example |
| [ch08](chapters/ch08-ocp.md) | The Open-Closed Principle | OCP, Directional Shield |
| [ch09](chapters/ch09-lsp.md) | The Liskov Substitution Principle | LSP, Square/Rectangle, REST contracts |
| [ch10](chapters/ch10-isp.md) | The Interface Segregation Principle | ISP, Fat Interfaces, Architectural Warning |
| [ch11](chapters/ch11-dip.md) | The Dependency Inversion Principle | DIP, Abstract Factory, Boundary Seam |
| [ch12](chapters/ch12-components.md) | Components | Smallest Deployable Unit, 50-year history |
| [ch13](chapters/ch13-component-cohesion.md) | Component Cohesion | REP, CCP, CRP, Tension Triangle |
| [ch14](chapters/ch14-component-coupling.md) | Component Coupling | ADP, SDP, SAP, I-metric, A-metric, Main Sequence |
| [ch15](chapters/ch15-architecture.md) | What Is Architecture? | Policy vs Details, Options Open |
| [ch16](chapters/ch16-independence.md) | Independence | Dual-axis Decoupling, Conway's Law, Decoupling Mode |
| [ch17](chapters/ch17-boundaries.md) | Drawing Lines | Plugin Architecture, FitNesse Case Study |
| [ch18](chapters/ch18-boundary-anatomy.md) | Boundary Anatomy | Four Boundary Types, Communication Cost |
| [ch19](chapters/ch19-policy-and-level.md) | Policy and Level | Level, Encryption Example |
| [ch20](chapters/ch20-business-rules.md) | Business Rules | Entity, Use Case, Request/Response Model |
| [ch21](chapters/ch21-screaming-architecture.md) | Screaming Architecture | Use Cases as First Class, Framework Independence |
| [ch22](chapters/ch22-clean-architecture.md) | The Clean Architecture | Dependency Rule, Four Rings, DIP at Boundaries |
| [ch23](chapters/ch23-humble-objects.md) | Presenters and Humble Objects | Humble Object, Presenter, ViewModel, Gateway |
| [ch24](chapters/ch24-partial-boundaries.md) | Partial Boundaries | Skip-last-step, Strategy, Facade |
| [ch25](chapters/ch25-layers-and-boundaries.md) | Layers and Boundaries | Axis-of-Change Analysis, Hunt the Wumpus |
| [ch26](chapters/ch26-main-component.md) | The Main Component | Composition Root, DI in Main, Multiple Mains |
| [ch27](chapters/ch27-services.md) | Services: Great and Small | Decoupling Fallacy, Kitty Problem, SOLID in Services |
| [ch28](chapters/ch28-test-boundary.md) | The Test Boundary | Fragile Tests, Structural Coupling, Testing API |
| [ch29](chapters/ch29-clean-embedded.md) | Clean Embedded Architecture | Firmware vs Software, HAL, OSAL, App-titude Test |
| [ch30](chapters/ch30-database-detail.md) | The Database Is a Detail | DB as Plugin, Data Model vs DB Technology |
| [ch31](chapters/ch31-web-detail.md) | The Web Is a Detail | Web as I/O Device, Pendulum, Company Q |
| [ch32](chapters/ch32-frameworks-detail.md) | Frameworks Are Details | Asymmetric Marriage, Framework at Arm's Length |
| [ch33](chapters/ch33-case-study-video-sales.md) | Case Study: Video Sales | 4 Actors, SRP Partitioning, Deployment Flexibility |
| [ch34](chapters/ch34-missing-chapter.md) | The Missing Chapter (Simon Brown) | Package by Component, C4 Model, Compiler Enforcement |

## Topic Index

- **A-metric (Abstractness)** → ch14
- **ADP (Acyclic Dependencies Principle)** → ch14
- **Architecture definition** → ch15, ch22
- **Boundaries** → ch17, ch18, ch24, ch25
- **CCP (Common Closure Principle)** → ch13
- **Clean Architecture rings** → ch22
- **Component cohesion** → ch13
- **Component coupling** → ch14
- **Composition Root / Main** → ch26
- **Conway's Law** → ch16
- **CRP (Common Reuse Principle)** → ch13
- **Database as detail** → ch30
- **Decoupling fallacy (services)** → ch27
- **Decoupling modes** → ch16, ch18
- **Dependency Inversion Principle (DIP)** → ch11, ch22
- **Dependency Rule** → ch22
- **Embedded systems** → ch29
- **Entities** → ch20
- **Event Sourcing** → ch06
- **Frameworks as details** → ch32
- **Functional programming** → ch06
- **Gateway** → ch23
- **HAL / OSAL** → ch29
- **Humble Object Pattern** → ch23
- **I-metric (Instability)** → ch14
- **Interface Segregation Principle (ISP)** → ch10
- **Level** → ch19
- **Liskov Substitution Principle (LSP)** → ch09
- **Main Sequence** → ch14
- **Object-Oriented Programming / Polymorphism** → ch05
- **OCP (Open-Closed Principle)** → ch08
- **Package by Component** → ch34
- **Paradigms** → ch03, ch04, ch05, ch06
- **Partial Boundaries** → ch24
- **Plugin Architecture** → ch05, ch17
- **Policy vs Details** → ch15
- **Presenter / ViewModel** → ch23
- **REP (Reuse/Release Equivalence Principle)** → ch13
- **SAP (Stable Abstractions Principle)** → ch14
- **Screaming Architecture** → ch21
- **SDP (Stable Dependencies Principle)** → ch14
- **Services** → ch27
- **SOLID** → ch07, ch08, ch09, ch10, ch11
- **SRP (Single Responsibility Principle)** → ch07
- **Structured Programming** → ch04
- **Testing** → ch28
- **Use Cases** → ch20, ch21, ch22
- **Video Sales Case Study** → ch33
- **Web as detail** → ch31
- **Zone of Pain / Uselessness** → ch14

## Supporting Files

- [glossary.md](glossary.md) — all key terms with definitions and chapter references
- [patterns.md](patterns.md) — all techniques and design patterns (Plugin Architecture, Humble Object, Gateway, etc.)
- [cheatsheet.md](cheatsheet.md) — quick reference tables: rings, SOLID, metrics, boundary types, component principles

---

## Scope & Limits

This skill covers the book content only. For hands-on implementation in your codebase, combine with project-specific tools. The book uses Java examples; principles apply to any language. For concrete enforcement tools, see ch34 (NDepend, Structure101, Checkstyle, package-private in Java).
