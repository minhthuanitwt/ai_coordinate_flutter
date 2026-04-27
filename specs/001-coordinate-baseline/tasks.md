# Tasks: Auth-Gated Protected Tabs

**Input**: Design documents from `/specs/001-coordinate-baseline/`
**Prerequisites**: plan.md, spec.md, research.md, data-model.md, contracts/, quickstart.md

**Tests**: Include focused widget and integration-style Flutter tests for guest redirection, login flow state, and protected-tab access because the plan explicitly requires verification for auth gating.

**Organization**: Tasks are grouped by user story so each story can be implemented and validated independently.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (`[US1]`, `[US2]`, `[US3]`)
- Include exact file paths in descriptions

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Restore the minimum auth scaffolding and generated-file workflow needed for the feature.

- [ ] T001 Add auth-related dependencies and generator prerequisites in pubspec.yaml
- [X] T002 [P] Create the auth screen directory structure under lib/presentation/screens/auth/
- [X] T003 [P] Add source localization keys for login and auth-required messaging in assets/i18n/en.i18n.json and assets/i18n/ja.i18n.json

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Build the shared auth/session infrastructure that blocks all protected-tab stories.

**⚠️ CRITICAL**: No user story work can begin until this phase is complete.

- [X] T004 Create the auth session model in lib/core/models/auth_session.dart
- [X] T005 [P] Create the auth repository contract in lib/domain/repository/auth_repository.dart
- [X] T006 [P] Implement Supabase-backed auth repository methods in lib/services/supabase_auth_repository.dart
- [X] T007 Create shared auth/session providers for current user, auth state, and redirect target in lib/presentation/providers/auth_session_provider.dart
- [ ] T008 Update Supabase bootstrap behavior for auth-aware initialization in lib/services/supabase_service.dart and lib/presentation/providers/app_bootstrap_provider.dart
- [X] T009 Add the login route and protected destination wiring in lib/routes/app_router.dart
- [ ] T010 Regenerate router artifacts in lib/routes/app_router.gr.dart via build_runner
- [X] T011 Regenerate localization artifacts in lib/i18n/strings.g.dart, lib/i18n/strings_en.g.dart, and lib/i18n/strings_ja.g.dart via slang

**Checkpoint**: Foundation ready. Auth state, routing hooks, and generated artifacts are available for story work.

---

## Phase 3: User Story 1 - Browse the public app surface (Priority: P1) 🎯 MVP

**Goal**: Keep `home` fully public while ensuring the rest of the app can coexist with auth-aware routing.

**Independent Test**: Launch as a guest and verify `home` still renders banners/feed normally while shell navigation remains stable and no login screen appears until a protected destination is requested.

### Tests for User Story 1

- [X] T012 [P] [US1] Add a guest-home routing test in test/routes/public_home_route_test.dart

### Implementation for User Story 1

- [ ] T013 [US1] Update app router/bootstrap composition for auth-aware public entry in lib/app.dart and lib/main.dart
- [X] T014 [US1] Update the shell tab configuration so `home` remains public and protected tabs are identifiable in lib/presentation/screens/shell/app_shell_page.dart
- [ ] T015 [US1] Ensure public home behavior stays unchanged with the auth-aware shell in lib/presentation/screens/home/home_page.dart and lib/presentation/screens/home/home_view_model.dart

**Checkpoint**: Guests can still use `home` independently without being forced into authentication.

---

## Phase 4: User Story 2 - Enter protected areas through authentication (Priority: P2)

**Goal**: Guests who open protected tabs are redirected into a minimal login flow and return to the requested destination after successful sign-in.

**Independent Test**: As a guest, attempt to open each protected tab and verify the app navigates to login instead of rendering protected content; after successful login, verify the app lands on the originally requested tab.

### Tests for User Story 2

- [X] T016 [P] [US2] Add login form state and submission tests in test/presentation/auth/login_view_model_test.dart
- [X] T017 [P] [US2] Add protected-tab guest redirection tests in test/routes/protected_tab_redirect_test.dart

### Implementation for User Story 2

- [X] T018 [P] [US2] Create login page state in lib/presentation/screens/auth/login_state.dart
- [X] T019 [P] [US2] Create login page view-model in lib/presentation/screens/auth/login_view_model.dart
- [X] T020 [US2] Build the login page UI in lib/presentation/screens/auth/login_page.dart
- [X] T021 [US2] Add shell-level protected-tab interception and redirect-target persistence in lib/presentation/screens/shell/app_shell_page.dart and lib/presentation/providers/auth_session_provider.dart
- [X] T022 [US2] Add post-login redirect handling from login back into protected tabs in lib/presentation/screens/auth/login_view_model.dart and lib/presentation/screens/auth/login_page.dart

**Checkpoint**: Guests are consistently redirected to login for protected tabs, and successful login returns them to the requested destination.

---

## Phase 5: User Story 3 - Review the owner coordinate board (Priority: P3)

