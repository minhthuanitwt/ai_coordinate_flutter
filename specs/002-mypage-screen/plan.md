# Implementation Plan: Home and My Page Appbars

**Branch**: `002-mypage-screen` | **Date**: 2026-04-24 | **Spec**: [/Users/dongdm/Develop/Source/doi/new/ai_coordinate_flutter/specs/002-mypage-screen/spec.md](/Users/dongdm/Develop/Source/doi/new/ai_coordinate_flutter/specs/002-mypage-screen/spec.md)
**Input**: Feature specification from `/specs/002-mypage-screen/spec.md`

**Note**: This template is filled in by the `/speckit.plan` command. See `.specify/templates/plan-template.md` for the execution workflow.

## Summary

Implement two production-ready appbar variants that match provided references:
1) Home top appbar (brand + search surface + utility actions), and
2) My Page top appbar/profile header with right-side menu action.
Behavior follows current web product as source-of-truth, including protected-action visibility for unauthenticated users, plus a right-side drawer for My Page menu action. Delivery reuses existing Flutter architecture (AutoRoute + Riverpod + feature screen modules) and adds targeted UI behavior wiring without route-architecture changes.

## Technical Context

<!--
  ACTION REQUIRED: Replace the content in this section with the technical details
  for the project. The structure here is presented in advisory capacity to guide
  the iteration process.
-->

**Language/Version**: Dart 3.10.x, Flutter 3.38.9  
**Primary Dependencies**: flutter/material, auto_route, hooks_riverpod, supabase_flutter, slang/slang_flutter  
**Storage**: Supabase backend (remote), shared_preferences for local fallback/session mock  
**Testing**: flutter_test (widget/unit as needed), dart analyze, manual UI verification on app runtime  
**Target Platform**: Flutter mobile app (Android and iOS; mobile viewport acceptance 360dp-430dp)
**Project Type**: mobile-app  
**Performance Goals**: Smooth header rendering and tab switching at normal 60fps interaction baseline; no visible layout jump/flicker during Home/My Page tab switches  
**Constraints**: Must preserve existing routing/state architecture; protected actions hidden when unauthenticated; all reference actions implemented with web-aligned behavior; no overlap in 360dp/390dp/430dp widths  
**Scale/Scope**: Two screen headers (Home, My Page), appbar action behavior wiring, right-side drawer interaction, localization-safe text handling

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

- **Gate I - Documentation Before Implementation**: PASS
  - `spec.md` is complete and clarified; this `plan.md` is generated before implementation.
- **Gate II - Minimal Scoped Delivery**: PASS
  - Scope constrained to Home/My Page top sections and related appbar actions only.
- **Gate III - Existing Architecture First**: PASS
  - Plan reuses existing screen modules, Riverpod providers, and app routing model.
- **Gate IV - Generated Artifacts Are Regenerated**: PASS
  - Any localization/router/freezed generated files will be regenerated via supported commands.
- **Gate V - Verification Is Mandatory**: PASS
  - Plan includes mandatory analyze + focused UI behavior verification steps.

## Project Structure

### Documentation (this feature)

```text
specs/002-mypage-screen/
├── plan.md              # This file (/speckit.plan command output)
├── research.md          # Phase 0 output (/speckit.plan command)
├── data-model.md        # Phase 1 output (/speckit.plan command)
├── quickstart.md        # Phase 1 output (/speckit.plan command)
├── contracts/           # Phase 1 output (/speckit.plan command)
└── tasks.md             # Phase 2 output (/speckit.tasks command - NOT created by /speckit.plan)
```

### Source Code (repository root)
<!--
  ACTION REQUIRED: Replace the placeholder tree below with the concrete layout
  for this feature. Delete unused options and expand the chosen structure with
  real paths (e.g., apps/admin, packages/something). The delivered plan must
  not include Option labels.
-->

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
│       ├── home/
│       └── my_page/
├── routes/
├── services/
└── themes/

assets/
└── i18n/

android/
ios/

test/
└── (unit/widget tests)
```

**Structure Decision**: Keep current Flutter single-app structure. Implement feature changes in existing screen modules (`lib/presentation/screens/home`, `lib/presentation/screens/my_page`) with shared UI utilities in `lib/presentation/components` only when duplication is unavoidable.

## Post-Design Constitution Check

- **Gate I - Documentation Before Implementation**: PASS
  - `research.md`, `data-model.md`, `contracts/`, and `quickstart.md` created before task breakdown.
- **Gate II - Minimal Scoped Delivery**: PASS
  - No unrelated refactor added; only header/action scope is represented in artifacts.
- **Gate III - Existing Architecture First**: PASS
  - Design keeps existing routes/providers/repositories; no architecture replacement.
- **Gate IV - Generated Artifacts Are Regenerated**: PASS
  - Design explicitly calls regeneration for i18n/router/freezed changes when applicable.
- **Gate V - Verification Is Mandatory**: PASS
  - Quickstart includes analyze and focused behavior checks tied to success criteria.

## Complexity Tracking

> **Fill ONLY if Constitution Check has violations that must be justified**

| Violation | Why Needed | Simpler Alternative Rejected Because |
|-----------|------------|-------------------------------------|
| None | N/A | N/A |
