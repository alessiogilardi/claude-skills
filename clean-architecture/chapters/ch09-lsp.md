# Chapter 9: LSP — The Liskov Substitution Principle

## Core Idea
Subtypes must be substitutable for their base types without altering the correctness of the program — violated not just in inheritance hierarchies, but at any interface boundary where callers depend on substitutability of implementations.

## Frameworks Introduced
- **LSP (Liskov Substitution Principle)**: If S is a subtype of T, then objects of type S can replace objects of type T without breaking the program.
  - When to use: When defining any inheritance, interface, or REST/service contract.
  - How: Ask — "Can a caller that uses T work correctly if given an S instead?" If not, the type hierarchy is wrong.
- **LSP in Architecture (REST / services)**: Any implementation of a service interface must honor the same behavioral contract as the interface specifies.
  - When to use: When building systems with multiple service providers behind a uniform interface (aggregators, adapters, plugin systems).
  - How: Document behavioral contracts, not just method signatures; test substitutability explicitly.

## Key Concepts
- **Barbara Liskov (1988)**: Original definition — for all programs P defined in terms of T, behavior is unchanged when o1 of type S is substituted for o2 of type T.
- **Square/Rectangle violation**: `Square` inherits `Rectangle`, but a caller that sets `width` and `height` independently will see broken `area()`. Behavioral contract is violated even though types compile.
- **Behavioral contract**: The implied invariants and post-conditions of an interface, beyond its type signature.
- **LSP violation causes**: Requiring callers to use `instanceof` or type-checking switches → the abstraction has failed.
- **Taxi dispatch example**: If one provider (e.g., Acme) uses a different REST URI format, the dispatcher must add special-case code → LSP violation forces ad-hoc dispatch logic into caller.

## Code Examples
```java
// VIOLATION: Square breaks Rectangle's behavioral contract
Rectangle r = new Square(); // caller believes height and width are independent
r.setW(5);
r.setH(2);
assert(r.area() == 10); // FAILS — Square sets both dimensions together

// SIGNAL: caller needs instanceof to work around subtype
if (r instanceof Square) { ... } // LSP is violated; abstraction is broken
```
- **What it demonstrates**: Type-compatible but behaviorally incompatible subtypes break caller assumptions.

## Anti-patterns
- **Inheritance by convenience**: Subclassing to reuse code without honoring behavioral contracts.
- **instanceof checks in callers**: Each one is a signal that LSP is violated and the abstraction is broken.
- **Stronger preconditions in subtypes**: A subtype that is more restrictive than its parent forces callers to accommodate it — LSP violation.

## Key Takeaways
1. LSP: Subtypes must honor the behavioral contract of their supertypes, not just the type signature.
2. The Square/Rectangle problem: structural inheritance can violate behavioral substitutability.
3. At architectural scale: any interface contract (REST, plugin, service) must be substitutable — all implementations must honor the same behavioral expectations.
4. `instanceof` in a caller = diagnostic indicator of an LSP violation.

## Connects To
- **Ch 5**: OOP polymorphism depends on LSP being satisfied to be safe.
- **Ch 17**: Plugin architecture contracts must satisfy LSP — otherwise callers need special-case code for each plugin.
- **Ch 27**: Service contracts in microservices must honor LSP across service implementations.
