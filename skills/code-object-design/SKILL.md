---
name: code-object-design
description: Designs, writes, reviews, and refactors maintainable Python, C++, and CUDA code using language-neutral module and object design principles with language-specific ownership, lifetime, concurrency, and GPU constraints. Use when deciding boundaries, modeling state and behavior, choosing composition versus inheritance, introducing abstractions, defining interfaces, managing C++ resources, structuring CUDA host and device code, or when the user asks for simple or minimal code without over-engineering.
---

# Code and Object Design

Manage complexity with small, explicit concepts and strong boundaries. Apply
the same design questions across languages, then respect each language's
ownership, execution, and performance model.

## Scope

Use this skill for:

- Python modules, classes, protocols, and typed data models
- modern C++ interfaces, value types, resources, and class design
- CUDA C++ host APIs, device data, kernels, and resource lifetimes
- mixed Python, C++, and CUDA systems
- design reviews and refactoring decisions

This is a design skill, not a complete language reference or CUDA optimization
playbook. Load current project conventions and official API documentation for
syntax, version, hardware, and toolchain details.

## Common design workflow

Before changing code:

1. Identify the behavior being added or the complexity being reduced.
2. Locate the knowledge that should own that behavior.
3. List the invariants that must remain true.
4. Identify ownership, lifetime, mutation, concurrency, and execution location.
5. Find existing abstractions and usage patterns before adding new ones.
6. Identify likely axes of change from evidence, not speculation.
7. Choose the smallest design that satisfies current use cases.
8. Define how correctness will be tested before optimizing structure or speed.

Preserve established conventions unless they cause a concrete problem. Prefer
deleting or simplifying code before extracting a new abstraction.

## Minimal design gate

Before adding code, walk this ladder and stop at the first sufficient solution:

1. **No change:** Is the requested behavior already present, unnecessary, or
   better solved by documentation or configuration?
2. **Delete or modify:** Can removing code or changing an existing branch solve
   it?
3. **Reuse locally:** Is there already a helper, type, pattern, or extension
   point in the codebase?
4. **Use the platform:** Can the language standard library, CUDA runtime, an
   established vendor library, or an existing dependency solve it directly?
5. **Write the direct version:** Can a focused function or small change solve
   the current case clearly?
6. **Introduce an abstraction:** Only when current requirements demonstrate a
   shared invariant, multiple real implementations, or a volatile boundary.

Do not add speculative surface area:

- no interface for one implementation without a concrete boundary or test seam
- no factory for one product
- no configuration for a value that does not need to vary
- no wrapper that only renames or forwards another call
- no new dependency for a small, clear local implementation
- no new file when the code belongs coherently in an existing module
- no generic framework extracted from one use case
- no extensibility hook justified only by possible future work

If a change adds a dependency, layer, public type, configuration option, or
substantial new logic, explain briefly why the lower ladder rungs were
insufficient. Prefer the smaller diff when correctness, safety, clarity, and
required behavior are equivalent.

Minimal design is not code golf. Do not remove validation, error handling,
resource safety, tests, observability required for operation, or necessary edge
cases merely to reduce line count.

## Shared principles

1. Make the common path obvious and misuse difficult.
2. Hide volatile decisions behind stable, narrow interfaces.
3. Keep policy separate from transport, persistence, framework, and hardware
   mechanics when they change for different reasons.
4. Keep behavior near the state and invariants it protects.
5. Prefer composition and delegation to inheritance.
6. Delay abstractions until the shared concept and variation are understood.
7. Make invalid and unhandled states visible through types and explicit errors.
8. Make dependencies, side effects, ownership, and synchronization observable.
9. Optimize for the next reader, not for cleverness or pattern density.
10. Measure performance claims using representative workloads.

Treat SOLID and design patterns as diagnostic vocabulary, not laws. Do not add
service, repository, factory, strategy, manager, or dependency-injection layers
unless they remove demonstrated coupling or variation.

## Design modules with depth

A useful module exposes a small interface while absorbing substantial
complexity:

- Callers state what they need, not every step required to obtain it.
- Representation, storage, resource, and hardware details remain internal.
- Defaults and invariants are enforced once.
- Errors use domain terms rather than leaking low-level implementation details.
- Callers do not need internal knowledge to use the module correctly.

Avoid pass-through layers whose interface is as complicated as the code they
wrap. Split modules by the knowledge they own, not execution order or arbitrary
file length.

Watch for:

- the same schema, layout rule, or business policy repeated in several places
- small changes requiring edits across unrelated files
- long chains of forwarded parameters or generic option bags
- callers interpreting raw library results or error strings
- circular dependencies
- public APIs exposing framework, persistence, or hardware types unnecessarily
- abstractions that require mode flags to recover the original behaviors

## Design objects around invariants

An object should have a coherent purpose. Define:

