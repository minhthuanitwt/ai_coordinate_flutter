# Quickstart: Implement My Page Screen

## Prerequisites

- Flutter SDK via `fvm` configured for this repository.
- Dependencies installed with `fvm flutter pub get`.
- Valid Supabase config for end-to-end data verification (or local fallback
  strategy for non-configured state testing).

## Implementation Steps

1. Create My Page feature module:
   - `lib/presentation/screens/my_page/my_page_page.dart`
   - `lib/presentation/screens/my_page/my_page_state.dart`
   - `lib/presentation/screens/my_page/my_page_view_model.dart`
2. Add domain/data layer:
   - `lib/domain/repository/my_page_repository.dart`
   - `lib/services/supabase_my_page_repository.dart`
   - Add any required models in `lib/core/models/`.
3. Wire providers and route:
   - Register repository provider.
   - Update `lib/routes/app_router.dart` to use new My Page page class.
   - Keep protected tab index mapping unchanged.
4. Add localization keys (EN + JA) for My Page blocks and states.
5. Generate code:
   - `fvm dart run build_runner build --delete-conflicting-outputs`
   - Regenerate i18n using the repository’s current slang workflow.

## Verification

1. Static checks:
   - `fvm dart analyze lib`
2. Behavior checks:
   - Signed-in user opens My Page and sees 4 data blocks.
   - Signed-out user tapping My Page is redirected to login.
   - Empty image list shows empty state (not blank screen).
   - Simulated fetch error shows retryable error state.
3. Optional:
   - Add/update widget tests for section rendering and state transitions.

## Out of Scope (for this slice)

- `my-page/account`
- `my-page/contact`
- `my-page/credits`
- Full parity with every web My Page sub-feature
