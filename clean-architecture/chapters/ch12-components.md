# Chapter 12: Components

## Core Idea
Components are the smallest entities that can be deployed independently; their history — from source-included libraries to dynamically linked plugins — reveals that the component plugin architecture is the natural endpoint of 50 years of linking and loading evolution.

## Frameworks Introduced
- **Component Plugin Architecture**: Dynamically linked files (JARs, DLLs, shared libraries) deployable and swappable at runtime, without recompiling the application.
  - When to use: As the default architectural style for independent deployment of units of functionality.
  - How: Define stable interfaces; implement behind those interfaces; load/swap at runtime.

## Key Concepts
- **Component**: The smallest entity that can be deployed independently — a JAR, DLL, shared library, or similar.
- **Linker / Loader evolution**: Source libraries → relocatable binaries → linking loaders → linkers + loaders → dynamic linking at runtime.
- **Murphy's Law of program size**: "Programs will grow to fill all available compile and link time" — the historical arms race between hardware speed and programmer ambition.
- **Relocatability**: The key breakthrough — binaries that could be loaded at any address, enabling separate compilation and linking.
- **External definitions / external references**: The metadata mechanism that allowed the linker to bind separately compiled units.

## Mental Models
- Components are the unit of deployment, not the unit of design. Design happens at the class/module level; components aggregate those decisions for deployment.
- The plugin architecture was not designed — it was an emergent consequence of decades of improving the compile-link-load cycle.
- Think of every JAR or DLL as a "socket" — it can be plugged into the system at runtime if its interface is stable.

## Anti-patterns
- **Recompiling everything on every change**: Defeats the purpose of components; signals missing component boundaries.
- **Mixing deployment units**: Putting code that deploys independently into the same component couples their release cycles unnecessarily.

## Key Takeaways
1. Components = smallest independently deployable units (JARs, DLLs, shared libraries).
2. 50-year evolution: source libraries → static linking → dynamic linking → plugin architecture.
3. The component plugin architecture is now the casual default — deploy, plug in, swap out.
4. Component structure is the physical manifestation of the design decisions made at class/module level.

## Connects To
- **Ch 13**: Component Cohesion — which classes belong together in a component.
- **Ch 14**: Component Coupling — which components can depend on which.
- **Ch 16**: Independence — how component boundaries enable independent deployment and development.
