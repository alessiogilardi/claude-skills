# Chapter 19: Policy and Level

## Core Idea
"Level" is the distance from inputs and outputs — the higher the level, the farther from I/O — and source code dependencies must be coupled to level (pointing toward higher-level policy), not to data flow; this ensures that trivial I/O changes do not force changes in high-level business logic.

## Frameworks Introduced
- **Level Definition**: Level = distance from the inputs and outputs of the system. The farther a policy is from I/O, the higher its level.
  - When to use: When deciding which component should depend on which.
  - How: Ask — "How far is this component from the data entry point and the output?" The answer determines its level.
- **Level-Coupled Dependencies**: Source code dependencies must point toward higher-level (farther from I/O) components, regardless of data flow direction.
  - When to use: When wiring components together.
  - How: If data flows from A→B→C but C is highest-level, then B and A must depend on C's interfaces, not vice versa.

## Key Concepts
- **Encryption example**: `Translate` (the encryption algorithm) is highest-level because it is farthest from both input and output devices. `ConsoleReader` and `ConsoleWriter` are lowest-level.
- **Naive implementation failure**: `encrypt() { while(true) writeChar(translate(readChar())); }` — high-level `encrypt` depends on low-level `readChar`/`writeChar`. Data flow and dependencies both go the same direction — wrong.
- **Correct implementation**: `CharReader` and `CharWriter` interfaces defined inside the `Encrypt` component's boundary. `ConsoleReader` and `ConsoleWriter` implement those interfaces. Data still flows: Input → Translate → Output. Dependencies: ConsoleReader → Encrypt ← ConsoleWriter.
- **Why it matters**: I/O devices change more frequently and for less important reasons than high-level algorithms. Pointing dependencies toward the high-level algorithm insulates it from I/O changes.
- **Policy grouping = SRP + CCP applied to level**: Policies that change for the same reasons and at the same times should be in the same component, and those components should be ordered by level.

## Code Examples
```python
# WRONG: high-level policy depends on low-level I/O
def encrypt():
    while True:
        write_char(translate(read_char()))  # encrypt knows about I/O

# CORRECT: interfaces at the boundary; I/O implements them
class CharReader(ABC):        # inside Encrypt's boundary
    @abstractmethod
    def read(self) -> str: ...

class CharWriter(ABC):        # inside Encrypt's boundary
    @abstractmethod
    def write(self, c: str): ...

class Translate:              # high-level — knows nothing about I/O
    def __init__(self, reader: CharReader, writer: CharWriter): ...

class ConsoleReader(CharReader): ...    # depends on Encrypt
class ConsoleWriter(CharWriter): ...    # depends on Encrypt
```
- **What it demonstrates**: Data flows down (input → translate → output); dependencies point up (console → translate).

## Anti-patterns
- **Data-flow-aligned dependencies**: Letting dependencies follow the data flow direction creates a chain where I/O changes propagate all the way to high-level policy.
- **Level inversion**: A high-level component that `import`s a low-level one is a level inversion — source code dependencies contradict levels.

## Key Takeaways
1. Level = distance from I/O. Higher-level = farther from inputs and outputs.
2. Source code dependencies must point toward higher-level components, regardless of data flow direction.
3. Lower-level (I/O) components change more frequently and for less important reasons — insulate high-level policy from them.
4. Separate policies by level into separate components; wire them so lower depends on higher.

## Connects To
- **Ch 17**: Boundaries are the mechanism; this chapter defines the direction they should run.
- **Ch 22**: The four rings of Clean Architecture are a direct application of the level concept.
- **Ch 20**: Entities (high-level) and Use Cases (medium-level) are "farther from I/O" — correctly placed at the center.
