# Chapter 32: Frameworks Are Details

## Core Idea
Frameworks are not architectures — they are details that belong in the outermost ring; the framework-you relationship is asymmetrically risky (you commit fully, the author commits nothing to you); the solution is to use frameworks without marrying them.

## Frameworks Introduced
- **Framework at Arm's Length**: Use the framework as a plugin; never let it into the inner circles of your architecture.
  - When to use: Every time you adopt a new framework.
  - How: Depend on the framework only in the outermost components. Create proxy classes that derive from the framework's base classes, then use those proxies as plugins. Your business rules never `import` the framework.
- **Asymmetric Marriage**: The framework author has committed to nothing; you have committed to everything. This asymmetry means the framework's risks fall entirely on you.

## Key Concepts
- **Framework authors' problems ≠ your problems**: Frameworks solve the author's problems and similar problems. They may not fit yours — and as your product matures, the mismatch grows.
- **Framework risks**:
  1. Framework architecture often violates Dependency Rule — asks you to inherit into your Entities.
  2. Framework may fight you as your product matures and outgrows its facilities.
  3. Framework may evolve in directions you don't want, forcing costly upgrades.
  4. A better framework comes along and you can't switch.
- **The wedding ring metaphor**: Coupling to a framework is marrying it. Once on, the ring doesn't come off without pain.
- **The solution — "Don't marry the framework!"**: Use it; don't couple to it. Derive proxy classes; put them in plugin components. Business rules never see the framework.
- **Spring example**: You can use Spring for DI without putting `@Autowired` annotations in your business objects. Wire dependencies in `Main`, not in the domain.
- **Framework-as-plugin**: A good framework fits into the outermost ring (Frameworks & Drivers) and plugs into your architecture through stable interfaces — never the reverse.

## Anti-patterns
- **Business objects extending framework base classes**: `class User extends ActiveRecord`, `class Order extends models.Model` — framework classes contaminate the domain.
- **`@Autowired` throughout business logic**: DI framework annotations in domain classes — domain now depends on the framework at compile time.
- **Letting the framework dictate the project structure**: Organizing packages as `controllers/`, `models/`, `views/` because Rails says so.
- **Using the framework's test abstractions in unit tests**: Coupling tests to the framework means tests fail when the framework changes, not when behavior changes.

## Key Takeaways
1. Frameworks are details — powerful tools, but details. They belong in the outermost ring.
2. The framework-you relationship is asymmetric: you marry it, it doesn't marry you.
3. Don't marry the framework: use proxy classes, keep it in plugins, never let it into your business rules.
4. Specific risk: frameworks ask you to derive your Entities from their base classes — this violates the Dependency Rule.
5. Spring, Django, Rails etc. are tools. Treat them like you treat your database.

## Connects To
- **Ch 21**: Screaming Architecture — if the framework dominates the structure, the architecture screams "Rails" not your domain.
- **Ch 26**: Main is where the framework does its work — DI wiring happens in Main, not in domain classes.
- **Ch 22**: Frameworks live in the outermost ring — they must never intrude into the inner circles.
