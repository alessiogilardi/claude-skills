# Chapter 5: Object-Oriented Programming

## Core Idea
OOP's true architectural gift is not encapsulation or inheritance but safe, convenient polymorphism — which enables the plugin architecture pattern by allowing source code dependencies to be inverted relative to the flow of control.

## Frameworks Introduced
- **Plugin Architecture via Polymorphism**: High-level policy modules define interfaces; low-level detail modules implement them. Dependencies point toward policy, not toward details.
  - When to use: Wherever a high-level component should be insulated from changes in a lower-level component.
  - How: Define an interface in the high-level package; the low-level implementation depends on it (not vice versa).
- **Dependency Inversion via OOP**: By using interfaces/abstract classes, source code dependencies can be made to oppose the flow of control.
  - When to use: At every architectural boundary.
  - How: High-level module calls an interface; low-level module implements it; flow of control goes down, dependency points up.

## Key Concepts
- **Encapsulation (qualified)**: C provided perfect encapsulation via header/implementation separation. Java/C# weakened it by requiring declarations in class definitions visible to all. OOP did not invent encapsulation.
- **Inheritance (qualified)**: Existed before OOP as manual re-declaration of variables in the enclosing scope (C programmers did this). OOP codified it.
- **Polymorphism (the real gift)**: Before OOP, polymorphism was achievable via function pointers but was dangerous (manual discipline required). OOP made it safe and trivially achievable everywhere.
- **Dependency Inversion Principle (preview)**: By inserting an interface, the high-level module no longer depends on the low-level module — either can be changed independently.

## Mental Models
- Use OOP's polymorphism when you need to isolate a high-level component from a low-level detail — the interface is the seam.
- Think of each `interface ← implementation` pair as a plugin socket: the socket owner controls the contract.
- Encapsulation is a discipline concern, not a language feature. Languages can break it (public fields) even when calling themselves OOP.

## Anti-patterns
- **Inheritance for code reuse**: Inheritance creates the tightest possible coupling. Prefer composition.
- **Depending on the concrete**: High-level modules that `import` or instantiate low-level concrete classes are tightly coupled and untestable.
- **Framework-owned interfaces**: When the framework defines the interfaces your business logic must implement, the dependency points the wrong way — toward the framework.

## Key Takeaways
1. OOP's real gift is safe polymorphism, enabling dependency inversion at any boundary.
2. Before OOP, function-pointer-based polymorphism was possible but required dangerous manual discipline.
3. Dependency inversion: use interfaces so that high-level policy does not depend on low-level detail.
4. Plugin architecture is the direct application: detail modules plug into abstract interfaces defined by policy.

## Connects To
- **Ch 3**: OOP = discipline on indirect transfer of control (polymorphism).
- **Ch 11**: DIP formalizes this as a design principle.
- **Ch 17**: Drawing boundaries relies on dependency inversion at each seam.
