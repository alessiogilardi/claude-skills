# Chapter 18: Boundary Anatomy

## Core Idea
Boundaries take different physical forms — source-level (monolith), deployment components, local processes, and services — each with different communication costs and decoupling strengths; the dependency direction rule applies uniformly across all forms: lower-level always depends on higher-level.

## Frameworks Introduced
- **Four Boundary Forms** (ordered by decoupling strength and communication cost):
  1. *Source-level (monolith)*: Disciplined segregation in a single executable. Cheapest communication (function calls). Invisible at deployment time but architecturally real.
  2. *Deployment components*: JARs, DLLs, shared libraries — binary separation, same address space. Still cheap communication (function calls after initial load).
  3. *Local processes*: Separate OS processes, same machine. Moderate cost (OS calls, marshaling, context switches). Should not be chatty.
  4. *Services*: Separate network processes. Most expensive (milliseconds to seconds). Never chatty.

## Key Concepts
- **Boundary crossing**: At runtime, a function call from one side to the other plus data passing. The architectural challenge is managing source code dependencies, not runtime calls.
- **Why source code?**: Source code dependencies drive recompilation and redeployment. Boundaries are firewalls against change propagation.
- **Monolith boundary**: Even in a statically linked single binary, OOP-style boundaries exist and enable independent development and testing of components.
- **Dependency direction is the same for all forms**: Lower-level components are plugins to higher-level ones. Higher-level components must not name lower-level ones — at any physical boundary level.
- **Data flows vs. dependency direction**: Data may flow in any direction; source code dependencies must always point toward higher-level policy, regardless of data flow direction.
- **Chattiness cost**: Source/deployment boundaries allow chatty communication; local processes require care; service boundaries must be explicitly designed to minimize round trips.

## Reference Tables

| Boundary Type | Physical Form | Communication Cost | Coupling Strength |
|---|---|---|---|
| Source-level | Single executable | Very cheap (function calls) | Weakest (no binary separation) |
| Deployment | JARs, DLLs, .so | Cheap (function calls after load) | Moderate |
| Local processes | OS processes, same machine | Moderate (sockets, marshaling) | Strong |
| Services | Network processes | Expensive (ms to seconds) | Strongest |

## Anti-patterns
- **Chatty service boundaries**: Services that make many small calls across network boundaries suffer latency; design for coarse-grained communication at service level.
- **Higher-level service knowing the URI of a lower-level service**: Violates the dependency direction rule — the lower-level service should register with or be configured by the higher-level.
- **Assuming monolith = no architecture**: A monolith can and should have disciplined component boundaries — they're just not visible in the binary.

## Key Takeaways
1. Boundaries exist at four levels: source, deployment, local process, service — in order of increasing cost.
2. The dependency direction rule is the same for all: lower-level depends on higher-level, never vice versa.
3. Higher-level components must not know the physical address (class name, URI, process name) of lower-level components.
4. Communication cost increases with physical separation: design chattiness inversely proportional to boundary strength.
5. Most real systems use multiple boundary types simultaneously — not all-or-nothing.

## Connects To
- **Ch 17**: This chapter describes the physical forms of the boundaries drawn in Ch 17.
- **Ch 27**: Services are the service-level boundary — the cost and challenges of service boundaries are explored there.
- **Ch 22**: The Clean Architecture uses source-level and deployment boundaries between its four rings.
