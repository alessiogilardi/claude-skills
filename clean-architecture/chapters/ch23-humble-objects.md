# Chapter 23: Presenters and Humble Objects

## Core Idea
The Humble Object pattern splits testable behavior from hard-to-test behavior at each architectural boundary — the Presenter is testable, the View is humble; this separation simultaneously improves testability and reveals architectural boundaries.

## Frameworks Introduced
- **Humble Object Pattern**: Split behaviors into two modules — one humble (hard to test, kept minimal), one testable (all logic extracted for easy testing).
  - When to use: Wherever a component is hard to unit test (UI, sensors, hardware interfaces).
  - How: Extract all logic from the hard-to-test component into a testable counterpart; leave the humble object doing nothing but mechanical I/O.
- **Presenter / View split**:
  - *View* (humble): Receives a ViewModel and mechanically renders it to the screen. No logic. Hard to test automatically.
  - *Presenter* (testable): Accepts domain data from the use case; converts it to strings, booleans, and enums in the ViewModel. Contains all display logic. Easily unit-tested.
  - When to use: At every GUI boundary.
  - How: Presenter converts `Date` to `"2024-01-15"`, `Currency` to `"$1,234.56"`, boolean flags for graying buttons — all in ViewModel strings/booleans.

## Key Concepts
- **ViewModel**: A plain data structure (strings, booleans, enums) that the View mechanically copies to the screen. No computation in the View.
- **Database Gateways (Humble Objects)**: Polymorphic interfaces between Use Cases and database implementation. The gateway interface is testable (use cases use it); the SQL implementation is humble. Use cases never write SQL.
- **Service Listeners / Data Mappers**: Also Humble Objects — the mechanical interface layer between a service boundary and the business logic.
- **Testability = architectural quality**: The ability to separate testable from non-testable behavior consistently indicates that architectural boundaries are drawn correctly.
- **Data Access Interfaces (Gateway interfaces)**: Defined in the Use Case layer; implemented by the DB layer. Use Cases call `UserGateway.getLastNamesOfUsersWhoLoggedInAfter(date)` — never SQL.

## Reference Tables

| Boundary | Humble Side | Testable Side |
|---|---|---|
| UI | View (renders ViewModel to screen) | Presenter (formats domain data into ViewModel) |
| Database | DB Adapter (executes SQL) | Use Case Interactor (calls gateway interface) |
| Service | Service Listener (reads from wire) | Service Interactor (processes data) |
| Embedded | Hardware Driver (talks to chip) | Business Logic Module (processes readings) |

## Anti-patterns
- **Logic in the View**: Any conditional, formatting, or computation in the View makes it hard to test and embeds business decisions in the UI layer.
- **SQL in Use Cases**: Use Cases calling SQL directly are coupled to the database — the gateway pattern was not applied.
- **Presenter depends on framework View type**: If the Presenter knows about `HttpResponse` or `React.Component`, the testable boundary is polluted.
- **Skipping the ViewModel**: Passing domain objects directly to the View — the View now has logic to render them.

## Key Takeaways
1. Humble Object: split into humble (hard-to-test, minimal) and testable (all logic, easily tested).
2. View = humble (renders ViewModel); Presenter = testable (converts domain data to ViewModel strings/booleans).
3. Gateway interfaces in the Use Case layer; SQL/ORM implementation in the DB layer — Use Cases never write SQL.
4. Every Humble Object split reveals an architectural boundary — testability and architecture are the same thing.

## Connects To
- **Ch 22**: The output port (UseCase → Presenter) crossing in the Clean Architecture is implemented via the Humble Object pattern.
- **Ch 28**: Tests as first-class architectural elements — Humble Object enables testability without full framework setup.
- **Ch 29**: Clean Embedded Architecture applies the Humble Object pattern extensively for hardware abstraction.
