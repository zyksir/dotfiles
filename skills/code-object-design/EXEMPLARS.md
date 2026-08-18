# Simple Code Exemplars

Use these repositories as targeted design studies, not templates. Read the
smallest relevant source file, identify why the design is small, and adapt only
the transferable lesson.

## Selection criteria

A useful exemplar should have:

- a narrow and explicit scope
- a small public interface relative to the behavior it provides
- visible ownership, state, and error boundaries
- source that can be understood without reconstructing a hidden framework
- tests, references, or measurements appropriate to its claims
- a clear reason for each abstraction and dependency

Small line count alone is not elegance. Reject examples that are short because
they omit correctness, safety, portability, or required edge cases.

## Anti-overengineering method

### Lean Code and Ponytail

- Repositories: [lean-code](https://github.com/anastasiyaw/claude-code-config/blob/main/skills/lean-code/SKILL.md)
  and [Ponytail](https://github.com/DietrichGebert/ponytail)
- Study: the decision ladder that considers no code, reuse, the standard
  library, native features, and existing dependencies before new abstractions.
- Apply: require a reason before adding a dependency, layer, public type, or
  configuration surface.
- Do not copy: arbitrary brevity targets or "ultra" minimalism when they would
  weaken correctness, security, validation, or maintainability.

## Python

### micrograd

- Repository: [karpathy/micrograd](https://github.com/karpathy/micrograd)
- Study: a coherent domain model expressed by a tiny `Value` core and a thin
  neural-network layer; each object corresponds to a real concept.
- Apply: start with the essential state transition and compose behavior directly
  before inventing registries, plugin systems, or framework layers.
- Do not copy: its educational omissions into production numerical software.
  Production requirements may need tensorization, validation, typing,
  serialization, observability, and stronger numerical tests.

The lesson is not "put everything in one class." It is "make the central
concept explicit and add only behavior required by the stated scope."

## C++

### scope_guard

- Repository: [ricab/scope_guard](https://github.com/ricab/scope_guard)
- Study: one narrow responsibility, a reduced public interface, RAII ownership,
  and compile-time constraints that make misuse difficult.
- Apply: wrap an acquire/release invariant once and expose the smallest useful
  operation set.
- Do not copy: a local or third-party scope guard when the target C++ standard
  library already provides the required facility. Reuse the platform first.

The lesson is not "make every utility header-only." It is "keep the interface
proportional to the problem and let the type system enforce the contract."

## CUDA and mixed C/C++

### llm.c

- Repository: [karpathy/llm.c](https://github.com/karpathy/llm.c)
- Study: an explicit complexity budget. The project keeps a readable mainline,
  uses a familiar cuBLAS call when it gives large value cheaply, and isolates
  experimental manual CUDA implementations under `dev/cuda`.
- Apply: compare measured benefit with implementation and maintenance cost;
  separate a clear reference path from specialized optimization work.
- Do not copy: its deliberate monolithic or educational organization into a
  library with different reuse, ABI, ownership, or team-scale requirements.

The strongest example is the maintainer's willingness to reject roughly 500
lines and an exotic dependency for a 2% performance gain. Performance does not
automatically outrank simplicity.

### SGEMM_CUDA

- Repository: [siboehm/SGEMM_CUDA](https://github.com/siboehm/SGEMM_CUDA)
- Study: each kernel isolates one optimization and reports its measured effect
  against the baseline and cuBLAS.
- Apply: retain a correct reference, change one important idea at a time, and
  keep benchmark evidence next to performance claims.
- Do not copy: SGEMM-specific tile sizes, layouts, or architecture assumptions
  into another kernel without profiling on the target shapes and GPU.

The lesson is not "custom kernels are better." It is "make each complexity
increase explainable and measurable."

### NVIDIA CUDA Samples

- Repository: [NVIDIA/cuda-samples](https://github.com/NVIDIA/cuda-samples)
- Study: focused examples that demonstrate one CUDA API or execution concept
  with visible host/device operations and correctness checks.
- Apply: reduce a new concept to a minimal reproducer before integrating it into
  production architecture.
- Do not copy: sample-style manual cleanup, global synchronization, hard-coded
  launch choices, or compatibility assumptions as production defaults. Adapt
  resource management to RAII and verify current CUDA documentation.

## How to use an exemplar

Before using prior art:

1. State the exact design question.
2. Read the exemplar's relevant implementation and tests, not only its README.
3. Identify the invariant or trade-off it handles elegantly.
4. Check the repository's license and the target project's dependency policy.
5. Prefer reimplementing the small idea in local conventions over copying code.
6. Record which parts do not transfer to the current scale, language version,
   hardware, or reliability requirements.
7. Keep the resulting design smaller than importing the exemplar's whole
   architecture.

## Maintenance note

These exemplars were reviewed in August 2026. Re-evaluate them before a
substantial revision. Replace or remove a repository when its useful lesson is
no longer clear, its code or license cannot be verified, its toolchain advice is
obsolete, or a smaller and better-tested example demonstrates the same idea.

When seeking replacements, search for repositories with readable core source,
focused tests or benchmarks, explicit non-goals, and evidence that maintainers
reject unnecessary features or complexity.
