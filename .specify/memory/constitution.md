# AI Coordinate Constitution

## Core Principles

### I. Documentation Before Implementation
Every non-trivial change starts with explicit specification and planning
artifacts. Code changes follow approved intent instead of defining it.

### II. Minimal Scoped Delivery
Each feature should be broken into the smallest independently testable slice
that delivers user value without unrelated refactors.

### III. Existing Architecture First
Changes must preserve the current Flutter architecture, routing model, and state
management approach unless the active spec explicitly calls for a structural
change.

### IV. Generated Artifacts Are Regenerated
Generated files are never hand-edited. If a change affects generated output, the
source definition must be updated and regeneration performed through the
supported toolchain.

### V. Verification Is Mandatory
Completed work must include the lightest meaningful verification for the scope,
then broader analysis or tests when the change surface warrants it.

## Project Constraints

- English is the source language for repository documentation and code comments.
- User-facing collaboration in this workspace may happen in Vietnamese.
- Supabase-backed flows must degrade cleanly when data is empty or unavailable.
- UI work must keep explicit `loading`, `error`, `empty`, and `success` states.

## Workflow Rules

- Start with `/speckit.constitution` only when project governance needs to
  change.
- Use `/speckit.specify` to define one feature slice at a time.
- Use `/speckit.plan` before implementation for any change that is more than a
  trivial edit.
- Keep active feature work under `specs/<feature>/`.
- Preserve user changes already present in the workspace unless explicitly asked
  to replace them.

## Governance

Repository instruction files such as `AGENTS.md` override this constitution when
they conflict. All spec-kit artifacts in this app must remain consistent with
those repository instructions.

**Version**: 1.0.0 | **Ratified**: 2026-04-10 | **Last Amended**: 2026-04-10
