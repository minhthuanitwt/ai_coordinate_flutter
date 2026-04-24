# Tasks: My Page Screen (Initial Flutter Port)

**Input**: Design documents from `/Users/dongdm/Develop/Source/doi/new/ai_coordinate_flutter/specs/20260425-my-page-screen/`
**Prerequisites**: plan.md, spec.md, research.md, data-model.md, contracts/my-page-contract.md, quickstart.md

**Tests**: No mandatory TDD tasks were explicitly requested in the spec. This task list includes verification tasks (`dart analyze` + manual scenario checks).

**Organization**: Tasks are grouped by user story so each story can be implemented and verified independently.

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Prepare feature scaffolding and naming alignment for My Page implementation.

- [X] T001 Create My Page screen module directory and scaffold files in `lib/presentation/screens/my_page/my_page_page.dart`, `lib/presentation/screens/my_page/my_page_state.dart`, and `lib/presentation/screens/my_page/my_page_view_model.dart`
- [X] T002 Create My Page domain/repository and service scaffolds in `lib/domain/repository/my_page_repository.dart` and `lib/services/supabase_my_page_repository.dart`
- [X] T003 [P] Add My Page provider scaffold in `lib/presentation/providers/my_page_provider.dart`

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Build shared models and wiring required before user story implementation.

**⚠️ CRITICAL**: User story work starts after this phase completes.

- [X] T004 Create core My Page models in `lib/core/models/my_page_profile.dart`, `lib/core/models/my_page_stats.dart`, `lib/core/models/my_page_balance.dart`, and `lib/core/models/my_page_image_item.dart`
- [X] T005 Implement `MyPageRepository` contract methods in `lib/domain/repository/my_page_repository.dart` using contract from `specs/20260425-my-page-screen/contracts/my-page-contract.md`
- [X] T006 Implement Supabase-backed data mapping and exceptions in `lib/services/supabase_my_page_repository.dart`
- [X] T007 Wire repository/provider dependencies in `lib/presentation/providers/my_page_provider.dart`
- [X] T008 Replace route import and tab route target from `my_profile` to `my_page` in `lib/routes/app_router.dart` (and keep generated router output up to date in `lib/routes/app_router.gr.dart`)

**Checkpoint**: Foundation ready for My Page story development.

---

## Phase 3: User Story 1 - Open My Page after login (Priority: P1) 🎯 MVP

**Goal**: Signed-in users can open `my-page` and see real sections (profile, stats, balance, gallery) instead of placeholder content.

**Independent Test**: Sign in, open `my-page`, verify all 4 sections render with loading to success transition.

- [X] T009 [US1] Define Freezed state for initial load, refresh, pagination, and error fields in `lib/presentation/screens/my_page/my_page_state.dart`
- [X] T010 [US1] Implement load/refresh/loadMore actions in `lib/presentation/screens/my_page/my_page_view_model.dart`
- [X] T011 [US1] Build profile header section UI in `lib/presentation/screens/my_page/my_page_page.dart`
- [X] T012 [P] [US1] Build user stats section UI in `lib/presentation/screens/my_page/my_page_page.dart`
- [X] T013 [P] [US1] Build credit balance section UI in `lib/presentation/screens/my_page/my_page_page.dart`
- [X] T014 [US1] Build generated-image gallery section with pagination trigger in `lib/presentation/screens/my_page/my_page_page.dart`
- [X] T015 [US1] Add My Page localization keys for English and Japanese in `assets/i18n/en.i18n.json` and `assets/i18n/ja.i18n.json`
- [X] T016 [US1] Regenerate localization and state-related generated artifacts in `lib/i18n/strings.g.dart`, `lib/i18n/strings_en.g.dart`, `lib/i18n/strings_ja.g.dart`, and `lib/presentation/screens/my_page/my_page_state.freezed.dart`

**Checkpoint**: User Story 1 is functional and independently testable.

---

## Phase 4: User Story 2 - Handle empty and partial data safely (Priority: P2)

**Goal**: My Page remains understandable with missing profile fields, no images, or partial backend failures.

**Independent Test**: Use account with sparse data and verify fallback avatar/text, empty gallery state, and retryable errors.

- [X] T017 [US2] Add fallback mapping rules for nullable profile/stats/balance fields in `lib/services/supabase_my_page_repository.dart`
- [X] T018 [US2] Add section-level error typing and non-fatal partial-success handling in `lib/presentation/screens/my_page/my_page_state.dart`
- [X] T019 [US2] Update view-model to keep successful sections visible when one section fails in `lib/presentation/screens/my_page/my_page_view_model.dart`
- [X] T020 [US2] Implement empty gallery and missing-profile fallback UI states in `lib/presentation/screens/my_page/my_page_page.dart`
- [X] T021 [US2] Add retry actions for failed blocks and refresh behavior without full-screen flicker in `lib/presentation/screens/my_page/my_page_page.dart`
- [X] T022 [US2] Add localized empty/error/fallback copy in `assets/i18n/en.i18n.json` and `assets/i18n/ja.i18n.json` and regenerate `lib/i18n/strings*.dart`

