# Tasks: Coordinate Page

**Input**: Design documents from `/specs/003-coordinate-page/`  
**Prerequisites**: plan.md (required), spec.md (required for user stories), research.md, data-model.md, contracts/

**Tests**: No mandatory test-first tasks are included because the spec does not explicitly require TDD. Verification is handled via analyze + runtime checklist in quickstart.

**Organization**: Tasks are grouped by user story so each story can be implemented and validated independently.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no blocking dependency)
- **[Story]**: User story label (`[US1]`, `[US2]`, `[US3]`) for story-phase tasks only
- Include exact file paths in each task description

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Prepare feature-level copy, screen structure, and generated assets needed by Coordinate implementation.

- [X] T001 Add Coordinate generation/recovery copy keys in `assets/i18n/en.i18n.json` and `assets/i18n/ja.i18n.json`
- [X] T002 [P] Create Coordinate feature component folder and base widgets in `lib/presentation/screens/coordinate/widgets/coordinate_generation_form_section.dart`, `lib/presentation/screens/coordinate/widgets/coordinate_progress_section.dart`, and `lib/presentation/screens/coordinate/widgets/coordinate_gallery_section.dart`
- [X] T003 [P] Regenerate localization outputs in `lib/i18n/strings.g.dart`, `lib/i18n/strings_en.g.dart`, and `lib/i18n/strings_ja.g.dart`

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Build core domain/state/repository primitives required before user stories.

**⚠️ CRITICAL**: No user story work begins until this phase is complete.

- [X] T004 Create Coordinate request/input domain models in `lib/domain/models/coordinate_generation_request.dart` and `lib/domain/models/coordinate_source_image_input.dart`
- [X] T005 [P] Create Coordinate async tracking domain models in `lib/domain/models/coordinate_generation_job.dart` and `lib/domain/models/coordinate_polling_recovery_state.dart`
- [X] T006 [P] Extend repository failure surface for generation/polling/upload errors in `lib/domain/failures/coordinate_repository_failure.dart`
- [X] T007 Extend Coordinate repository contract + Supabase implementation for submit, poll, in-progress recovery, and history pagination in `lib/domain/repository/coordinate_repository.dart`
- [X] T008 Expand Coordinate screen state shape (form inputs, validation, progress, timeout/recovery, history merge metadata) in `lib/presentation/screens/coordinate/coordinate_state.dart`
- [X] T009 Rebuild Coordinate view model foundation methods for initialize/submit/poll/loadMore/recover flows in `lib/presentation/screens/coordinate/coordinate_view_model.dart`

**Checkpoint**: Foundation ready - user story implementation can start.

---

## Phase 3: User Story 1 - Generate coordinated images from source (Priority: P1) 🎯 MVP

**Goal**: Authenticated user can submit valid coordinate generation request and see async progress/results.

**Independent Test**: Signed-in user selects source image + prompt, submits generation, sees progress updates, and receives completed output without full reload.

### Implementation for User Story 1

- [X] T010 [US1] Enforce unauthenticated redirect-to-login with return target `Coordinate` in `lib/presentation/screens/coordinate/coordinate_page.dart`
- [X] T011 [P] [US1] Implement source image input UX (upload or stock selection) with mode-switch invalidation in `lib/presentation/screens/coordinate/widgets/coordinate_generation_form_section.dart`
- [X] T012 [US1] Implement submit validation (required fields, prompt length, supported mime types, <=10MB upload) in `lib/presentation/screens/coordinate/coordinate_view_model.dart`
- [X] T013 [P] [US1] Wire generation submit + per-job progress rendering in `lib/presentation/screens/coordinate/coordinate_view_model.dart` and `lib/presentation/screens/coordinate/widgets/coordinate_progress_section.dart`
- [X] T014 [US1] Render Coordinate page scaffold (title, description, percoin summary, form, progress, result sections) in `lib/presentation/screens/coordinate/coordinate_page.dart`

**Checkpoint**: US1 works independently as MVP.

---

## Phase 4: User Story 2 - Control settings and percoin behavior (Priority: P2)

**Goal**: User can configure generation settings and understand/enforce percoin-related constraints before and during generation.

**Independent Test**: User changes background/model/count controls, sees estimated cost changes, blocked invalid count per plan, and gets insufficient-balance purchase path.

### Implementation for User Story 2

- [X] T015 [US2] Implement settings controls (source type, background mode, model tier, output count) in `lib/presentation/screens/coordinate/widgets/coordinate_generation_form_section.dart`
- [X] T016 [P] [US2] Compute and show estimated percoin cost based on current selection in `lib/presentation/screens/coordinate/coordinate_view_model.dart` and `lib/presentation/screens/coordinate/widgets/coordinate_generation_form_section.dart`
- [X] T017 [US2] Enforce plan-limited output count selection and upgrade guidance in `lib/presentation/screens/coordinate/coordinate_view_model.dart` and `lib/presentation/screens/coordinate/widgets/coordinate_generation_form_section.dart`
- [X] T018 [US2] Implement insufficient-balance feedback and buy-percoin navigation path in `lib/presentation/screens/coordinate/coordinate_page.dart` and `lib/presentation/screens/coordinate/coordinate_view_model.dart`
- [X] T019 [US2] Ensure charge-on-success-only handling in coordinate generation completion path in `lib/domain/repository/coordinate_repository.dart` and `lib/presentation/screens/coordinate/coordinate_view_model.dart`

