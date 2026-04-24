# Research: My Page Screen (Initial Flutter Port)

## Decision 1: Build a dedicated My Page feature module (`my_page`) instead of extending `my_profile`

**Decision**: Create a new screen module under
`lib/presentation/screens/my_page/` with three files (`page`, `state`,
`view_model`) and route integration, then phase out `my_profile` placeholder.

**Rationale**:
- Route path is already `my-page`; naming the module `my_page` removes
  cognitive mismatch and reduces future maintenance confusion.
- Current project convention requested by user is explicit split into page/state/view-model.
- Dedicated module avoids overloading placeholder code with unrelated
  responsibilities.

**Alternatives considered**:
- Keep `my_profile` file names and only add more widgets inside it.
- Keep route path as `my-page` but continue using `my_profile` naming.

## Decision 2: Follow web My Page information architecture for MVP

**Decision**: Port the top-level web My Page structure from
`/Users/dongdm/Develop/Source/doi/ai_coordinate/app/(app)/my-page/page.tsx`
as four Flutter sections: profile header, user stats, balance summary, image
gallery.

**Rationale**:
- Keeps UX parity with existing product behavior.
- Provides immediate user value in the tab without implementing every web
  sub-route.
- Matches user request to use web code as reference while keeping scope minimal.

**Alternatives considered**:
- Port only profile header first (too little value for a protected tab).
- Port all my-page sub-pages (`account`, `contact`, `credits`) in one slice
  (scope too large for a first delivery).

## Decision 3: Fetch My Page data via repository layer using existing Supabase service

**Decision**: Introduce `MyPageRepository` and
`SupabaseMyPageRepository` consistent with existing home/auth repository
patterns.

**Rationale**:
- Aligns with current architecture (`domain/repository` + `services`).
- Keeps Supabase query details out of UI/view-model logic.
- Simplifies testing by allowing repository mocking.

**Alternatives considered**:
- Query Supabase directly in `my_page_view_model.dart`.
- Reuse home/coordinate repositories for My Page data (cross-feature coupling).

## Decision 4: Keep protected-tab gate behavior unchanged

**Decision**: Continue using `auth_session_provider` and existing redirect
target flow for unauthenticated access to `my-page`.

**Rationale**:
- Gate logic for protected tabs is already implemented and user-approved.
- Avoids duplicate auth checks in multiple layers.
- Minimizes regression risk in navigation behavior.

**Alternatives considered**:
- Add another auth gate in My Page view-model/page.
- Move all gate logic from shell to route guards in this slice.

## Decision 5: Use explicit section states and avoid full-screen flicker on refresh

**Decision**: Model My Page state with section-aware loading/error fields and
update only data blocks that change, keeping top section stable after initial
render.

**Rationale**:
- Matches project constraint requiring explicit loading/error/empty/success
  states.
- Addresses previously observed UX issue where top of screen reloads on filter/data changes.
- Produces smoother user experience on mobile networks.

**Alternatives considered**:
- Single global loading flag for entire page.
- Always full-page reload on pull-to-refresh.
