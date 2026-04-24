# Data Model: Auth-Gated Protected Tabs

## Entity: Auth Session

**Purpose**: Represents the current signed-in state required to enter protected
tabs.

**Fields**:

- `userId`: string, nullable for guests
- `email`: string, nullable
- `accessTokenPresent`: boolean
- `isAuthenticated`: boolean
- `lastResolvedAt`: `DateTime`

**Validation Rules**:

- `isAuthenticated` is `true` only when a Supabase user exists for the active
  session.
- `userId` and `email` may be absent for guests and during transient loading.

**State Transitions**:

- `loading` -> `guest`
- `loading` -> `authenticated`
- `authenticated` -> `guest` when sign-out or session expiry occurs
- `guest` -> `authenticated` after successful login

## Entity: Login Form State

**Purpose**: Holds the UI state of the login page.

**Fields**:

- `email`: string
- `password`: string
- `isSubmitting`: boolean
- `errorCode`: string, nullable
- `redirectTarget`: protected destination identifier, nullable

**Validation Rules**:

- `email` must be non-empty before submit.
- `password` must be non-empty before submit.
- `redirectTarget` must match one of the protected app destinations or be null.

**State Transitions**:

- `idle` -> `submitting`
- `submitting` -> `authenticated`
- `submitting` -> `error`
- `error` -> `submitting` after retry

## Entity: Protected Destination

**Purpose**: Declares which tabs require authentication and where login should
return the user afterward.

**Fields**:

- `routeName`: enum-like string (`coordinate`, `challenge`, `notifications`,
  `myPage`)
- `tabIndex`: integer in shell navigation
- `requiresAuth`: boolean, always `true` for this slice
- `loginFallbackRoute`: string, default `login`

**Validation Rules**:

- `routeName` must map to an existing `auto_route` destination.
- `tabIndex` must remain synchronized with shell tab ordering.

## Entity: Auth Gate Outcome

**Purpose**: Encodes the result of checking a navigation request against the
current session.

**Fields**:

- `allowed`: boolean
- `redirectToLogin`: boolean
- `requestedDestination`: protected destination identifier
- `reason`: string (`guest`, `expired_session`, `configured_but_missing_user`)

**Validation Rules**:

- `redirectToLogin` is `true` only when `allowed` is `false`.
- `requestedDestination` is required when a protected tab initiated the check.

## Relationships

- One `Auth Session` governs access to many `Protected Destination` entries.
- One `Login Form State` may carry one `redirectTarget`.
- One `Auth Gate Outcome` is produced from one `Auth Session` plus one
  `Protected Destination`.
