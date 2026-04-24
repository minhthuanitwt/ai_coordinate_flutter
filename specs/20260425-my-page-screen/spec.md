# Feature Specification: My Page Screen (Initial Flutter Port)

**Feature Branch**: `20260425-my-page-screen`  
**Created**: 2026-04-25  
**Status**: Draft  
**Input**: User description: "Bắt đầu cài đặt màn hình My Page tham khảo code của /Users/dongdm/Develop/Source/doi/ai_coordinate/app/(app)/my-page"

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Open My Page after login (Priority: P1)

An authenticated user opens the `my-page` tab and sees their own profile
overview instead of a placeholder page.

**Why this priority**: The tab already exists in navigation and is protected by
auth. Without real content, the authenticated flow feels incomplete.

**Independent Test**: Sign in, open `my-page`, and verify profile, summary
stats, credit balance summary, and image gallery sections render in one
continuous page.

**Acceptance Scenarios**:

1. **Given** a signed-in user, **When** they open `my-page`, **Then** the app
   shows profile header, stats block, balance block, and generated images
   section.
2. **Given** `my-page` data is still loading, **When** the screen first
   appears, **Then** each section shows explicit loading placeholders.

---

### User Story 2 - Handle empty and partial data safely (Priority: P2)

A signed-in user with incomplete profile or no generated images still sees a
clear, usable My Page.

**Why this priority**: Supabase data can be missing in early accounts; the UI
must not break or look blank.

**Independent Test**: Use a user with no profile nickname/avatar and no images,
then verify fallback text/avatars and empty-state content are displayed.

**Acceptance Scenarios**:

1. **Given** profile fields are null, **When** My Page loads, **Then** the app
   renders default avatar and fallback labels.
2. **Given** user has zero generated images, **When** gallery section loads,
   **Then** the app shows a dedicated empty state with guidance text.

---

### User Story 3 - Respect protected tab behavior (Priority: P3)

An unauthenticated visitor tapping `my-page` is still redirected to login and
does not see private profile content.

**Why this priority**: Existing auth gate behavior must remain consistent across
protected tabs.

**Independent Test**: Sign out, tap `my-page` from shell, verify login
redirection, then sign in and confirm return to `my-page`.

**Acceptance Scenarios**:

1. **Given** no active session, **When** user opens `my-page`, **Then** app
   routes to login and stores redirect target.
2. **Given** redirect target is `my-page`, **When** sign-in succeeds, **Then**
   app returns user to `my-page` tab.

### Edge Cases

- Supabase is not configured (`SupabaseService.isConfigured == false`) while
  user opens `my-page`.
- Some blocks load successfully but another block fails (for example stats
  request fails while profile succeeds).
- Session expires during My Page load, returning unauthorized errors.
- Gallery item has missing image URL or deleted media.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: System MUST keep `my-page` as an authenticated destination in the
  main tab shell.
- **FR-002**: System MUST render My Page using a dedicated screen module
  structure (`page`, `state`, `view_model`) aligned with current Flutter
  architecture.
- **FR-003**: System MUST display profile header content with safe fallbacks for
  missing nickname, bio, and avatar.
- **FR-004**: System MUST display user stats summary including at least
  generated count, posted count, and like count when available.
- **FR-005**: System MUST display current user credit balance summary.
- **FR-006**: System MUST display a generated image gallery for the current
  user, with empty state when no items exist.
- **FR-007**: System MUST provide explicit loading, error, empty, and success
  states for each major data area.
- **FR-008**: System MUST not expose private My Page content to unauthenticated
  users.
- **FR-009**: System SHOULD preserve current login redirect flow to return users
  to My Page after authentication.
- **FR-010**: System SHOULD align copy/content structure with the web My Page
  reference while adapting layout to Flutter mobile constraints.

### Key Entities *(include if feature involves data)*

- **My Page Profile**: Current user identity presentation (`userId`, `nickname`,
  `bio`, `avatarUrl`, optional plan/email metadata).
- **My Page Stats**: Aggregated counters (`generatedCount`, `postedCount`,
  `likeCount`, `viewCount`, follower/following counts where available).
- **Credit Balance Summary**: User balance data from credits source
  (`total/regular/paid/bonus` subsets where available).
- **My Image Item**: User-owned generated image card (`id`, `imageUrl`,
  `createdAt/postedAt`, prompt/caption summary, posted flag).

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Signed-in users can open `my-page` and see non-placeholder content
  within one navigation step from shell.
- **SC-002**: My Page continues to block unauthenticated access in 100% of
  manual gate checks.
- **SC-003**: Empty-data accounts still render an understandable My Page without
  visual breakage or crashes.
- **SC-004**: Data refresh from initial load to loaded state is visually clear
  with no full-screen flicker after first frame.

## Assumptions

- Existing Supabase tables/RPC used by the web My Page remain available to the
  Flutter app (profiles, generated_images, likes, user_credits, follow counts).
- This feature scope targets the main `my-page` tab only; sub-pages like
  `account`, `contact`, `credits` can follow in separate slices.
- Existing auth and redirect providers remain the source of truth for protected
  navigation.
- Japanese and English localization keys for My Page copy are maintained through
  current i18n workflow in this repository.
