# Research: Coordinate Page

## Decision 1: Enforce route-level auth redirect with return path

- **Decision**: Unauthenticated access to Coordinate must immediately redirect to Login with a return path to Coordinate.
- **Rationale**: This aligns with existing protected-tab behavior, avoids partial rendering states, and guarantees post-login continuation.
- **Alternatives considered**:
  - Keep Coordinate visible with blocking overlay: rejected due to duplicated auth-state UI complexity.
  - Redirect to Home with notice: rejected because it breaks intent continuity.

## Decision 2: Charge percoins only on successful outputs

- **Decision**: Apply percoin charge only when each output job reaches successful completion.
- **Rationale**: Prevents billing disputes for failed generations and aligns with clarified product expectation.
- **Alternatives considered**:
  - Charge at submit with no refund: rejected as poor user trust behavior.
  - Charge at submit with refund on failure: rejected for additional refund state complexity in this slice.

## Decision 3: Restore in-progress jobs when re-entering Coordinate

- **Decision**: On re-entry, automatically reload and continue tracking in-progress jobs for the authenticated user session.
- **Rationale**: Reduces accidental duplicate submits and preserves continuity across tab switches/app lifecycle changes.
- **Alternatives considered**:
  - Do not restore and show only completed history: rejected as high confusion risk.
  - Manual "resume" action: rejected because automatic recovery is simpler for users.

## Decision 4: Upload constraints are strict client-side validated

- **Decision**: Accept only JPG/PNG/WebP with max 10MB and reject invalid files before submission.
- **Rationale**: Keeps generation input predictable and lowers failure rate and memory pressure on mobile devices.
- **Alternatives considered**:
  - Allow HEIC and larger payloads by default: rejected due to conversion/compatibility overhead.
  - Limit to JPG/PNG only: rejected as unnecessarily restrictive.

## Decision 5: Polling timeout strategy uses soft-timeout recovery

- **Decision**: Stop active polling after 90 seconds without terminal status, show "still processing", and auto-resume on re-entry.
- **Rationale**: Prevents indefinite spinner behavior while preserving eventual job visibility.
- **Alternatives considered**:
  - Infinite polling: rejected due to battery/network inefficiency.
  - Hard-fail timed-out jobs: rejected because backend processing may still succeed later.

## Decision 6: Keep implementation within existing app architecture

- **Decision**: Implement Coordinate flow inside current layers (`presentation/screens/coordinate`, domain repository/models, existing providers/services), no new architectural module.
- **Rationale**: Matches constitution "Existing Architecture First" and minimizes delivery risk.
- **Alternatives considered**:
  - Introduce new feature package/module boundary now: rejected as out-of-scope refactor.
