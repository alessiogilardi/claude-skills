# Chapter 7: SRP — The Single Responsibility Principle

## Core Idea
A module should be responsible to one, and only one, actor — a group of people who require the same change — not "does only one thing" (which is a different, function-level principle).

## Frameworks Introduced
- **SRP (Single Responsibility Principle)**: A module should be responsible to one, and only one, actor.
  - When to use: When splitting a class/module that serves multiple stakeholder groups.
  - How: Identify which actors depend on which methods; separate code that different actors depend on.
- **Accidental Duplication Symptom**: Shared algorithms between methods serving different actors — a change for one actor unintentionally breaks the other.
  - When to use: Diagnosing hidden SRP violations.
  - How: Map each method to its actor; any method shared across actors is a hidden coupling risk.

## Key Concepts
- **Actor**: A group of one or more people who require the same change from a module.
- **Module**: A cohesive set of functions and data structures (often a source file).
- **Cohesion**: The force that binds together code responsible to a single actor.
- **Accidental Duplication**: When different actors share a common algorithm, coupling actors unintentionally (the `regularHours()` example: CFO and COO both depend on it via `calculatePay()` and `reportHours()`).
- **Merge Conflicts**: When two actors' teams edit the same file simultaneously — a structural symptom of SRP violation.

## Code Examples
```java
// VIOLATION: Employee serves CFO, COO, and CTO from one class
class Employee {
    Money calculatePay()   // CFO's concern
    void reportHours()     // COO's concern
    void save()            // CTO/DBA's concern
    // Shared private: regularHours() — hidden coupling point
}

// SOLUTION: Facade + data class + three actor-specific classes
class EmployeeData { ... }           // shared data, no methods
class PayCalculator { calculate(EmployeeData) }   // CFO
class HourReporter { report(EmployeeData) }       // COO
class EmployeeSaver { save(EmployeeData) }        // CTO
class EmployeeFacade {               // optional convenience wrapper
    PayCalculator, HourReporter, EmployeeSaver
}
```
- **What it demonstrates**: Separating actor-specific logic prevents accidental coupling.

## Anti-patterns
- **"Modules do one thing" (misread SRP)**: This is correct for functions; SRP is about actors, not operations.
- **God class**: One class serving all actors in the system — the canonical SRP violation.
- **Shared private methods across actors**: The hidden coupling point where SRP violations produce bugs.

## Key Takeaways
1. SRP: "A module should be responsible to one, and only one, actor." Not "one thing."
2. Actor = a group of stakeholders requiring the same change.
3. Symptom 1: Accidental duplication — shared algorithm used by methods of different actors.
4. Symptom 2: Merges — two teams editing the same file for different actors.
5. Solution: Separate the data from the operations; give each actor its own class.

## Connects To
- **Ch 13**: CCP (Common Closure Principle) is SRP applied at the component level.
- **Ch 20**: Use Cases represent single-actor concerns at the architectural level.
