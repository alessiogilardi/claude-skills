# Chapter 4: Structured Programming

## Core Idea
Structured programming replaces unrestrained goto with disciplined control structures (sequence, selection, iteration), enabling functional decomposition and making software falsifiable — the same scientific discipline that makes empirical science valid.

## Frameworks Introduced
- **Functional Decomposition**: Break a large problem into high-level functions; recursively decompose each into lower-level functions, all provably correct.
  - When to use: When designing algorithms and module hierarchies.
  - How: Apply sequence, selection, and iteration; each unit is independently testable.
- **Software as Science (Falsifiability)**: We cannot prove programs correct, but we can prove them incorrect via tests. Tests are the scientific method applied to code.
  - When to use: Setting expectations for testing strategy.
  - How: Write tests that can fail; passing tests mean "not yet proven wrong."

## Key Concepts
- **Dijkstra's insight (1968)**: Unrestricted goto makes it impossible to apply mathematical induction to prove correctness.
- **Three control structures**: Sequence, selection (if/then/else), iteration (do/while) — together they are provably sufficient to express any computable function (Böhm & Jacopini).
- **Goto considered harmful**: Not just style — goto breaks the mathematical underpinnings that allow formal proof and structured decomposition.
- **Falsifiability**: A test that cannot fail proves nothing; tests that can fail and don't give us confidence.

## Mental Models
- Structured programming is to code what scientific method is to hypothesis: it makes claims falsifiable.
- Decomposition works because each structured unit can be independently validated before being composed.
- "Testing shows the presence of bugs, not their absence" (Dijkstra) — tests limit damage but don't guarantee correctness.

## Anti-patterns
- **Using goto / long jumps**: Destroys the ability to reason about correctness locally; makes decomposition meaningless.
- **Treating passing tests as proof of correctness**: Tests show absence of known bugs, not absence of all bugs.
- **Undecomposed functions**: Large functions that cannot be unit-tested prevent falsification at the unit level.

## Key Takeaways
1. Structured programming removes goto; imposes sequence/selection/iteration discipline.
2. This discipline enables functional decomposition — the primary algorithm design tool.
3. Software correctness is empirical (scientific), not mathematical: tests falsify, they don't prove.
4. Dijkstra: "Testing shows presence, not absence of bugs" — tests bound risk, not eliminate it.

## Connects To
- **Ch 3**: Structured programming is one of the three paradigms (discipline on direct control flow).
- **Ch 28**: The Test Boundary — tests as first-class architectural citizens follows directly from this chapter.
