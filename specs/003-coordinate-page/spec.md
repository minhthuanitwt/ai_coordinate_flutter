# Feature Specification: Coordinate Page

**Feature Branch**: `[003-coordinate-page]`  
**Created**: 2026-04-27  
**Status**: Draft  
**Input**: User description: "Implement màn hình CoordinatePage, tham khảo UI và logic từ source code bản web /Users/dongdm/Develop/Source/doi/ai_coordinate/app/(app)/coordinate"

## Clarifications

### Session 2026-04-27

- Q: What should happen when an unauthenticated user opens CoordinatePage? → A: Redirect immediately to Login with return-to Coordinate.
- Q: When should percoins be charged if a generation job can fail? → A: Charge only when each output job completes successfully.
- Q: How should in-progress jobs behave when a user leaves and returns to CoordinatePage? → A: Automatically restore and continue tracking in-progress jobs.
- Q: What source image upload constraints should apply? → A: Allow JPG/PNG/WebP up to 10MB.
- Q: What should happen when status polling runs too long? → A: Timeout at 90 seconds, show still-processing state, and auto-resume tracking when user returns.

## User Scenarios & Testing *(mandatory)*

<!--
  IMPORTANT: User stories should be PRIORITIZED as user journeys ordered by importance.
  Each user story/journey must be INDEPENDENTLY TESTABLE - meaning if you implement just ONE of them,
  you should still have a viable MVP (Minimum Viable Product) that delivers value.
  
  Assign priorities (P1, P2, P3, etc.) to each story, where P1 is the most critical.
  Think of each story as a standalone slice of functionality that can be:
  - Developed independently
  - Tested independently
  - Deployed independently
  - Demonstrated to users independently
-->

### User Story 1 - Generate coordinated images from a source image (Priority: P1)

As a signed-in user, I can open CoordinatePage, provide a source image and a prompt, then generate one or more output images.

**Why this priority**: This is the core user value of the Coordinate tab and the primary conversion path.

**Independent Test**: Can be fully tested by submitting valid generation input and verifying generated outputs are created and shown.

**Acceptance Scenarios**:

1. **Given** a signed-in user is on CoordinatePage, **When** they provide a source image, prompt, and submit generation, **Then** the system starts the job and shows generating progress.
2. **Given** a generation request is completed, **When** the user remains on CoordinatePage, **Then** newly generated images appear in the result area without requiring a full page reload.
3. **Given** a user tries to submit without required inputs, **When** they tap generate, **Then** the system blocks submission and shows a clear validation message.

---

### User Story 2 - Control generation settings and cost visibility (Priority: P2)

As a signed-in user, I can choose generation settings (image source mode, source type, background handling, quality/model tier, and output count) and see expected cost impact before submitting.

**Why this priority**: This reduces failed attempts and gives users control over quality, style behavior, and coin usage.

**Independent Test**: Can be fully tested by changing each control and verifying UI state, cost display, and allowed limits respond correctly.

**Acceptance Scenarios**:

1. **Given** generation settings are visible, **When** the user changes output count or quality tier, **Then** expected per-request cost updates immediately.
2. **Given** a plan-limited user selects a restricted output count, **When** they tap that option, **Then** the app prevents selection and shows an upgrade prompt.
3. **Given** the user has insufficient balance at submit time, **When** generation starts, **Then** the app shows insufficient-balance feedback and provides a path to purchase more coins.

---

### User Story 3 - Track and revisit generated results (Priority: P3)

As a signed-in user, I can review current and historical generated images in a result gallery, including in-progress previews and additional older items loaded as I scroll.

**Why this priority**: Users need confidence their request is being processed and must be able to revisit generated assets.

**Independent Test**: Can be fully tested by creating multiple generations, observing status/previews, and scrolling to load older records.

**Acceptance Scenarios**:

1. **Given** at least one job is in progress, **When** the user views the result section, **Then** in-progress state is visible and updates over time.
2. **Given** the user has enough historical results, **When** they scroll to the end of the current list, **Then** the next batch loads and appends without duplicates.
3. **Given** no result exists yet, **When** the user opens the result section, **Then** the app shows an empty state instead of blank content.

### Edge Cases