- what it owns and what it merely observes
- what it guarantees
- which state transitions are valid
- what operations it supports
- what representation it hides
- which failures are expected at its boundary
- whether it is safe to copy, move, share, or use concurrently

Encapsulation is not adding getters and setters. It is preventing representation
dependencies and preserving invariants through meaningful operations.

Prefer values and free functions when identity, lifecycle, or protected mutable
state are absent. Do not create a class merely to group static methods.

## Prefer composition

Pass or construct collaborators explicitly when behavior must vary. Composition
makes dependencies visible and lets behavior change without creating a rigid
class hierarchy.

Use inheritance only when all are true:

1. The relationship is genuinely "is-a," not code reuse.
2. Subtypes preserve the complete behavioral contract.
3. Base invariants remain valid for every subtype.
4. Callers benefit from treating subtypes uniformly.
5. The hierarchy is more stable and understandable than composition.

Never require callers to inspect concrete subtype names to use the hierarchy.
In performance-sensitive C++ and CUDA code, also account for indirection,
layout, allocation, and device-support costs.

## Introduce abstractions carefully

The rule of three is a warning, not a quota. Similar syntax may represent
different concepts; repeated knowledge may deserve immediate centralization.

Extract when:

- the shared concept has a precise name
- an invariant or policy must remain synchronized
- callers need a stable boundary around volatile details
- current use cases demonstrate meaningful variation
- the result reduces total cognitive load

Do not extract when:

- only syntax is duplicated
- cases are likely to evolve independently
- the abstraction needs flags for each original case
- callers must understand every implementation to use it
- the interface is larger or more abstract than the problem
- it obscures ownership, synchronization, memory traffic, or performance cost

After extraction, compare total code, concepts, dependencies, and call-site
clarity. Revert if complexity increased.

## Control dependencies and state

Dependencies should point toward stable policy:

- boundary adapters translate external data into owned domain types
- consumers define the smallest interface they need
- concrete dependencies are correct when there is one stable implementation
- ordinary arguments or constructors are the default dependency injection
- domain rules should not import delivery, storage, or GPU launch mechanisms

Model distinct states with distinct types when their data or valid operations
differ. Handle closed enums and unions exhaustively. Validate untrusted inputs
at system boundaries and fail loudly on violated internal invariants.

Choose one coherent error model at each boundary. Translate errors only when
adding useful context or moving between abstraction layers; preserve the
original cause or status.

## Python guidance

Use the least powerful construct that expresses the model:

- a function for a stateless operation
- a module for related knowledge and operations
- a frozen dataclass for a value with named fields
- a class for identity, lifecycle, mutable state, or enforced invariants
- an enum or discriminated union for a closed set of states
- a `Protocol` for a consumer-owned behavioral contract with multiple useful
  implementations or a real test seam

Python defaults:

- Use type hints to communicate contracts, not to imitate C++.
- Prefer immutable values where mutation is unnecessary.
- Use context managers for deterministic resource lifetime; garbage collection
  is not a resource-management contract.
- Validate dynamic or external data at boundaries.
- Do not pass raw dictionaries through internal layers when a named type makes
  the contract clearer.
- Keep imports one-directional; do not use runtime import tricks to hide a
  broken package boundary.
- Prefer explicit control flow over metaprogramming.
- Use assertions only for internal invariants, not user or external input.
- Preserve exception causes when translating failures.

## C++ guidance

C++ design must make lifetime and ownership explicit:

- Prefer scoped objects and value semantics.
- Use RAII for memory, files, locks, threads, sockets, GPU resources, and every
  acquire/release pair.
- Prefer the Rule of Zero. Define copy and move operations only when ownership
  semantics require it.
- Treat raw pointers, references, `std::span`, and views as non-owning; ensure
  the owner outlives every view.
- Use `std::unique_ptr` for exclusive heap ownership. Use `std::shared_ptr` only
  when shared lifetime is an actual requirement, not as a default.
- Express nullability and optional results deliberately.
- Make interfaces const-correct and keep mutation narrow.
- Give polymorphic bases a correct destruction policy.
- Constrain generic interfaces with concepts when constraints improve errors
  and document the real contract.
- Keep template and metaprogramming complexity behind small interfaces.
- Use `noexcept` only when the operation meets that contract.
- Do not mix exceptions and status returns arbitrarily; follow the surrounding
  system's error boundary.

Avoid manual `new`/`delete`, owning raw pointers, hidden global state, and
undefined behavior as an optimization. Verify applicable C++ changes with
compiler warnings, tests, and sanitizers. Benchmark before adding cache,
allocation, SIMD, or template complexity.

## CUDA C++ guidance

CUDA shares C++'s lifetime rules and adds execution and memory-space boundaries.
Design the host API, device data, and kernel separately.

### Host boundary

- Give allocations, streams, events, graphs, modules, and library handles RAII
  owners with explicit move/copy policy.
- Keep a small launch interface that validates shapes, types, alignment,
  architecture requirements, and launch configuration.
