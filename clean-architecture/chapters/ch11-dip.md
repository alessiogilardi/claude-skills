# Chapter 11: DIP — The Dependency Inversion Principle

## Core Idea
High-level policy should not depend on low-level detail; both should depend on abstractions — achieved by using abstract interfaces to invert the direction of source code dependencies so that the flow of control can cross architectural boundaries safely.

## Frameworks Introduced
- **DIP (Dependency Inversion Principle)**:
  - High-level modules should not depend on low-level modules. Both should depend on abstractions.
  - Abstractions should not depend on details. Details should depend on abstractions.
  - When to use: At every architectural boundary — wherever a high-level policy must call a low-level mechanism.
  - How: Define an abstract interface in the high-level package; the low-level detail implements it.
- **Stable Abstractions Rule**: Depend in the direction of stability; abstract things are more stable than concrete things.
  - When to use: When deciding which direction a dependency arrow should point.
  - How: Count the change frequency of each module; dependencies should point toward the more stable, more abstract module.

## Key Concepts
- **Inversion**: "Inversion" refers to the reversal of dependency direction vs. naive top-down coding (where `main` depends on `service` which depends on `database`).
- **Abstract interface placement**: The interface belongs to the package of the client (high-level), not the implementor (low-level).
- **Concrete things change frequently; abstractions rarely do**: Basing dependencies on abstractions decouples change rates.
- **Factories**: To avoid depending on concrete implementations at initialization, use Abstract Factory — depend on the factory interface, not the concrete factory.
- **The DIP Boundary**: Every place where source code dependency is inverted is a candidate architectural boundary.

## Code Examples
```python
# VIOLATION: high-level policy depends on low-level concrete
class UseCase:
    def __init__(self):
        self.db = PostgresRepository()  # concrete; DIP violated

# CORRECT: policy depends on abstraction; detail implements it
class Repository(ABC):          # in the use-case package
    @abstractmethod
    def find(self, id: int): ...

class UseCase:
    def __init__(self, repo: Repository): ...   # depends on abstraction

class PostgresRepository(Repository): ...       # detail implements contract
```
- **What it demonstrates**: Dependency points from detail toward abstraction, not from abstraction toward detail.

## Anti-patterns
- **`new ConcreteClass()` inside business logic**: Hard-codes a dependency on a detail; impossible to substitute.
- **Depending on concrete frameworks directly**: Your use case imports `Flask`, `Django`, `SQLAlchemy` — the framework now owns the dependency direction.
- **Interface in the wrong package**: If the interface lives in the implementor's package, the client still has a transitive dependency on that package.

## Key Takeaways
1. DIP: Both high-level and low-level modules depend on abstractions; details depend on interfaces, not vice versa.
2. Interface placement: the interface belongs in the high-level (client) package — this is the inversion.
3. Abstractions change rarely; concretes change frequently — dependency direction should match change stability.
4. Every DIP seam is a potential architectural boundary — the place where an inner circle ends and an outer circle begins.

## Connects To
- **Ch 5**: OOP polymorphism makes DIP achievable — interfaces enable the inversion.
- **Ch 22**: The Dependency Rule is the system-wide expression of DIP: all dependencies point inward (toward abstraction).
- **Ch 17**: Boundaries are drawn by applying DIP — the interface is the seam, the concrete is on the other side.