**Checkpoint**: US2 works independently and does not regress US1.

---

## Phase 5: User Story 3 - Track and recover generated history (Priority: P3)

**Goal**: User can revisit generated outputs, paginate history, and recover in-progress jobs after leaving/returning.

**Independent Test**: User leaves Coordinate with active jobs, returns and sees resumed tracking; timed-out jobs show still-processing; history pagination appends without duplicates.

### Implementation for User Story 3

- [X] T020 [US3] Implement generated history grid with incremental pagination in `lib/presentation/screens/coordinate/widgets/coordinate_gallery_section.dart` and `lib/presentation/screens/coordinate/coordinate_page.dart`
- [X] T021 [P] [US3] Implement duplicate-safe gallery merge by stable image identity in `lib/presentation/screens/coordinate/coordinate_view_model.dart`
- [X] T022 [US3] Implement 90-second polling timeout with still-processing state in `lib/presentation/screens/coordinate/coordinate_view_model.dart` and `lib/presentation/screens/coordinate/widgets/coordinate_progress_section.dart`
- [X] T023 [US3] Implement auto-resume recovery of in-progress jobs on re-entry in `lib/presentation/screens/coordinate/coordinate_view_model.dart` and `lib/presentation/screens/coordinate/coordinate_page.dart`
- [X] T024 [US3] Integrate final recovery/timeout visuals and empty/error/loading/success state parity in `lib/presentation/screens/coordinate/coordinate_page.dart`

**Checkpoint**: US3 works independently and all stories are deliverable.

---

## Phase 6: Polish & Cross-Cutting Concerns

**Purpose**: Finalize generation artifacts and verify readiness.

- [X] T025 [P] Regenerate Freezed/build outputs for Coordinate state/models in `lib/presentation/screens/coordinate/coordinate_state.freezed.dart` via `build_runner`
- [X] T026 Run static verification with `fvm dart analyze lib test` and fix issues in `lib/` and `test/`
- [X] T027 Update implementation verification notes for Coordinate in `specs/003-coordinate-page/quickstart.md`

---

## Dependencies & Execution Order

### Phase Dependencies

- **Phase 1 (Setup)**: starts immediately.
- **Phase 2 (Foundational)**: depends on Phase 1; blocks all user stories.
- **Phase 3-5 (User Stories)**: depend on Phase 2 completion.
- **Phase 6 (Polish)**: depends on selected user stories completion.

### User Story Dependencies

- **US1 (P1)**: starts after Foundational; no dependency on US2/US3.
- **US2 (P2)**: starts after Foundational; can integrate US1 state but remains independently testable.
- **US3 (P3)**: starts after Foundational; best executed after US1 async flows exist, but can be developed in parallel where file ownership is split.

### Within Each User Story

- Update models/state before UI wiring that depends on them.
- Complete validation and submission logic before progress/gallery integration.
- Finish story checkpoint validation before moving to next priority.

---

## Parallel Opportunities

- **Setup**: T002 and T003 can run in parallel after T001 key decisions.
- **Foundational**: T005 and T006 can run in parallel while T004 is in progress.
- **US1**: T011 and T013 can run in parallel after T010/T012 scaffolding.
- **US2**: T016 and T017 can run in parallel after T015 control structure is in place.
- **US3**: T021 and T022 can run in parallel after T020 base gallery/progress plumbing exists.

---

## Parallel Example: User Story 1

```bash
# After auth + validation baseline (T010, T012):
Task: "T011 [US1] Implement source image input UX in lib/presentation/screens/coordinate/widgets/coordinate_generation_form_section.dart"
Task: "T013 [US1] Wire generation submit + per-job progress rendering in coordinate view model/progress section"
```

## Parallel Example: User Story 2

```bash
# After settings control shell (T015):
Task: "T016 [US2] Compute/show estimated percoin cost in coordinate view model + form section"
Task: "T017 [US2] Enforce plan-limited output count and upgrade guidance in coordinate view model + form section"
```

## Parallel Example: User Story 3

```bash
# After gallery base implementation (T020):
Task: "T021 [US3] Implement duplicate-safe gallery merge in lib/presentation/screens/coordinate/coordinate_view_model.dart"
Task: "T022 [US3] Implement 90-second polling timeout and still-processing state in view model/progress section"
```

---

## Implementation Strategy

### MVP First (US1 Only)

1. Finish Phase 1 and Phase 2.
2. Deliver Phase 3 (US1) completely.
3. Validate US1 independent test criteria before expanding scope.

### Incremental Delivery

1. Setup + Foundational establish stable base.
2. Deliver US1 (core generation flow).
3. Deliver US2 (settings, cost, insufficient-balance behavior).
4. Deliver US3 (history pagination and recovery resilience).
5. Execute polish verification tasks.

### Parallel Team Strategy

1. One engineer owns foundational domain/repository tasks (T004-T009).
2. Second engineer builds US1/US2 form and cost UX after foundation.
3. Third engineer builds US3 recovery/gallery in parallel once base async states exist.

---

## Notes

- Every task follows required checklist format with ID and explicit file paths.
- Story labels are applied only to user story phases.
- `[P]` markers are used only where tasks can be done concurrently with disjoint write focus.
