# Chapter 21: Screaming Architecture

## Core Idea
A system's top-level structure should scream its intent (e.g., "Health Care System"), not its technology (e.g., "Rails" or "Spring") — use cases should be first-class, prominent architectural elements; frameworks are tools, not architectures.

## Frameworks Introduced
- **Screaming Architecture**: The top-level directory structure, package layout, and first-level class names should declare the system's domain and use cases, not its framework.
  - When to use: When organizing any software project from scratch or refactoring a framework-dominated structure.
  - How: Name packages by domain concept (e.g., `orders`, `billing`, `inventory`), not by framework role (e.g., `controllers`, `views`, `models`).
- **Use-Case-Driven Architecture**: Architect the system so that use cases are visible, named, and prominent; frameworks are supporting infrastructure in the background.
  - When to use: As the guiding organizing principle for package and class structure.
  - How: Jacobson's approach — every major use case has a visible representative in the top-level architecture.

## Key Concepts
- **The question**: When you look at the top-level directory, does it scream "Rails"? or "Health Care System"? If the former, the framework owns the architecture.
- **Architecture vs. framework**: Architectures describe the system; frameworks are tools. If the framework supplies the architecture, the architecture is the framework's — not the system's.
- **Frameworks as tools, not ways of life**: Look at frameworks skeptically. They are powerful but at a cost. Protect the use-case emphasis of your architecture from the framework.
- **Testable architectures**: If architecture is use-case-centered and frameworks are at arm's length, you should be able to unit-test all use cases without the web server, database, or any other framework in place.
- **Web as a detail**: The web is a delivery mechanism — an I/O device. The fact that a system is delivered via the web should not dominate its structure.
- **Delayed framework decision**: A good architecture allows you to defer the choice of framework, web server, and database without impact on the core.

## Mental Models
- Think of a house blueprint vs. a library blueprint — the building's purpose is immediately obvious. Your code should have the same property.
- "Frameworks are options to be left open." A framework commitment early is a constraint forever.
- If new programmers can read the top-level structure and understand what the system does — before knowing its framework — the architecture is screaming correctly.

## Anti-patterns
- **Framework-first package organization**: `controllers/`, `models/`, `views/` at the top level announces the framework, not the domain.
- **Framework true believers**: Designing the system entirely around the framework's idioms, letting the framework dictate the architecture.
- **Architecture that requires a running server to test use cases**: Means business logic is coupled to infrastructure.

## Key Takeaways
1. The top-level structure must scream the system's purpose, not its technology.
2. Use cases are first-class elements — prominent, named, visible at the architectural level.
3. Frameworks are tools: use them, but don't let them dominate the architecture.
4. The web is a delivery mechanism — a detail. Architecture should be ignorant of it.
5. Good architecture is testable without the framework, web server, or database running.

## Connects To
- **Ch 15**: Architecture's purpose is to support the lifecycle — screaming architecture makes the use cases visible, aiding maintenance.
- **Ch 22**: The Clean Architecture's rings implement the use-case-centered view: use cases in the second ring, frameworks in the outermost ring.
- **Ch 32**: Frameworks Are Details — the counterpart to this chapter.