- User is not signed in and opens Coordinate tab directly (must be redirected to Login and return back to Coordinate after successful authentication).
- User loses network during submission or while polling job status.
- User leaves CoordinatePage and returns while jobs are still in progress.
- Status polling exceeds timeout while backend job may still be running.
- Job fails after coins are reserved/consumed.
- Duplicate submit taps occur while a job is already being created.
- User switches source mode after selecting an image in the other mode.
- Stored source-image selection no longer exists (deleted or inaccessible).
- Uploaded source image format is unsupported or file size exceeds allowed limit.
- Prompt exceeds allowed length.
- Result pagination returns fewer items than a full page or returns duplicate records.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: CoordinatePage MUST be accessible only to authenticated users, and unauthenticated access attempts MUST redirect immediately to Login with a return path back to CoordinatePage.
- **FR-002**: The page MUST show a title and short description clarifying the coordinate-generation purpose.
- **FR-003**: The page MUST show current percoin balance near the top and provide direct navigation to coin purchase.
- **FR-004**: Users MUST be able to choose an image source mode between local upload and stock/library image.
- **FR-004a**: Local source image upload MUST accept only JPG, PNG, or WebP files with a maximum file size of 10MB, and MUST show validation feedback for unsupported files.
- **FR-005**: Users MUST be able to set source image type (illustration or real) for generation context.
- **FR-006**: Users MUST be able to enter a text prompt, and the app MUST enforce a maximum prompt length with visible character feedback.
- **FR-007**: Users MUST be able to choose background handling mode from keep, include in prompt, or automatic generation.
- **FR-008**: Users MUST be able to choose output quality tier and output count before submission.
- **FR-009**: The app MUST display expected percoin cost for the current generation configuration before submit.
- **FR-010**: The app MUST prevent submission when required inputs are missing, invalid, or a generation is already in progress.
- **FR-011**: For plan-restricted output counts, the app MUST prevent invalid selection and show upgrade guidance.
- **FR-012**: After submit, the app MUST show progress state for active jobs and update state until completion or failure.
- **FR-013**: The result section MUST show newly generated outputs as they become available and persist them in user history.
- **FR-014**: The result section MUST support incremental loading of older generated outputs as users scroll.
- **FR-015**: On generation failure, the app MUST show a clear error message and allow users to retry with preserved inputs when possible.
- **FR-016**: If user balance is insufficient, the app MUST show insufficient-balance feedback and a direct path to purchase coins.
- **FR-017**: When users switch image source mode, stale selection from the previous mode MUST not cause invalid submissions.
- **FR-018**: Percoins MUST be charged only for outputs that complete successfully; failed outputs MUST not consume percoins.
- **FR-019**: CoordinatePage MUST automatically restore and continue tracking the user’s in-progress jobs when the user returns to the page within the same authenticated session.
- **FR-020**: If status polling exceeds 90 seconds without terminal job status, the app MUST stop active polling for that session view, show a "still processing" state, and resume tracking automatically when the user re-enters CoordinatePage.

### Key Entities *(include if feature involves data)*

- **Generation Request**: User-submitted input bundle containing prompt text, selected source image reference, source image type, background mode, output count, and quality tier.
- **Generation Job**: Asynchronous processing record for one output image request, including status, progress stage, optional preview image, completion/failure state, and timestamps.
- **Generated Image**: Persisted result artifact linked to a user and creation context, including display URL and posting state.
- **Percoin Balance Snapshot**: User-visible coin amount used to decide whether generation is affordable.
- **Source Image Stock Item**: Reusable source image entry from the user’s stock/library area.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: At least 90% of authenticated users can complete a valid generation submission within 2 minutes from landing on CoordinatePage.
- **SC-002**: At least 95% of generation submissions show an initial progress indicator within 3 seconds after tapping generate.
- **SC-003**: At least 95% of completed generation outputs appear in the result gallery during the same session without manual refresh.
- **SC-004**: Validation-related failed submissions (missing source image or prompt) decrease by at least 50% compared with a baseline screen without inline validation.
- **SC-005**: At least 90% of insufficient-balance incidents include successful user navigation to coin purchase from the coordinate flow.
- **SC-006**: At least 95% of jobs that exceed active polling timeout are recoverable and visible again when users return to CoordinatePage.

## Assumptions

- CoordinatePage is part of the authenticated area and should keep the same login requirement as existing protected tabs.
- Coin purchase flow already exists elsewhere and only needs entry points from CoordinatePage.
- Existing generation backend and persistence are available and remain unchanged in this feature.
- Existing localization approach is reused; this feature only requires adding/updating copy keys used by CoordinatePage.
- CoordinatePage v1 prioritizes parity with current web behavior and does not include new generation capabilities beyond that scope.
