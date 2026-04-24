# Contract: Protected Navigation and Login Routing

## Purpose

Define the user-visible routing contract for the minimal auth flow in the
Flutter app.

## Routes

### Public Routes

- `/`
  - Shell root
  - Default child: `home`
  - Accessible without authentication
- `/login`
  - Standalone login entry screen
  - Accessible without authentication

### Protected Shell Children

- `/coordinate`
- `/challenge`
- `/notifications`
- `/my-page`

Each protected shell child requires an authenticated Supabase user session.

## Navigation Rules

1. Guest users can open `home` without redirection.
2. When a guest taps or directly navigates to a protected tab, the app must:
   - prevent protected content from rendering
   - navigate to `login`
   - preserve which protected destination was requested
3. After successful login, the app must return the user to the originally
   requested protected destination when one exists.
4. If no redirect target exists after login, the app may return to the shell
   default (`home`) or a product-defined authenticated default.
5. If an authenticated session becomes invalid while viewing a protected tab,
   the app must leave protected content and return the user to `login`.

## UI Contract

### Login Screen

- Must expose:
  - email input
  - password input
  - primary submit action
  - loading state during submission
  - explicit error state on failed login
- Need not expose:
  - signup
  - password reset
  - OAuth providers

### Protected Tab Guest Handling

- Guest users should receive a clear auth-required message before or during
  redirection.
- The shell should not present a broken empty protected screen to guests.

## State Contract

- Session source of truth is Supabase Auth.
- Router and shell navigation must consume the same auth state.
- Generated routing files must be regenerated after route source changes.
