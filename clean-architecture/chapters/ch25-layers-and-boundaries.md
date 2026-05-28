# Chapter 25: Layers and Boundaries

## Core Idea
Real systems have more layers than the simple UI/rules/database triad — each independent axis of change (language, communication mechanism, data format) potentially deserves its own boundary; the architect's challenge is identifying which axes of change exist and deciding which boundaries to fully implement vs. which to ignore.

## Frameworks Introduced
- **Axis-of-Change Analysis**: For each independent dimension along which the system might vary, consider whether that variation warrants an architectural boundary.
  - When to use: When designing any system more complex than a simple CRUD app.
  - How: Ask — "What are all the independent ways this system could change?" Each answer is a potential boundary.
- **Hunt the Wumpus Architecture**: A worked example of applying Clean Architecture to a text game — game rules sit at the center; UI, language, communication mechanism, and persistence are progressively outer layers.

## Key Concepts
- **Multiple axes of change**: A UI might vary by language AND by communication mechanism (shell, SMS, chat) — these are independent axes, potentially requiring separate boundaries.
- **Abstract API components**: Dashed components in architecture diagrams that define APIs implemented by concrete components above or below them. These are the abstract interfaces that separate layers.
- **Boundary identification is hard**: The principle that "architects must identify where boundaries should be drawn" is more art than science. It requires experience and judgment.
- **Cost of under-drawing boundaries**: Missing a necessary boundary means changes to one axis propagate across to another — coupling that grows expensive over time.
- **Cost of over-drawing boundaries**: Every boundary costs development and maintenance effort. Drawing unnecessary boundaries is over-engineering.
- **Boundary as investment**: Drawing a boundary is a bet that this axis of change will matter. Sometimes the bet is wrong — partial boundaries hedge this bet.

## Mental Models
- Hunt the Wumpus: GameRules → Language API → English/Spanish; GameRules → Data Storage API → Flash/Cloud/RAM. Each outer layer is a plugin to its API.
- Think of axes of change as orthogonal dimensions. Each dimension that varies independently deserves a boundary.
- "The architect must also decide when to implement those boundaries and what form they should take." Boundaries are investments — allocate them where change is most likely and most expensive.

## Anti-patterns
- **Assuming three-layer is sufficient**: UI / Business Rules / Database is a starting point, not a complete architecture. Real systems have more independent change axes.
- **Ignoring non-obvious axes**: Language variation, communication mechanism, data format — each is a potential boundary missed by naive three-layer thinking.
- **Over-specifying boundaries upfront**: Designing 12 boundary layers before understanding the real change axes. Use partial boundaries as placeholders.

## Key Takeaways
1. Real systems have more layers than three — identify all independent axes of change.
2. Each axis of change is a potential architectural boundary; not all need to be fully implemented.
3. The architect's job: identify which boundaries exist, and decide how much to invest in each.
4. Hunt the Wumpus worked example: game rules insulated from UI (language + communication) and persistence (flash/cloud/RAM).
5. Over-drawing and under-drawing boundaries are both mistakes; wisdom is knowing which applies.

## Connects To
- **Ch 16**: Independence via dual-axis decoupling (horizontal layers + vertical use cases) — this chapter shows the pattern applies recursively.
- **Ch 24**: Partial boundaries as the pragmatic response to uncertain boundary needs.
- **Ch 33**: Case Study: Video Sales — a worked application of these boundary identification principles.