**Checkpoint**: User Story 2 works independently with robust empty/partial data handling.

---

## Phase 5: User Story 3 - Respect protected tab behavior (Priority: P3)

**Goal**: Unauthenticated users are redirected to login and returned to `my-page` after sign-in.

**Independent Test**: Sign out, tap `my-page`, verify login redirection; sign in and verify redirect back to `my-page` tab.

- [X] T023 [US3] Verify and adjust protected destination mapping for My Page in `lib/presentation/providers/auth_session_provider.dart`
- [X] T024 [US3] Verify and adjust protected tab interception for My Page in `lib/presentation/screens/shell/app_shell_page.dart`
- [X] T025 [US3] Ensure login success redirect path returns to My Page tab in `lib/presentation/screens/auth/login_view_model.dart` and `lib/presentation/screens/auth/login_page.dart`
- [X] T026 [US3] Ensure My Page screen does not duplicate shell auth logic and removes legacy `my_profile` gate code in `lib/presentation/screens/my_page/my_page_page.dart` and `lib/presentation/screens/my_profile/my_profile_page.dart`
- [X] T027 [US3] Update router imports/usages from `my_profile` to `my_page` in `lib/routes/app_router.dart` and regenerate `lib/routes/app_router.gr.dart`

**Checkpoint**: User Story 3 auth-gate and redirect behavior is independently verifiable.

---

## Phase 6: Polish & Cross-Cutting Concerns

**Purpose**: Final validation and cleanup across all stories.

- [X] T028 [P] Remove obsolete My Profile placeholder references in `lib/presentation/screens/my_profile/` and related imports across `lib/`
- [X] T029 Run static verification with `fvm dart analyze lib` and resolve issues in touched files under `lib/`
- [ ] T030 [P] Execute quickstart manual scenarios from `specs/20260425-my-page-screen/quickstart.md` and document outcomes in `specs/20260425-my-page-screen/quickstart.md`
- [X] T031 Regenerate route/state/i18n artifacts and confirm clean git diff for generated files in `lib/routes/app_router.gr.dart`, `lib/presentation/screens/my_page/`, and `lib/i18n/`

---

## Dependencies & Execution Order

### Phase Dependencies

- **Phase 1 (Setup)**: no dependencies.
- **Phase 2 (Foundational)**: depends on Phase 1; blocks all user stories.
- **Phase 3 (US1)**: depends on Phase 2.
- **Phase 4 (US2)**: depends on US1 base implementation (Phase 3).
- **Phase 5 (US3)**: depends on Phase 2 and should be validated after Phase 3 to confirm My Page route exists.
- **Phase 6 (Polish)**: depends on all selected stories completion.

### User Story Dependencies

- **US1 (P1)**: first deliverable, no dependency on other stories.
- **US2 (P2)**: builds on US1 data/UI surfaces but remains independently testable.
- **US3 (P3)**: depends on existing protected-tab architecture and My Page route wiring.

### Within Each User Story

- State/model updates before view-model logic.
- View-model logic before final UI integration.
- Localization updates before final generation step.
- Verification after story-level implementation.

### Parallel Opportunities

- Phase 1: `T003` can run in parallel with `T001`/`T002`.
- US1: `T012` and `T013` can run in parallel after `T011` structure decisions.
- Phase 6: `T028` and `T030` can run in parallel with verification work.

---

## Parallel Example: User Story 1

```bash
Task: "Build user stats section UI in lib/presentation/screens/my_page/my_page_page.dart"   # T012
Task: "Build credit balance section UI in lib/presentation/screens/my_page/my_page_page.dart" # T013
```

---

## Implementation Strategy

### MVP First (US1 Only)

1. Complete Phase 1 and Phase 2.
2. Complete US1 tasks (T009-T016).
3. Validate signed-in My Page end-to-end.
4. Ship/demo MVP before US2/US3 hardening.

### Incremental Delivery

1. Deliver US1 (core content).
2. Deliver US2 (resilience and fallback handling).
3. Deliver US3 (auth-gate and redirect confirmation).
4. Finish with Phase 6 polish and verification.

### Team Parallel Strategy

1. One developer handles repository/model foundation (T004-T007).
2. One developer handles My Page UI blocks (T011-T014).
3. One developer handles auth-flow hardening (T023-T027).
4. Integrate and run shared verification in Phase 6.
