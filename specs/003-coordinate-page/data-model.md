# Data Model: Coordinate Page

## Entity: CoordinateSession

- **Purpose**: Captures the current interactive state of Coordinate screen for one authenticated user session.
- **Attributes**:
  - `userId`
  - `isAuthenticated`
  - `selectedImageSourceMode` (`upload` | `stock`)
  - `selectedSourceImageType` (`illustration` | `real`)
  - `prompt`
  - `backgroundMode` (`keep` | `include_in_prompt` | `ai_auto`)
  - `selectedOutputCount`
  - `selectedModelTier`
  - `estimatedPercoinCost`
  - `isGenerating`
- **Validation Rules**:
  - Submission is blocked when `isAuthenticated = false`.
  - Submission is blocked if `prompt` is empty or exceeds max length.
  - Submission is blocked when source image reference is missing.

## Entity: SourceImageInput

- **Purpose**: Represents the selected source image used for generation.
- **Attributes**:
  - `mode` (`upload` | `stock`)
  - `uploadFileName` (optional)
  - `uploadMimeType` (optional)
  - `uploadSizeBytes` (optional)
  - `stockImageId` (optional)
  - `stockStoragePath` (optional)
- **Validation Rules**:
  - For `upload` mode, accepted types are JPG/PNG/WebP and size <= 10MB.
  - For `stock` mode, `stockImageId` must resolve to an accessible user-owned item.
  - Mode switch invalidates stale selection from previous mode.

## Entity: GenerationRequest

- **Purpose**: Immutable request payload to start one or multiple generation jobs.
- **Attributes**:
  - `requestId`
  - `userId`
  - `sourceImageInput`
  - `prompt`
  - `backgroundMode`
  - `sourceImageType`
  - `modelTier`
  - `outputCount`
  - `submittedAt`
- **Validation Rules**:
  - `outputCount` must respect plan limits.
  - `modelTier` must be one of supported selectable tiers.
  - `prompt` must pass length and non-empty checks.

## Entity: GenerationJob

- **Purpose**: Tracks asynchronous processing state for each output image.
- **Attributes**:
  - `jobId`
  - `requestId`
  - `userId`
  - `status` (`queued` | `processing` | `charging` | `generating` | `uploading` | `persisting` | `completed` | `failed`)
  - `progressPercent`
  - `previewImageUrl` (optional)
  - `resultImageId` (optional)
  - `errorCode` (optional)
  - `startedAt`
  - `updatedAt`
- **Validation Rules**:
  - Each `jobId` belongs to exactly one `requestId`.
  - Terminal statuses are `completed` and `failed`.
  - Percoin charge applies only when `status = completed`.

## Entity: GenerationHistoryItem

- **Purpose**: Persisted result item shown in Coordinate gallery/history.
- **Attributes**:
  - `imageId`
  - `userId`
  - `imageUrl`
  - `isPosted`
  - `createdAt`
  - `generationType` (`coordinate`)
- **Validation Rules**:
  - Items are scoped to authenticated user.
  - Pagination merge must avoid duplicate `imageId`.

## Entity: PollingRecoveryState

- **Purpose**: Defines timeout and recovery behavior for long-running jobs.
- **Attributes**:
  - `activePollingStartedAt`
  - `timeoutSeconds` (fixed 90)
  - `timedOutJobIds`
  - `recoveryMessageVisible`
  - `resumeOnReentry` (true)
- **Validation Rules**:
  - If timeout threshold is exceeded without terminal state, active polling stops for the current view.
  - Timed-out jobs are retried/recovered when user re-enters Coordinate.

## Relationships

- `CoordinateSession 1 -> 0..N GenerationRequest`
- `GenerationRequest 1 -> 1..N GenerationJob`
- `GenerationJob 0..1 -> 0..1 GenerationHistoryItem`
- `CoordinateSession 1 -> 1 SourceImageInput`
- `CoordinateSession 1 -> 1 PollingRecoveryState`

## State Transitions

## Access/Auth Transition

- `Unauthenticated -> RedirectedToLogin(returnTo=Coordinate)`
- `Authenticated -> CoordinateInteractive`

## Generation Flow Transition

- `Idle -> Validating -> Submitting -> InProgress -> Completed`
- `InProgress -> TimedOutStillProcessing -> ReenteredRecovering -> InProgress`
- `InProgress -> Failed`

## Billing Transition

- `PendingCharge -> ChargedOnCompleted`
- `PendingCharge -> NoChargeOnFailed`
