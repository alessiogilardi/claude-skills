# Chapter 29: Clean Embedded Architecture

## Core Idea
Firmware — code so tightly coupled to hardware that it cannot outlive the hardware — is not an embedded-system problem only: any code that embeds SQL, platform APIs, or hardware dependencies throughout is firmware; the solution is the same as Clean Architecture: layering with HAL (Hardware Abstraction Layer) as the boundary.

## Frameworks Introduced
- **Firmware vs. Software distinction**: Firmware = code that dies when hardware changes (tightly coupled to hardware). Software = code that can outlive hardware generations (isolated from hardware behind boundaries).
  - When to use: When evaluating embedded code architecture or any code with strong platform dependencies.
  - How: Ask — "If the hardware/OS/platform changes, how much code must rewrite?" If the answer is "most of it" — it's firmware.
- **HAL — Hardware Abstraction Layer**: A clean boundary (interface) that separates business logic from hardware-specific code.
  - When to use: Whenever code must interact with hardware, OS, or platform-specific APIs.
  - How: Define an interface in terms of the behavior needed by business logic (e.g., `readSensor()`, `writeOutput()`); implement it in platform-specific code that lives behind the boundary.
- **OSAL — Operating System Abstraction Layer**: Same pattern applied to OS dependencies (threads, files, timers, mutexes).

## Key Concepts
- **The App-titude Test (Kent Beck's three phases)**:
  1. Make it work.
  2. Make it right (refactor for clarity and structure).
  3. Make it fast.
  Most embedded code stops at phase 1 — passing the App-titude test is not enough.
- **"Software does not wear out, but firmware does"**: Hardware evolves; code tightly coupled to hardware must be rewritten. Software isolated behind abstractions can live forever.
- **Non-embedded firmware**: SQL embedded in business logic = firmware. Android API calls in business logic = firmware. Platform-specific `#include` scattered throughout = firmware.
- **The App-titude failure example**: A single C file containing ISR handlers, domain logic, FLASH storage, A/D reading, and button handling — no separation of concerns. Everything is coupled to the microcontroller.
- **HAL test doubles**: With a HAL, tests run on the developer's machine without physical hardware, using test doubles for the HAL implementation.

## Reference Tables

| Layer | Contents | Changes When |
|---|---|---|
| Software (domain) | Business rules, algorithms | Business requirements change |
| OS Abstraction (OSAL) | Thread, timer, mutex wrappers | OS changes |
| Hardware Abstraction (HAL) | Sensor read/write, GPIO, UART wrappers | Hardware changes |
| Hardware drivers | Raw register access, ISR | Chip revision changes |

## Anti-patterns
- **ISR handler and business logic in the same file**: Mixed concerns; hardware interrupt code pollutes domain logic.
- **Direct hardware register access in domain logic**: Hardcodes the domain to a specific processor — replatforming requires domain rewrites.
- **Skipping refactoring after "make it work"**: Embedded code that ships without architectural cleanup becomes firmware permanently.
- **No HAL / testing on-target only**: Code that can only be tested by flashing physical hardware has a broken development loop.

## Key Takeaways
1. Firmware = code that dies when hardware changes. It's a choice, not a fate.
2. HAL + OSAL separate business logic from hardware and OS — Clean Architecture for embedded systems.
3. "Non-embedded firmware": SQL in business logic, Android API in domain, platform `#include` everywhere.
4. Make it work → Make it right → Make it fast: most embedded code stops at step 1.
5. HAL enables on-host testing with test doubles — no physical hardware required.

## Connects To
- **Ch 17**: HAL is a boundary drawn to defer/insulate hardware decisions — same principle as DB boundaries.
- **Ch 22**: Clean Architecture applies to embedded systems with HAL as the outermost ring's boundary.
- **Ch 23**: Hardware drivers are Humble Objects; the HAL interface is the testable counterpart.
