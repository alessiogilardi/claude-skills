# Chapter 20: Business Rules

## Core Idea
Business rules split into Entities (critical business rules that would exist without automation) and Use Cases (application-specific rules that orchestrate Entities) — both must be isolated from UI, database, and framework concerns; they are the family jewels of the system.

## Frameworks Introduced
- **Entities**: Objects that encapsulate Critical Business Rules operating on Critical Business Data.
  - When to use: For rules that make or save money regardless of whether automated (e.g., loan interest calculation).
  - How: Bind critical rules and critical data together in a single, framework-independent class or module.
- **Use Cases**: Objects that encode application-specific business rules for how an automated system is used.
  - When to use: For rules specific to an automated workflow (e.g., "cannot show payment estimation until credit score is checked").
  - How: One function per use case; accepts simple request data structures; returns simple response data structures; orchestrates Entities.
- **Request/Response Models**: Simple data structures (not framework types) that carry input/output for use cases.
  - When to use: At every use case boundary.
  - How: Plain data structures; no HttpRequest, no ORM entity references; independent of everything.

## Key Concepts
- **Critical Business Rules**: Rules that make or save money, independent of automation. Would exist in a manual system.
- **Critical Business Data**: The data the Critical Business Rules operate on — loan balance, interest rate, payment schedule.
- **Entity**: Critical Business Rules + Critical Business Data, bound together in a single module. Not an ORM entity — framework-independent.
- **Use Case**: Application-specific; closer to I/O than Entities. Orchestrates Entities. Cannot tell from a use case how the UI looks.
- **Dependency direction**: Entities are highest-level (farther from I/O). Use Cases depend on Entities. Entities do not know about Use Cases.
- **Entity ≠ Request/Response model**: Even when they share similar data, they change for different reasons (SRP). Do not share them or couple them.
- **Tramp data**: Unnecessary fields passed through use cases just to satisfy framework requirements — a sign of coupling to infrastructure.

## Mental Models
- Entities are business objects — they exist in the real world (the loan exists even without software).
- Use cases are automation scripts — they only make sense in an automated system.
- "Business rules should remain pristine, unsullied by baser concerns such as the user interface or database used."

## Anti-patterns
- **Entity inherits from framework type**: ORM entities (`django.db.models.Model`, JPA `@Entity`) mix persistence with business rules — tight coupling.
- **Use case knows about HTTP**: If a use case imports `HttpRequest`, it cannot be used without a web framework — kills independence.
- **Sharing Entity and Response model**: Different lifecycles and change axes; merging creates tramp data and conditional logic.
- **Use case without input/output data structures**: Passing raw HTTP params or DB rows into use case functions.

## Key Takeaways
1. Entities = Critical Business Rules + Critical Business Data, framework-independent, highest-level.
2. Use Cases = application-specific orchestration of Entities, one level below Entities.
3. Dependency direction: Use Cases → Entities (not vice versa). Entities don't know use cases exist.
4. Request/Response models: plain data structures at the use case boundary — no framework types.
5. Business rules are the family jewels — protect them from every peripheral concern.

## Connects To
- **Ch 19**: Entities are farthest from I/O (highest level); Use Cases are one level below.
- **Ch 22**: The Clean Architecture rings directly map to Entity/Use Case/Interface Adapter/Framework layers.
- **Ch 23**: Presenters and the Humble Object Pattern handle the data flow between Use Cases and UI.
