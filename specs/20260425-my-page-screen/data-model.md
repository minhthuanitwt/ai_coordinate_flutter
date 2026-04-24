# Data Model: My Page Screen

## Entity: MyPageProfile

**Purpose**: Render profile identity block at top of My Page.

**Fields**:
- `userId` (`String`, required)
- `nickname` (`String?`)
- `bio` (`String?`)
- `avatarUrl` (`String?`)
- `subscriptionPlan` (`String?`)
- `email` (`String?`, own profile only where available)

**Validation / Rules**:
- `userId` must be non-empty.
- Empty/blank `nickname` falls back to localized default display name.
- Invalid or empty `avatarUrl` falls back to default avatar UI.

## Entity: MyPageStats

**Purpose**: Show aggregated usage counters.

**Fields**:
- `generatedCount` (`int`, default `0`)
- `generatedCountPublic` (`bool`, default `false`)
- `postedCount` (`int`, default `0`)
- `likeCount` (`int`, default `0`)
- `viewCount` (`int`, default `0`)
- `followerCount` (`int`, default `0`)
- `followingCount` (`int`, default `0`)

**Validation / Rules**:
- Counts are non-negative.
- Any missing counter from backend maps to `0`.

## Entity: MyPageBalance

**Purpose**: Show credit balance summary in My Page.

**Fields**:
- `total` (`int`, required)
- `regular` (`int`, default `0`)
- `paid` (`int`, default `0`)
- `unlimitedBonus` (`int`, default `0`)
- `periodLimited` (`int`, default `0`)

**Validation / Rules**:
- Values are non-negative.
- `total` should equal the sum of relevant components when backend provides all
  components; otherwise UI shows available values without hard failure.

## Entity: MyPageImageItem

**Purpose**: Render one image card in My Page gallery.

**Fields**:
- `id` (`String`, required)
- `imageUrl` (`String`, required for card rendering)
- `prompt` (`String?`)
- `caption` (`String?`)
- `isPosted` (`bool`)
- `createdAt` (`DateTime?`)
- `postedAt` (`DateTime?`)

**Validation / Rules**:
- Items with empty `imageUrl` are skipped.
- Ordering defaults to newest first (`createdAt` descending) for own images.

## Aggregate State: MyPageState (Freezed)

**Purpose**: Drive UI state transitions for each section.

**Core Fields**:
- `profile` (`MyPageProfile?`)
- `stats` (`MyPageStats?`)
- `balance` (`MyPageBalance?`)
- `images` (`List<MyPageImageItem>`)
- `isLoadingInitial` (`bool`)
- `isRefreshing` (`bool`)
- `isLoadingMoreImages` (`bool`)
- `hasMoreImages` (`bool`)
- `errorCode` (`String?`)
- Section-specific status flags/errors as needed to avoid full-page reload

## State Transitions

1. `Initial` -> `LoadingInitial`: screen opened and authenticated.
2. `LoadingInitial` -> `SuccessPartial|SuccessFull`: one or more sections loaded.
3. `LoadingInitial` -> `Error`: unrecoverable first-load failure.
4. `Success*` -> `Refreshing`: pull-to-refresh or retry.
5. `Success*` -> `LoadingMoreImages`: gallery pagination request.
6. Any state -> `AuthRequiredRedirect`: session becomes unauthenticated while
   attempting protected data fetch.
