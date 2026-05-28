# Chapter 10: ISP — The Interface Segregation Principle

## Core Idea
Don't force clients to depend on methods they don't use; in statically typed languages this means smaller, client-specific interfaces; architecturally it means avoiding depending on modules that carry more than you need.

## Frameworks Introduced
- **ISP (Interface Segregation Principle)**: No client should be forced to depend on methods it does not use.
  - When to use: When a large interface serves multiple different clients, or when a module pulls in a dependency it only partially uses.
  - How: Split the fat interface into smaller, role-specific interfaces; each client depends only on its slice.
- **ISP as an Architectural Warning**: Depending on a module with more operations than you need creates unnecessary coupling — changes to the unneeded operations still force recompilation/redeployment.
  - When to use: When evaluating whether a dependency is appropriate at the component or service level.
  - How: Ask — "If a function I don't use changes in this dependency, do I need to rebuild?" If yes, the interface is too fat.

## Key Concepts
- **Fat interface**: A single interface containing methods for multiple different roles/clients.
- **Interface pollution**: Adding methods to a shared interface because it's convenient — forces all clients to recompile when any method changes.
- **Dynamic vs. static typing**: ISP is less critical in dynamically typed languages (e.g., Python, Ruby) because there is no source code coupling from unused methods. It remains architecturally relevant regardless.
- **ISP and architecture**: Depending on a framework or library that contains much more than you need couples you to all of it — changes in unused parts can still force recompilation and redeployment.

## Reference Tables

| Scenario | Problem | Solution |
|---|---|---|
| Fat `OPS` interface used by User, Admin, and Audit | Each change to any method forces recompile for all clients | Split into `UserOps`, `AdminOps`, `AuditOps` |
| System A imports System D just for one feature | System A is recompiled when any feature of D changes | Isolate the needed feature behind a narrow interface |
| Framework dependency with 50 features | Changes to unused features affect your build | Wrap the framework behind a facade exposing only what you use |

## Anti-patterns
- **One giant interface for all clients**: Any change to any method forces all clients to recompile/revalidate/redeploy.
- **Depending on a module you only partially use**: Your deployment cycle is now coupled to unrelated changes in that module.
- **Adding methods to existing interfaces for convenience**: Each addition propagates coupling to all existing clients.

## Key Takeaways
1. ISP: No client should depend on methods it doesn't use — split fat interfaces.
2. Architecturally: unnecessary dependencies = unnecessary coupling to unrelated changes.
3. A module that imports more than it uses is fragile — it may be forced to change for reasons unrelated to its purpose.
4. In dynamically typed languages ISP is less acute syntactically, but the architectural principle still applies.

## Connects To
- **Ch 11**: DIP — both principles reduce coupling, but ISP addresses breadth while DIP addresses direction.
- **Ch 14**: Component Coupling — ISP applied at the component level prevents instability spreading.
- **Ch 32**: Frameworks Are Details — ISP is why you should wrap frameworks, not depend on them directly.
