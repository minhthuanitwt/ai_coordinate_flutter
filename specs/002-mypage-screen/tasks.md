# Tasks: Home and My Page Appbars

**Input**: Design documents from `/specs/002-mypage-screen/`
**Prerequisites**: plan.md (required), spec.md (required for user stories), research.md, data-model.md, contracts/

**Tests**: No mandatory automated test tasks are generated because the spec does not explicitly require TDD or automated test-first delivery for this slice. Verification is handled through analyze + runtime validation checklist.

**Organization**: Tasks are grouped by user story to enable independent implementation and testing of each story.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (e.g., US1, US2, US3)
- Include exact file paths in descriptions

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Align feature documents, localization sources, and generation prerequisites.

- [X] T001 Finalize appbar behavior baseline notes in `specs/002-mypage-screen/contracts/appbar-behavior-contract.md`
- [X] T002 Add/adjust appbar and drawer localization keys in `assets/i18n/en.i18n.json` and `assets/i18n/ja.i18n.json`
- [X] T003 [P] Regenerate localization outputs in `lib/i18n/strings.g.dart`, `lib/i18n/strings_en.g.dart`, and `lib/i18n/strings_ja.g.dart`

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Build shared primitives required by all user stories.

**⚠️ CRITICAL**: No user story work can begin until this phase is complete.

- [X] T004 Create mobile viewport breakpoint constants for 360/390/430 in `lib/presentation/components/mobile_breakpoints.dart`
- [X] T005 [P] Create shared appbar action descriptor model for visibility and behavior mapping in `lib/presentation/components/appbar_action_descriptor.dart`
- [X] T006 [P] Implement appbar action resolver/provider aligned to web baseline in `lib/presentation/providers/appbar_action_provider.dart`
- [X] T007 Wire auth-aware action visibility helpers using session state in `lib/presentation/providers/auth_session_provider.dart` and `lib/presentation/providers/appbar_action_provider.dart`
- [X] T008 Create reusable right-side drawer container for My Page menu actions in `lib/presentation/components/right_menu_drawer.dart`

**Checkpoint**: Foundation ready - user story implementation can now begin.

---

## Phase 3: User Story 1 - Home Appbar Visual Match (Priority: P1) 🎯 MVP

**Goal**: Deliver Home appbar structure and full action behavior matching reference + web baseline.

**Independent Test**: Open Home tab and verify brand/search/action composition appears in first viewport; all visible actions execute intended outcomes; protected actions are hidden when unauthenticated.

### Implementation for User Story 1

- [X] T009 [US1] Replace Home top heading block with reference appbar composition in `lib/presentation/screens/home/home_page.dart`
- [X] T010 [P] [US1] Implement Home search-surface tap behavior and target flow mapping in `lib/presentation/screens/home/home_page.dart`
- [X] T011 [P] [US1] Implement Home utility/profile action handlers using appbar action resolver in `lib/presentation/screens/home/home_page.dart`
- [X] T012 [US1] Apply unauthenticated hidden-action rule for protected Home actions in `lib/presentation/screens/home/home_page.dart`
- [X] T013 [US1] Tune Home appbar spacing/truncation for long localized labels in `lib/presentation/screens/home/home_page.dart`

**Checkpoint**: User Story 1 should be fully functional and independently testable.

---

## Phase 4: User Story 2 - My Page Appbar Visual Match (Priority: P1)

**Goal**: Deliver My Page profile-first top header and right-side drawer behavior matching reference.

**Independent Test**: Open My Page and verify profile-focused header + top-right menu icon; tapping menu opens right drawer with web-aligned account actions; fallback profile visuals remain stable.

### Implementation for User Story 2

- [X] T014 [US2] Replace My Page title/description top block with profile-first header composition in `lib/presentation/screens/my_page/my_page_page.dart`
- [X] T015 [P] [US2] Add top-right menu icon trigger and attach right-side drawer host in `lib/presentation/screens/my_page/my_page_page.dart`
- [X] T016 [P] [US2] Implement My Page drawer menu content and action outcomes in `lib/presentation/components/right_menu_drawer.dart` and `lib/presentation/screens/my_page/my_page_page.dart`
- [X] T017 [US2] Apply unauthenticated hidden-action rule for protected My Page header actions in `lib/presentation/screens/my_page/my_page_page.dart`
- [X] T018 [US2] Implement avatar/display-name fallback rendering without layout shift in `lib/presentation/screens/my_page/my_page_page.dart`

**Checkpoint**: User Stories 1 and 2 should each work independently.

---

## Phase 5: User Story 3 - Cross-Tab Header Consistency (Priority: P2)

**Goal**: Ensure stable header behavior across Home/My Page switching and responsive widths.