- Check launch and asynchronous execution errors at intentional boundaries.
- Keep CUDA runtime details out of domain policy.
- Prefer established libraries such as cuBLAS, cuDNN, CUB, or CUTLASS when they
  satisfy the requirement; custom kernels need a concrete reason.

### Asynchronous lifetime

- A host scope ending does not prove asynchronous GPU work has finished.
- Do not free, reuse, mutate, or unmap memory before dependent work completes.
- Make stream ownership and cross-stream dependencies explicit with events or
  another documented synchronization mechanism.
- Avoid device-wide synchronization as an implicit correctness crutch.
- Document whether an API is synchronous, enqueues work, or transfers ownership.

### Device representation

- Prefer simple, data-oriented kernel parameters and device representations.
- Do not mirror a host-side object hierarchy inside a hot kernel.
- Separate metadata and ownership on the host from bulk data consumed by the
  device.
- Choose array-of-structures versus structure-of-arrays from actual access
  patterns; adjacent threads should access data coherently when possible.
- Account explicitly for memory space, alignment, aliasing, and bounds.
- Minimize host/device transfers and keep intermediate data on the device when
  doing so simplifies the pipeline and avoids transfer cost.

### Kernel correctness and performance

- Specify which thread owns each output and which synchronization scope protects
  shared state.
- Handle tails and irregular shapes rather than assuming tile divisibility.
- Treat races, out-of-bounds access, divergent barriers, and use-before-complete
  as correctness defects.
- Keep a trusted reference implementation and compare representative edge cases.
- Optimize only after correctness, benchmarking, and profiling.
- Record the target compute capability and guard architecture-specific features.
- Re-measure after every layout, tiling, occupancy, or synchronization change;
  performance intuition is not evidence.

## Mixed-language boundaries

At Python/C++/CUDA boundaries:

- Define ownership and lifetime across the foreign-function interface.
- Validate device, dtype, shape, stride, alignment, and contiguity assumptions.
- Translate errors without discarding the native diagnostic.
- Avoid hidden copies and synchronizations; document unavoidable ones.
- Keep ABI-facing interfaces narrow and stable.
- Test teardown, exceptions, and asynchronous failure paths, not only success.

## Review checklist

- Is this the smallest change that solves the stated problem?
- Is each rule or piece of knowledge owned in one place?
- Are interfaces simpler than their implementations?
- Are invariants enforced rather than merely documented?
- Are ownership, lifetime, mutation, execution location, and synchronization
  explicit?
- Is composition used where inheritance would couple unrelated concerns?
- Does each abstraction correspond to a current concept?
- Are invalid and unhandled states explicit?
- Can policy be tested without unnecessary infrastructure or hardware?
- For C++, are RAII, copy/move behavior, view lifetimes, and error semantics
  correct?
- For CUDA, are asynchronous lifetimes, memory spaces, access patterns, launch
  validation, and hardware assumptions correct?
- Did measurement justify every performance-motivated complexity increase?
- Did the change reduce the number of concepts a reader must hold?

Explain recommendations in terms of concrete complexity, correctness, or
measured performance. Do not cite a principle as the sole justification.

## Exemplars

When substantial new structure is unavoidable, read [EXEMPLARS.md](EXEMPLARS.md)
for narrow examples of simple Python, C++, and CUDA design. Learn the decision
and boundary each repository demonstrates; do not copy its architecture,
implementation, or style without checking the target context and license.

## Sources and maintenance

This skill synthesizes:

- [Python Design](https://github.com/mindfold-ai/Trellis/blob/main/.claude/skills/python-design/SKILL.md)
- [Object-Oriented Programmer](https://github.com/Pyroxin/opinionated-claude-skills/blob/main/opinionated-software-engineering/skills/object-oriented-programmer/SKILL.md)
- [C++ Core Guidelines](https://github.com/isocpp/CppCoreGuidelines)
- [C++ Coding Standards](https://github.com/affaan-m/everything-claude-code/blob/main/skills/cpp-coding-standards/SKILL.md)
- [C++ Pro](https://github.com/jeffallan/claude-skills/blob/main/skills/cpp-pro/SKILL.md)
- [CUDA C++ Best Practices Guide](https://docs.nvidia.com/cuda/cuda-c-best-practices-guide/)
- [CUDA Code Skill](https://github.com/ForceInjection/cuda-code-skill)
- [Kernel Skills](https://github.com/KrxGu/kernel-skills)
- [Lean Code](https://github.com/anastasiyaw/claude-code-config/blob/main/skills/lean-code/SKILL.md)
- [Ponytail](https://github.com/DietrichGebert/ponytail)

These are research inputs, not pinned dependencies. Before a substantial
revision, prefer current official Python, ISO C++, and NVIDIA CUDA documentation,
then compare newer agent skills for useful workflows. Do not preserve advice
that conflicts with the target repository, compiler, CUDA Toolkit, or GPU
architecture.
