# Chapter 30: The Database Is a Detail

## Core Idea
The database is architecturally a non-entity — a low-level mechanism for moving bits between disk and RAM; the data model (how business data is structured) is architecturally significant, but the database technology (SQL, NoSQL, file system) is not; never allow the DB to pollute the system architecture.

## Frameworks Introduced
- **Database as Detail**: Treat the database like any other IO device — a mechanism, not an architecture. It belongs in the outermost circle.
  - When to use: When making decisions about how to structure the system's data access layer.
  - How: All DB access goes through gateway interfaces defined in the Use Case layer; the DB-specific implementation lives in the outermost ring; business rules never see SQL or rows.
- **Data Model vs. Database**: The data model (what data you have and how it's structured in domain terms) is architecturally significant. The technology for persisting it (Postgres, MongoDB, flat files) is not.

## Key Concepts
- **Why databases became dominant**: Rotating magnetic disks are slow (milliseconds). Databases are optimized to work around disk latency with indexes, caches, and query schemes. As RAM replaces disk, the rationale for databases weakens.
- **What you really do with DB data**: You read it into RAM and reorganize it into linked lists, trees, hash tables — your domain data structures. The DB format is not your working format.
- **"What if there were no disk?"**: If all data lived in RAM, you'd use domain data structures directly. The DB is just a persistence layer for the disk era.
- **The data model is separate from the DB**: The structure of your domain objects and their relationships is architectural. The mechanism for persisting them is not.
- **The Anecdote**: Martin fought marketing to avoid an RDBMS in a system that worked perfectly with random-access files. He was right technically, wrong commercially — the lesson: know when a detail is actually a market requirement, but still keep it out of the core architecture.
- **Passing DB rows upward = architectural error**: Allowing ORM rows or table structures to flow into use cases or business rules couples the entire system to the DB schema.

## Anti-patterns
- **DB rows passed into use cases**: Mixing DB representation with business logic — any schema change ripples through the entire system.
- **ORM entities as domain entities**: Django `models.Model`, JPA `@Entity` — framework-contaminated domain objects that cannot be used without the DB framework.
- **Architecture determined by the DB schema**: Designing domain logic around the tables rather than around business concepts.
- **SQL in use cases or business rules**: Direct DB coupling that makes testing without a real DB impossible.

## Key Takeaways
1. The database is a detail — it belongs in the outermost architectural ring.
2. The data model (domain structure) is architecturally significant; the database technology is not.
3. All DB access must go through gateway interfaces; business rules never see SQL or rows.
4. As RAM replaces disk, the case for relational DBs weakens — their dominance is a historical artifact of disk latency.
5. Passing DB rows into use cases is an architectural error — schema changes then ripple everywhere.

## Connects To
- **Ch 17**: FitNesse deferred the DB decision for 18 months — this chapter explains why that's correct.
- **Ch 22**: DB lives in the outermost ring; Use Cases access it only through the DataAccessInterface.
- **Ch 23**: DB gateway implementations are Humble Objects; the gateway interface is testable.