**Independent Test**: Switch tabs repeatedly (20+ times) and confirm no header flicker/crossover; verify no overlap/action loss at 360dp/390dp/430dp.

### Implementation for User Story 3

- [X] T019 [US3] Remove shell-level My Page-only top auth header coupling to avoid variant conflicts in `lib/presentation/screens/shell/app_shell_page.dart`
- [X] T020 [P] [US3] Stabilize tab-switch header render lifecycle for Home/My Page in `lib/presentation/screens/home/home_page.dart` and `lib/presentation/screens/my_page/my_page_page.dart`
- [X] T021 [P] [US3] Enforce responsive rules for 360dp/390dp/430dp widths in `lib/presentation/screens/home/home_page.dart` and `lib/presentation/screens/my_page/my_page_page.dart`
- [X] T022 [US3] Validate auth state transitions keep protected-action visibility consistent across both pages in `lib/presentation/screens/home/home_page.dart` and `lib/presentation/screens/my_page/my_page_page.dart`

**Checkpoint**: All user stories should now be independently functional.

---

## Phase 6: Polish & Cross-Cutting Concerns

**Purpose**: Final consistency, verification, and handoff readiness.

- [X] T023 [P] Update finalized interaction notes and acceptance mapping in `specs/002-mypage-screen/contracts/appbar-behavior-contract.md` and `specs/002-mypage-screen/quickstart.md`
- [X] T024 Run static verification with `fvm dart analyze lib` and resolve issues in `lib/`
- [ ] T025 Execute manual QA checklist for SC-001..SC-008 and record evidence in `specs/002-mypage-screen/quickstart.md`

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies - starts immediately.
- **Foundational (Phase 2)**: Depends on Setup completion - blocks all stories.
- **User Stories (Phase 3-5)**: Depend on Foundational completion.
- **Polish (Phase 6)**: Depends on all target stories being complete.

### User Story Dependencies

- **US1 (P1)**: Starts after Foundational; no dependency on US2/US3.
- **US2 (P1)**: Starts after Foundational; no dependency on US1.
- **US3 (P2)**: Starts after Foundational but functionally validates combined Home + My Page behavior, so it is best executed after US1 and US2 core tasks are done.

### Within Each User Story

- Build layout structure before behavior wiring.
- Apply protected-action visibility rules before final responsive tuning.
- Complete story-level independent validation before moving focus.

---

## Parallel Opportunities

- **Setup**: T003 can run in parallel with doc-key updates once localization source edits are ready.
- **Foundational**: T005 and T006 can run in parallel; T008 can start after action schema from T005 is defined.
- **US1**: T010 and T011 can run in parallel after T009.
- **US2**: T015 and T016 can run in parallel after T014 establishes header shell.
- **US3**: T020 and T021 can run in parallel after T019.

---

## Parallel Example: User Story 1

```bash
# After T009 completes:
Task: "T010 [US1] Implement Home search-surface tap behavior in lib/presentation/screens/home/home_page.dart"
Task: "T011 [US1] Implement Home utility/profile action handlers in lib/presentation/screens/home/home_page.dart"
```

## Parallel Example: User Story 2

```bash
# After T014 completes:
Task: "T015 [US2] Add top-right menu icon trigger in lib/presentation/screens/my_page/my_page_page.dart"
Task: "T016 [US2] Implement drawer menu content in lib/presentation/components/right_menu_drawer.dart"
```

## Parallel Example: User Story 3

```bash
# After T019 completes:
Task: "T020 [US3] Stabilize tab-switch header lifecycle in Home/My Page pages"
Task: "T021 [US3] Enforce responsive width rules for 360/390/430dp in Home/My Page pages"
```

---

## Implementation Strategy

### MVP First (US1)

1. Complete Phase 1 and Phase 2.
2. Deliver Phase 3 (US1) fully.
3. Validate Home appbar independently against reference + behavior rules.

### Incremental Delivery

1. Foundation complete.
2. Deliver US1 (Home appbar).
3. Deliver US2 (My Page appbar + right drawer).
4. Deliver US3 (cross-tab stability + responsive guarantees).
5. Run Phase 6 polish checks.

### Team Parallel Strategy

1. Engineer A: US1 (Home appbar).
2. Engineer B: US2 (My Page appbar and drawer).
3. Engineer C (after A+B baseline): US3 cross-tab/responsive stabilization.

---

## Notes

- All tasks follow checklist format: checkbox + Task ID + optional [P] + required [USx] for story tasks + file path.
- Story tasks are kept independently completable for staged delivery and QA.
- Generated-file updates (i18n) must be done through tool-based regeneration, not manual edits.
