# Chapter 1: What Is Design and Architecture?

## Core Idea
There is no difference between design and architecture — they form a continuous fabric from the highest to the lowest levels of a system; the only measure of quality is whether the effort to meet customer needs stays low over time.

## Frameworks Introduced
- **The Goal of Software Architecture**: Minimize the human resources required to build and maintain the required system.
  - When to use: As the north star for every architectural decision.
  - How: Measure effort to meet needs; if it grows with each release, the design is failing.
- **The Signature of a Mess**: Rising engineering headcount + declining lines of code per person + rising cost per line.
  - When to use: Diagnosing whether a codebase has structural rot.
  - How: Track these three curves over successive releases.

## Key Concepts
- **Architecture**: The shape of the system — all decisions from the highest policy to the lowest detail.
- **Design quality**: Measured solely by the effort required to meet the customer's needs, now and over time.
- **The Hare's Lie**: "We'll clean it up later" — the false belief that speed now justifies mess now.
- **The Overconfidence trap**: Developers believe they can switch from messy-fast to clean-fast; they cannot.

## Mental Models
- Think of architecture as a continuous fabric: high-level decisions and low-level details are inseparable.
- Use the TDD experiment result as evidence: disciplined work is consistently faster than undisciplined work.
- "Making messes is always slower than staying clean" — no exceptions, no time-scale exclusions.

## Anti-patterns
- **Separating architecture from design**: Believing high-level structure and low-level details are different concerns leads to one being neglected.
- **The clean-up-later myth**: Market pressures never let you go back; technical debt compounds.
- **Overconfidence in a redesign**: The same habits that made the mess will make the new mess.

## Key Takeaways
1. The goal: minimize human resources to build and maintain the system.
2. Quality = low and stable effort to meet needs; bad design = effort that grows with every release.
3. The only way to go fast is to go well — TDD studies confirm it empirically.
4. Architects must take quality seriously proactively, not reactively.

## Connects To
- **Ch 2**: Architecture is the "important" value in Eisenhower's matrix — explains why it must be fought for.
- **Ch 15**: Elaborates what "architecture" actually means in practice (leaving options open).
