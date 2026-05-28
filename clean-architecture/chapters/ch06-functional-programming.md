# Chapter 6: Functional Programming

## Core Idea
Functional programming disciplines assignment by favoring immutability, which eliminates an entire class of concurrency bugs and race conditions; architecturally, the key is to segregate mutable state into clearly bounded, isolated components.

## Frameworks Introduced
- **Segregation of Mutability**: Separate mutable and immutable components. All concurrency-related bugs arise from mutable state; confine mutation to a known, isolated zone.
  - When to use: When designing concurrent or distributed systems.
  - How: Identify which components must mutate state; wrap them with transactional/CAS mechanisms; keep the rest purely functional (immutable).
- **Event Sourcing**: Store a log of transactions rather than the current state; derive current state by replaying the log.
  - When to use: When you need audit trails, temporal queries, or to eliminate mutable persistent state.
  - How: Every state change is an event appended to an immutable log; current state = replay(all events).

## Key Concepts
- **Immutability**: Variables that never change after initialization. Eliminates race conditions and concurrent update bugs entirely.
- **Referential transparency**: A function that always returns the same output for the same input — no hidden side effects.
- **λ-calculus (Alonzo Church, 1936)**: The mathematical foundation of functional programming, predating computers.
- **Event Sourcing insight**: If storage and processing are fast enough, we never need mutable state at all — we store events and compute current state on demand.

## Mental Models
- "All race conditions, deadlocks, and concurrent update problems are due to mutable variables." — Eliminate mutation, eliminate the bugs.
- Use functional components for the "read" path; confine transactional components to the "write" path.
- Event sourcing is the logical extreme: no mutable state, just an append-only log.

## Anti-patterns
- **Shared mutable state across threads**: The root cause of most concurrency bugs; no locking strategy fully compensates.
- **Hidden side effects in "functional" code**: A function that mutates global state or a database is not referentially transparent.
- **Storing current state only**: Loses audit history and makes temporal queries impossible; events are more general.

## Key Takeaways
1. Functional programming disciplines assignment — the third paradigm constraint (after control flow and polymorphism).
2. Immutability eliminates the entire class of concurrency bugs caused by mutable shared state.
3. Segregate mutability: make most components immutable; isolate the mutable components behind transactional boundaries.
4. Event sourcing: store events, derive state — no mutable state at all if storage allows.

## Connects To
- **Ch 3**: Functional = discipline on assignment — the third paradigm constraint.
- **Ch 20**: Business Rules (Entities / Use Cases) benefit from immutability in their core domain logic.
- **Ch 30**: The database as a detail relates to event sourcing — the DB is just a cache of the event log.
