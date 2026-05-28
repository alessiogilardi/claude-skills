# Chapter 3: Paradigm Overview

## Core Idea
The three programming paradigms each impose discipline by removing a freedom from the programmer — none adds capabilities; all subtract, and together they define the boundaries within which software architects must work.

## Frameworks Introduced
- **Three Paradigms as Constraints**:
  - *Structured programming*: Imposes discipline on **direct transfer of control** (no unrestrained goto).
  - *Object-oriented programming*: Imposes discipline on **indirect transfer of control** (safe polymorphism via function pointer discipline).
  - *Functional programming*: Imposes discipline on **assignment** (immutability).
  - When to use: When choosing which paradigm tools to use for which architectural concerns.

## Key Concepts
- **Paradigm**: A way of programming, relatively independent of language; tells you which structures to use and when.
- **Disciplined removal**: Each paradigm removes power from the programmer (goto, unconstrained function pointers, mutable state) — power that was dangerous.
- **Completeness**: There are likely no further paradigms; all three were discovered between 1958 and 1968 and together cover the full space.

## Mental Models
- Think of paradigms not as additions but as constraints — similar to how scientific laws constrain physics. The constraint is the value.
- Structured → **function** (decompose behavior). OOP → **component** (manage polymorphic dependencies). Functional → **data** (isolate mutable state).
- Each paradigm maps to an architectural concern: structured decomposition for algorithms, OOP for dependency management across boundaries, functional for safe concurrency/state.

## Anti-patterns
- **Paradigm mixing without discipline**: Using goto-style control flow inside OOP code, or mutating state inside functional pipelines, defeats the discipline each paradigm provides.
- **Language as paradigm**: Assuming a language forces a paradigm (e.g., Java = OOP only) limits architectural thinking.

## Key Takeaways
1. Three paradigms, three constraints: structured (control flow), OOP (polymorphism), functional (mutation).
2. All three were discovered within a decade (1958–1968); no new paradigms are expected.
3. Paradigms tell architects what they must NOT do, which defines safe design space.
4. Each paradigm serves a different architectural concern: decomposition, dependency, concurrency.

## Connects To
- **Ch 4**: Deep dive into structured programming and its proof-based foundations.
- **Ch 5**: OOP's true gift is safe, plugin-style polymorphism for dependency management.
- **Ch 6**: Functional programming's immutability as the solution to concurrent state bugs.
