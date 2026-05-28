# Clean Architecture — Quick Reference

## The Dependency Rule (One Rule to Remember)
> Source code dependencies must point **only inward**, toward higher-level policy.
> Nothing in an inner ring may name anything in an outer ring.

---

## The Four Rings

| Ring (outer → inner) | Contents | Allowed to know about |
|---|---|---|
| Frameworks & Drivers | Web framework, DB engine, UI, devices | Everything (outer ring) |
| Interface Adapters | Controllers, Presenters, Gateways, Views | Use Cases (inward only) |
| Use Cases | Application-specific business rules | Entities only |
| Entities | Critical Business Rules + Critical Business Data | Nothing else |

---

## SOLID at a Glance

| Principle | Rule | Key Test |
|---|---|---|
| SRP | One actor per module | Would two different stakeholders ask for conflicting changes? |
| OCP | Extend without modifying | Does adding a new use case require editing existing classes? |
| LSP | Subtypes honor contracts | Can every subtype replace its supertype without breaking callers? |
| ISP | No fat interfaces | Does a client depend on methods it never calls? |
| DIP | Depend on abstractions | Does high-level code import a concrete low-level class? |

---

## Component Cohesion — Tension Triangle

| Principle | Focus | Violating it means... |
|---|---|---|
| REP | Reuse = release unit | Classes in component can't be released together → split |
| CCP | Change together → group | Unrelated classes change together → classes bleed across components |
| CRP | Don't depend on extras | Clients recompile for changes they don't care about |

**Choose two, sacrifice one based on current phase:**
- Early project → REP + CCP (stability less critical)
- Maturing project → CCP + CRP (fewer spurious rebuilds)
- Stable library → REP + CRP (clean reuse contract)

---

## Component Coupling Metrics

```
I  (Instability) = Fan-out / (Fan-in + Fan-out)   range [0, 1]
A  (Abstractness) = Interfaces / Total Classes      range [0, 1]
D  (Distance)    = |A + I - 1|                     ideal ≈ 0
```

| Zone | A | I | Problem |
|---|---|---|---|
| Zone of Pain | ≈0 | ≈0 | Stable + Concrete → rigid, can't extend |
| Zone of Uselessness | ≈1 | ≈1 | Abstract + Unstable → nothing depends on it |
| Main Sequence | A+I ≈ 1 | — | Ideal balance |

**SDP rule**: Dependencies must point toward lower I (more stable components).

---

## Boundary Crossing — Cost vs Isolation

| Boundary Type | Decoupling | Communication Cost | Deployment Complexity |
|---|---|---|---|
| Source-level (monolith) | Low | None | Low |
| Deployment (JAR/DLL) | Medium | None | Medium |
| Local process | High | Higher (IPC) | High |
| Service (network) | Highest | Much higher (latency) | Very high |

**Rule**: Start with source-level. Promote to deployment or service only when the cost is justified.

---

## When to Draw a Boundary

Draw a line between two things when:
1. They change at different rates
2. They have different axes of change (different actors)
3. One is a detail the other should not know about (DB, UI, framework)

Do NOT draw a boundary when:
- You're guessing about future variability (YAGNI)
- The coupling cost exceeds the boundary benefit

---

## Architecture vs Details Decision Table

| Question | Answer |
|---|---|
| Is the DB the center of the architecture? | No — it's a detail in the outermost ring |
| Does a Use Case know which DB is used? | No — it calls a Gateway interface |
| Does a Use Case know which UI is used? | No — it produces plain OutputData |
| Does the framework define the package structure? | No — the domain defines the structure |
| Where does DI wiring happen? | Only in Main |
| Where do framework annotations live? | Only in the outermost ring (adapters/Main) |

---

## Stability Direction Cheat

```
Unstable (I≈1)          →          Stable (I≈0)
Concrete                →          Abstract
Changes often           →          Changes rarely
Many Fan-out deps       →          Many Fan-in deps
Details (DB, UI)        →          Policy (Entities, Use Cases)
```

Arrow direction = dependency direction = same as this table (left depends on right is WRONG; right depends on left is WRONG; details depend on policy = correct).

---

## Quick Package Organization Comparison

| Strategy | Screams Domain | Compiler Enforcement | Best For |
|---|---|---|---|
| Package by Layer | No | Low | Simple prototypes |
| Package by Feature | Yes | Low | Growing teams |
| Ports & Adapters | Yes | Medium | Clean Arch adoption |
| Package by Component | Yes | High (package-private) | Monolith → microservices |

---

## The App-titude Test (Embedded / Any System)
1. **Make it work** — meets requirements
2. **Make it right** — decoupled, testable structure
3. **Make it fast** — optimize only after #2

Most software stops at #1. Firmware is code that never reached #2.