**Goal**: Authenticated users can access protected tabs, and protected screens react correctly if the session disappears.

**Independent Test**: Sign in with a valid user, open `coordinate`, and confirm the board loads as before; while on a protected tab, simulate sign-out or missing session and verify the app exits protected content and returns to login.

### Tests for User Story 3

- [X] T023 [P] [US3] Add authenticated coordinate access tests in test/presentation/coordinate/coordinate_auth_gate_test.dart
- [X] T024 [P] [US3] Add session-expiry redirect tests for protected tabs in test/routes/protected_session_expiry_test.dart

### Implementation for User Story 3

- [X] T025 [US3] Reintroduce auth-aware loading and empty-state handling for the coordinate tab in lib/presentation/screens/coordinate/coordinate_state.dart and lib/presentation/screens/coordinate/coordinate_view_model.dart
- [X] T026 [US3] Prevent guest rendering and handle session loss in lib/presentation/screens/coordinate/coordinate_page.dart
- [X] T027 [P] [US3] Add protected access handling for lib/presentation/screens/challenge/challenge_page.dart
- [X] T028 [P] [US3] Add protected access handling for lib/presentation/screens/notifications/notifications_page.dart
- [X] T029 [P] [US3] Add protected access handling for lib/presentation/screens/my_profile/my_profile_page.dart

**Checkpoint**: Authenticated users can use protected tabs, and expired sessions no longer leave stale private content on screen.

---

## Phase 6: Polish & Cross-Cutting Concerns

**Purpose**: Final verification and cleanup across all stories.

- [X] T030 [P] Update auth-gating copy consistency in assets/i18n/en.i18n.json and assets/i18n/ja.i18n.json
- [ ] T031 Run generated-file refresh for routing and localization in . via `fvm dart run build_runner build -d` and `fvm dart run slang`
- [X] T032 Run verification for the feature in . via `fvm dart analyze lib` and targeted `flutter test` commands

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies; can start immediately.
- **Foundational (Phase 2)**: Depends on Setup; blocks all story work.
- **User Story 1 (Phase 3)**: Depends on Foundational completion.
- **User Story 2 (Phase 4)**: Depends on Foundational completion and can start after US1 if shell/public behavior needs to be stabilized first.
- **User Story 3 (Phase 5)**: Depends on Foundational completion and uses the login/session flow from US2.
- **Polish (Phase 6)**: Depends on all intended stories being complete.

### User Story Dependencies

- **US1**: No dependency on other user stories; validates the public home remains intact.
- **US2**: Depends on foundational auth/session wiring but not on US3.
- **US3**: Depends on US2 because protected screen behavior requires the restored login/session flow.

### Within Each User Story

- Tests should be added before or alongside implementation and fail before the corresponding fix.
- State and model work should land before page integration.
- Shell/router integration should be complete before validating redirect flows.

### Parallel Opportunities

- T002 and T003 can run in parallel during setup.
- T005 and T006 can run in parallel after the session model shape is clear.
- T016 and T017 can run in parallel for US2.
- T018 and T019 can run in parallel for US2.
- T027, T028, and T029 can run in parallel for protected placeholder tabs.
- T030 and final verification prep can run in parallel once implementation stabilizes.

---

## Parallel Example: User Story 2

```bash
# Build auth screen state and tests in parallel:
Task: "Add login form state and submission tests in test/presentation/auth/login_view_model_test.dart"
Task: "Create login page state in lib/presentation/screens/auth/login_state.dart"
Task: "Create login page view-model in lib/presentation/screens/auth/login_view_model.dart"

# Build redirect behavior in parallel where files do not overlap:
Task: "Add protected-tab guest redirection tests in test/routes/protected_tab_redirect_test.dart"
Task: "Add shell-level protected-tab interception and redirect-target persistence in lib/presentation/screens/shell/app_shell_page.dart and lib/presentation/providers/auth_session_provider.dart"
```

---

## Implementation Strategy

### MVP First (User Story 1 Only)

1. Complete Phase 1: Setup.
2. Complete Phase 2: Foundational auth/session infrastructure.
3. Complete Phase 3: Keep public home stable with auth-aware shell wiring.
4. Validate guest launch behavior on `home`.

### Incremental Delivery

1. Finish Setup + Foundational.
2. Deliver US1 to preserve current public value.
3. Deliver US2 to restore login and protected-tab redirection.
4. Deliver US3 to reconnect protected content and session-expiry handling.
5. Finish with regeneration and verification.

### Parallel Team Strategy

1. One developer handles auth repository/session providers.
2. One developer handles login page and i18n.
3. One developer handles shell/protected-tab integration after foundation lands.

---

## Notes

- All tasks follow the required checklist format with IDs and file paths.
- Generated files are only referenced through regeneration tasks, not direct manual edits.
- `home` staying public is treated as a first-class deliverable, not an implied side effect.
