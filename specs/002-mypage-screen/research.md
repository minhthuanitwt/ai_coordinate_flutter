# Research: Home and My Page Appbars

## Decision 1: Use web behavior as canonical action baseline

- **Decision**: Treat current web product behavior as source-of-truth for each Home/My Page appbar action.
- **Rationale**: The feature explicitly requires full behavior parity for header actions and reduces ambiguity in acceptance validation.
- **Alternatives considered**:
  - Define mobile-only behaviors per action: rejected due to QA mismatch risk.
  - Ship visual-only in this slice: rejected by clarification outcome.

## Decision 2: Protected appbar actions are hidden for unauthenticated users

- **Decision**: Keep header composition stable but hide protected actions when user is unauthenticated.
- **Rationale**: Clarification selected hide behavior over redirect/disabled modes and prevents accidental access expectation.
- **Alternatives considered**:
  - Keep visible and redirect to login: rejected by clarification.
  - Keep visible but disabled: rejected by clarification.

## Decision 3: My Page menu action opens right-side drawer

- **Decision**: The My Page menu icon opens a right-side drawer containing account-related actions.
- **Rationale**: Clarification explicitly selected right drawer interaction.
- **Alternatives considered**:
  - Direct navigation to settings page: rejected by clarification.
  - Bottom sheet quick actions: rejected by clarification.

## Decision 4: Mobile acceptance viewport range is fixed to 360dp-430dp

- **Decision**: Use 360dp, 390dp, and 430dp checkpoints for layout acceptance.
- **Rationale**: Clarification fixed measurable responsive scope and aligns with target mobile widths.
- **Alternatives considered**:
  - Unbounded "all mobile widths": rejected as non-measurable.
  - Wider tablet-inclusive validation in this feature: deferred as out of scope.

## Decision 5: Verification strategy is analyze + focused UI/manual flows

- **Decision**: Verification baseline includes `dart analyze` and targeted runtime checks for action behavior, auth visibility rules, and tab-switch header stability.
- **Rationale**: Matches constitution requirement for mandatory verification while staying proportional to UI-driven change scope.
- **Alternatives considered**:
  - Full E2E automation in this slice: deferred due to higher setup cost for current scope.
  - No verification beyond visual check: rejected by constitution.

