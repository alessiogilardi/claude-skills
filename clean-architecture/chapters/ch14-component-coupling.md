# Chapter 14: Component Coupling

## Core Idea
Three principles govern component dependencies: no cycles (ADP), depend in the direction of stability (SDP), and stable components should be abstract (SAP) — together these form the DIP applied at the component level, ensuring the dependency graph is a directed acyclic graph pointing from volatile to stable.

## Frameworks Introduced
- **ADP — Acyclic Dependencies Principle**: Allow no cycles in the component dependency graph.
  - When to use: When analyzing or designing component dependency structure.
  - How: Treat the dependency graph as a DAG; if a cycle appears, break it via DIP (add an interface) or by extracting a new component.
- **SDP — Stable Dependencies Principle**: Depend in the direction of stability.
  - When to use: Before adding a dependency from one component to another.
  - How: Compute I = Fan-out / (Fan-in + Fan-out). Ensure I(depender) > I(dependee). Dependencies should point toward lower I (higher stability).
- **SAP — Stable Abstractions Principle**: A component should be as abstract as it is stable.
  - When to use: When designing stable components that must still be extensible.
  - How: Stable components (low I) should consist mostly of interfaces and abstract classes; concrete components should be unstable (high I).

## Key Concepts
- **Morning After Syndrome**: Coming in to find your code broken because someone changed a component you depend on — caused by cycles in the dependency graph.
- **Fan-in**: Number of incoming dependencies (other components depending on this one).
- **Fan-out**: Number of outgoing dependencies (this component depending on others).
- **I (Instability)**: I = Fan-out / (Fan-in + Fan-out). Range [0, 1]. I=0 = maximally stable; I=1 = maximally unstable.
- **A (Abstractness)**: A = Na / Nc. Ratio of abstract classes/interfaces to total classes. Range [0, 1].
- **The Main Sequence**: The ideal line where A + I ≈ 1. Components should be either (abstract+stable) or (concrete+unstable). Components far from this line are problematic.
- **Zone of Pain**: Highly stable and concrete (I≈0, A≈0) — rigid, hard to change, cannot be extended.
- **Zone of Uselessness**: Highly abstract and unstable (I≈1, A≈1) — never depended on, useless.
- **Component structure evolves bottom-up**: Cannot be designed top-down; emerges as classes accumulate and the team applies SRP, CCP, and ADP.

## Reference Tables

| Metric | Formula | Interpretation |
|---|---|---|
| Fan-in | Count of external classes depending on this component | High Fan-in = stable, hard to change |
| Fan-out | Count of internal classes depending on external classes | High Fan-out = unstable, many sources of change |
| I (Instability) | Fan-out / (Fan-in + Fan-out) | 0=stable, 1=unstable |
| A (Abstractness) | Na / Nc | 0=concrete, 1=fully abstract |
| Distance from Main Sequence | \|A + I - 1\| | 0=ideal, >0.2 = investigate |

| Zone | A | I | Problem |
|---|---|---|---|
| Zone of Pain | ≈ 0 | ≈ 0 | Stable+Concrete: rigid, unchangeable |
| Zone of Uselessness | ≈ 1 | ≈ 1 | Abstract+Unstable: depended on by no one |
| Main Sequence | A+I ≈ 1 | — | Ideal: stable=abstract, unstable=concrete |

## Anti-patterns
- **Dependency cycles**: Create "the morning after syndrome" — components cannot be tested or released independently.
- **Stable component depending on volatile component**: Makes the volatile component difficult to change (violates SDP).
- **Concrete stable components (Zone of Pain)**: Cannot be extended without modification — the opposite of OCP.
- **Top-down component design**: Component structure designed before classes exist ignores the actual change axes; it will be wrong.

## Key Takeaways
1. ADP: No cycles in the component dependency graph — break cycles with DIP or by extracting a new component.
2. SDP: I metrics must decrease in the direction of dependency — volatile depends on stable.
3. SAP: Stable components should be abstract; unstable components should be concrete.
4. SDP + SAP = DIP for components: dependencies run in the direction of abstraction.
5. Component structure cannot be designed top-down; it evolves as classes accumulate.

## Connects To
- **Ch 11**: DIP is the mechanism for breaking dependency cycles and implementing SDP.
- **Ch 13**: CCP/REP determine which classes go in a component; ADP/SDP/SAP determine how components relate.
- **Ch 22**: The Dependency Rule in Clean Architecture is the system-level expression of ADP + SDP.
