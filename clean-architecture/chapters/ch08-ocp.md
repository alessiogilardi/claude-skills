# Chapter 8: OCP — The Open-Closed Principle

## Core Idea
Software entities should be open for extension but closed for modification — achieved by separating the things that change for different reasons and arranging source code dependencies so that higher-level components are protected from changes in lower-level components.

## Frameworks Introduced
- **OCP (Open-Closed Principle)**: A software artifact should be easy to extend without being changed.
  - When to use: When a new feature or variant requires changes that ripple through many modules.
  - How: Separate what changes from what stays the same; make the stable part an abstract interface; put the varying part behind the interface.
- **Directional Shield**: Arrange components in a hierarchy where higher-level components are insulated from changes to lower-level ones.
  - When to use: When designing the layering of a system.
  - How: Draw the dependency arrows so that higher-level policy never points toward lower-level detail.

## Key Concepts
- **Open for extension**: New behavior can be added (by adding new code).
- **Closed for modification**: Existing code does not need to change when behavior is extended.
- **The Bertrand Meyer origin (1988)**: OCP is one of the oldest SOLID principles; originally described for inheritance hierarchies but applies more broadly to any abstraction boundary.
- **Transitive protection**: If A protects B, and B protects C, then changes to C cannot affect A — protection is transitive along the dependency chain.
- **OCP in architecture**: The goal is to make the system easy to extend with minimal impact; the entire Clean Architecture is an expression of OCP at the system scale.

## Reference Tables

| Component role | Direction of dependency arrow | Who is protected |
|---|---|---|
| High-level policy | ← receives dependencies | Protected from lower-level changes |
| Low-level detail | → points toward policy | Must change if policy changes |
| Interface / boundary | — defines the seam | Contracts that stabilize both sides |

## Anti-patterns
- **Modifying existing classes to add features**: Any modification risks regression; signals a boundary is missing.
- **Concrete dependencies pointing upward**: A high-level module that `import`s a concrete low-level class cannot be protected from changes to that class.
- **100% closure as the goal**: Total closure is impossible; closure must be strategic — close to the kinds of changes you predict or have experienced.

## Key Takeaways
1. OCP: Open for extension, closed for modification — add new behavior by adding new code, not changing existing code.
2. Mechanism: Abstract interfaces shield high-level policy from low-level detail changes.
3. The protection is directional and transitive: components higher in the hierarchy are more protected.
4. OCP drives the entire architecture — the Dependency Rule in Clean Architecture is OCP applied at system scale.

## Connects To
- **Ch 13**: CCP (Common Closure Principle) — group classes closed to the same kinds of changes into one component.
- **Ch 22**: The Dependency Rule is OCP at architectural scale: inner circles closed to changes in outer circles.
- **Ch 5**: OOP polymorphism is the mechanism that makes OCP practical.
