# Implementation Plan: Auth-Gated Protected Tabs

**Branch**: `20260424-auth-gated-tabs` | **Date**: 2026-04-24 | **Spec**: [/Users/dongdm/Develop/Source/doi/new/ai_coordinate_flutter/specs/001-coordinate-baseline/spec.md](/Users/dongdm/Develop/Source/doi/new/ai_coordinate_flutter/specs/001-coordinate-baseline/spec.md)
**Input**: Feature specification from `/specs/001-coordinate-baseline/spec.md`

## Summary

Reintroduce a minimal authentication flow so `coordinate`, `challenge`,
`notifications`, and `my-page` become protected tabs again, while `home`
remains public. The Flutter app should follow the existing architecture
(`auto_route` + Riverpod + Supabase bootstrap), use a dedicated login screen,
and apply auth gating at navigation entry plus runtime session-loss handling.
The design should stay intentionally narrower than the Next.js reference: only
the login surface and protected-tab access rules are required for this slice.

## Technical Context

**Language/Version**: Dart 3.10.0, Flutter 3.38.9  
**Primary Dependencies**: `auto_route`, `hooks_riverpod`, `flutter_hooks`,
`supabase_flutter`, `slang`, `shared_preferences`  
**Storage**: Supabase Auth session storage via `supabase_flutter`; local device
preferences already initialized through `shared_preferences`  
**Testing**: `flutter_test`, `dart analyze`, targeted widget tests for route
guard and auth screen state  
**Target Platform**: Flutter mobile app baseline, primarily Android/iOS with
desktop/web shell support still present  
**Project Type**: Flutter mobile application  
**Performance Goals**: Protected-tab checks should resolve without perceptible
navigation lag and should not block public home rendering  
**Constraints**: Preserve current app shell and screen structure, keep `home`
public, degrade cleanly when Supabase is not configured, regenerate generated
router/i18n artifacts instead of editing them manually  
**Scale/Scope**: One login route, one shared session source, four protected tab
destinations, and shell-level navigation updates

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

- **Documentation Before Implementation**: Pass. This plan, plus research and
  design artifacts, define the change before code.
- **Minimal Scoped Delivery**: Pass. Scope is limited to login and protected-tab
  access, not full account management or signup recovery flows.
- **Existing Architecture First**: Pass. Design retains `auto_route`,
  Riverpod, Supabase bootstrap, and current page/state/view-model structure.
- **Generated Artifacts Are Regenerated**: Pass. Router and i18n changes will be
  made through source files and regeneration.
- **Verification Is Mandatory**: Pass. Plan includes `dart analyze` plus
  targeted widget or router tests for guest-to-login redirection and
  authenticated access.

**Post-Design Re-Check**: Pass. Phase 1 artifacts stay inside the existing
Flutter architecture and do not introduce unjustified complexity.

## Project Structure

### Documentation (this feature)

```text
specs/001-coordinate-baseline/
├── plan.md
├── research.md
├── data-model.md
├── quickstart.md
├── contracts/
│   └── protected-navigation.md
└── tasks.md
```

### Source Code (repository root)

```text
lib/
├── app.dart
├── main.dart
├── core/models/
├── domain/repository/
├── presentation/
│   ├── components/
│   ├── providers/
│   └── screens/
│       ├── auth/
│       ├── challenge/
│       ├── coordinate/
│       ├── home/
│       ├── my_profile/
│       ├── notifications/
│       └── shell/
├── routes/
├── services/
└── i18n/

assets/i18n/
test/
```

**Structure Decision**: Keep a single Flutter app structure. Add auth-specific
screen and session state under `lib/presentation/screens/auth/` plus any
session/auth providers under existing `presentation/providers` or adjacent
screen view-model files. Router changes stay in `lib/routes/`. Supabase auth
integration stays in `lib/services/`.

## Complexity Tracking

No constitution violations currently require justification.
