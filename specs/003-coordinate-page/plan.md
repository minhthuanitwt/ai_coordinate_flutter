# Implementation Plan: Coordinate Page

**Branch**: `003-coordinate-page` | **Date**: 2026-04-27 | **Spec**: [spec.md](./spec.md)
**Input**: Feature specification from `/specs/003-coordinate-page/spec.md`

**Note**: This template is filled in by the `/speckit.plan` command. See `.specify/templates/plan-template.md` for the execution workflow.

## Summary

Implement the Coordinate tab end-to-end flow aligned to existing web behavior: authenticated access gating, source image selection/upload + prompt-based generation submission, configurable generation settings, percoin-aware cost feedback, asynchronous job progress tracking, timeout-safe polling recovery, and result gallery/history rendering. The implementation reuses existing Flutter architecture (AutoRoute, Riverpod, domain repositories, Supabase-backed services) with focused additions in coordinate presentation/domain paths and no route architecture rewrite.

## Technical Context

**Language/Version**: Dart 3.10.x, Flutter 3.38.9  
**Primary Dependencies**: flutter/material, auto_route, hooks_riverpod, freezed, supabase_flutter, slang/slang_flutter  
**Storage**: Supabase Postgres + Storage (remote), local app state via Riverpod/view model state  
**Testing**: flutter_test (unit/widget), `fvm dart analyze`, focused runtime manual checks on emulator/device  
**Target Platform**: Flutter mobile app (Android/iOS; mobile viewport first)
**Project Type**: mobile-app  
**Performance Goals**: First progress feedback <= 3s for 95% submissions; no visible jank in settings changes or gallery updates on typical modern device  
**Constraints**: Auth gate is mandatory; percoin charge only on successful output; local upload constraints JPG/PNG/WebP <= 10MB; polling timeout 90s then recover via re-entry  
**Scale/Scope**: One feature slice (Coordinate screen + supporting providers/repository/model paths), single-user session interactions, paginated personal generated history

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

- **Gate I - Documentation Before Implementation**: PASS
  - `spec.md` clarified and this `plan.md` is produced before implementation tasks.
- **Gate II - Minimal Scoped Delivery**: PASS
  - Scope limited to Coordinate feature behavior and directly required supporting artifacts only.
- **Gate III - Existing Architecture First**: PASS
  - Plan keeps current Flutter architecture, routing, and Riverpod-based state flow.
- **Gate IV - Generated Artifacts Are Regenerated**: PASS
  - Any localization/freezed/router code changes will use project generators (`slang`, `build_runner`) rather than manual edits.
- **Gate V - Verification Is Mandatory**: PASS
  - Plan includes analyze plus focused runtime verification aligned to success criteria.

## Project Structure

### Documentation (this feature)

```text
specs/003-coordinate-page/
├── plan.md              # This file (/speckit.plan command output)
├── research.md          # Phase 0 output (/speckit.plan command)
├── data-model.md        # Phase 1 output (/speckit.plan command)
├── quickstart.md        # Phase 1 output (/speckit.plan command)
├── contracts/           # Phase 1 output (/speckit.plan command)
└── tasks.md             # Phase 2 output (/speckit.tasks command - NOT created by /speckit.plan)
```

### Source Code (repository root)
```text
lib/
├── domain/
│   ├── models/
│   ├── failures/
│   └── repository/
├── presentation/
│   ├── components/
│   ├── providers/
│   └── screens/
│       └── coordinate/
├── routes/
├── services/
└── i18n/

assets/
└── i18n/

test/
├── presentation/coordinate/
└── routes/
```

**Structure Decision**: Keep the existing single Flutter app layout and implement Coordinate changes inside existing feature directories (`lib/presentation/screens/coordinate`, `lib/domain/repository`, `lib/domain/models`, optional shared components/providers) without creating new architectural layers.

## Post-Design Constitution Check

- **Gate I - Documentation Before Implementation**: PASS
  - `research.md`, `data-model.md`, `contracts/`, and `quickstart.md` are produced before `/speckit.tasks`.
- **Gate II - Minimal Scoped Delivery**: PASS
  - Design artifacts remain limited to Coordinate behaviors and directly related contracts.
- **Gate III - Existing Architecture First**: PASS
  - Design preserves route, provider, and repository topology already used in project.
- **Gate IV - Generated Artifacts Are Regenerated**: PASS
  - Artifact guidance includes regeneration commands for generated files.
- **Gate V - Verification Is Mandatory**: PASS
  - Quickstart defines required analyze and runtime verification checklist.

## Complexity Tracking

> **Fill ONLY if Constitution Check has violations that must be justified**

| Violation | Why Needed | Simpler Alternative Rejected Because |
|-----------|------------|-------------------------------------|
| None | N/A | N/A |
