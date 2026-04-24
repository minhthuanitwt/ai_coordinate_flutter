# Contract: Home/My Page Appbar Behavior

## Purpose

Define the observable UI contract for Home and My Page top sections so implementation and QA can verify behavior consistently.

## Contract Scope

- Home appbar composition and action behavior
- My Page appbar/profile header composition and menu behavior
- Auth-dependent action visibility
- Responsive behavior for 360dp, 390dp, and 430dp widths

## Canonical Baseline

- Web product behavior is the source-of-truth for action outcomes.

## Action Mapping

| Surface | Action | Behavior Outcome |
|---------|--------|------------------|
| Home appbar | Search surface | Opens discovery/generation entry flow |
| Home appbar | Locale icon | Opens language selector and applies chosen locale |
| Home appbar | Profile icon (protected) | Opens My Page tab |
| My Page header | Menu icon (protected) | Opens right-side account drawer |
| My Page drawer | Home | Switches to Home tab |
| My Page drawer | Coordinate | Switches to Coordinate tab |
| My Page drawer | Notifications | Switches to Notifications tab |
| My Page drawer | Login / Logout | Executes auth entry or sign-out flow |

## Home Appbar Contract

### Required Regions

- Left: brand identity block
- Center: search entry surface
- Right: utility/action controls (as defined by web baseline)

### Behavior Rules

- Every visible action must execute the mapped web-equivalent outcome on first tap.
- Protected actions must be hidden when user is unauthenticated.
- Header must remain stable during tab changes and not display My Page variant elements.

## My Page Appbar/Header Contract

### Required Regions

- Top profile-focused composition (avatar + display identity area)
- Right-side menu icon in top section

### Behavior Rules

- Menu icon must open a right-side drawer.
- Drawer must expose account-related actions consistent with web baseline outcomes.
- Protected actions in top section must be hidden when user is unauthenticated.

## Fallback Contract

- Missing avatar must render fallback visual without spacing collapse.
- Missing display name must render fallback text without action overlap.
- Long localized labels must not push controls out of tap-safe area.

## Responsive Contract

- At widths 360dp, 390dp, 430dp:
  - No overlap among icon controls, search surface, and identity elements
  - No action loss due to truncation
  - All visible actions remain tappable

## Acceptance Mapping

- FR-001..FR-012 and SC-001..SC-008 in spec define pass/fail outcomes for this contract.
