# Data Model: Home and My Page Appbars

## Entity: HeaderVariant

- **Purpose**: Defines tab-specific header composition and display behavior.
- **Attributes**:
  - `id`: Unique identifier (`home`, `my_page`)
  - `screen`: Target screen key
  - `layout`: Ordered regions (`left`, `center`, `right`, `top-profile`, etc.)
  - `styleTokens`: Typography/spacing/radius references used by the variant
  - `visibilityRule`: Rule set for authenticated vs unauthenticated state
- **Validation Rules**:
  - `id` must be unique.
  - `layout` must contain all required regions for the variant.
  - `visibilityRule` must not expose protected actions when unauthenticated.

## Entity: HeaderAction

- **Purpose**: Represents an interactive control in Home/My Page top section.
- **Attributes**:
  - `actionId`: Unique action key within appbar context
  - `headerVariantId`: Parent variant (`home` or `my_page`)
  - `label`: User-facing semantic label (localized)
  - `icon`: Visual symbol
  - `isProtected`: Whether auth is required
  - `unauthenticatedBehavior`: Behavior when user is logged out (`hidden`)
  - `targetBehaviorRef`: Reference to web baseline behavior mapping
- **Validation Rules**:
  - `actionId` must be unique per `headerVariantId`.
  - Protected actions must declare `unauthenticatedBehavior = hidden`.
  - Each action must map to exactly one behavior outcome.

## Entity: ProfileHeaderData

- **Purpose**: Data presented in My Page header region.
- **Attributes**:
  - `userId`
  - `displayName`
  - `avatarUrl`
  - `isAuthenticated`
  - `fallbackDisplayName`
  - `fallbackAvatarState`
- **Validation Rules**:
  - If `isAuthenticated = false`, protected actions are hidden.
  - If `displayName` or `avatarUrl` missing, fallback values are used without layout break.

## Entity: RightDrawerState

- **Purpose**: Captures UI state for My Page right-side drawer interaction.
- **Attributes**:
  - `isOpen`: Boolean open/closed state
  - `sourceActionId`: Trigger action key
  - `menuItems`: Drawer options list
  - `lastInteractionAt`: Timestamp for interaction tracking (optional UI state)
- **Validation Rules**:
  - Drawer opens only from valid My Page menu action trigger.
  - Drawer state transitions must be deterministic.

## Relationships

- `HeaderVariant 1 -> N HeaderAction`
- `HeaderVariant (my_page) 1 -> 1 ProfileHeaderData (render input)`
- `HeaderAction (my_page_menu) 1 -> 1 RightDrawerState`

## State Transitions

## Header visibility/auth state

- `Unauthenticated` -> `Authenticated`: protected actions become visible according to variant rules.
- `Authenticated` -> `Unauthenticated`: protected actions are removed from visible appbar controls.

## My Page drawer state

- `Closed` -> `Open`: user activates My Page menu icon.
- `Open` -> `Closed`: user dismisses drawer by close action, backdrop tap, or route change.

