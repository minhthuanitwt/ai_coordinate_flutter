# Research: Auth-Gated Protected Tabs

## Decision 1: Use a single shared session source backed by `supabase_flutter`

**Decision**: Model authentication state from `SupabaseService.instance.client`
and expose it through a Riverpod provider or screen-scoped view-model so the
router and protected pages can consistently determine whether a user is signed
in.

**Rationale**: The app already initializes Supabase during bootstrap and uses
Supabase-backed repositories. Reusing the same client keeps auth state aligned
with the existing backend, avoids duplicate persistence logic, and matches the
Next.js reference, which relies on Supabase auth helpers before protected page
access.

**Alternatives considered**:

- Fake local auth flag in `shared_preferences`: rejected because it would drift
  from the real backend session and would not support coordinate data access.
- Add a separate auth SDK or abstraction layer first: rejected because this
  slice only needs minimal login gating, not a broader auth platform refactor.

## Decision 2: Gate protected tabs at route-entry and page-runtime levels

**Decision**: Add explicit login routing and guard protected tabs both when the
user attempts to navigate into them and when a session becomes unavailable
while already inside a protected tab.

**Rationale**: The Next.js reference uses `requireAuth()` followed by
`redirect("/login")`, which protects entry into private screens. Flutter does
not have server redirects, so the closest reliable behavior is a router-level
gate combined with page-side session observation for expired sessions or app
resume edge cases.

**Alternatives considered**:

- Gate only inside page `build()` methods: rejected because users could still
  activate protected tabs and briefly see incorrect navigation state.
- Gate only in the shell tab tap handler: rejected because deep links, direct
  route pushes, or future nested navigation could bypass it.

## Decision 3: Ship login-only for this slice and defer signup/advanced auth

**Decision**: Restore a login screen as the only required auth entry point for
this feature slice. Signup, password reset, and account lifecycle flows remain
out of scope unless implementation uncovers a hard dependency.

**Rationale**: The user requested a basic enforced login for protected tabs.
The current app deliberately removed auth to simplify the baseline, so the
smallest useful restoration is login plus session-aware redirection.

**Alternatives considered**:

- Restore full Next.js auth parity immediately: rejected because it is much
  broader than the current need and violates minimal-scoped delivery.
- Keep protected pages public until a full auth suite exists: rejected because
  it fails the spec requirement for protected destinations.

## Decision 4: Preserve shell layout and public `home` behavior

**Decision**: Keep `AppShellPage` as the root tabs container, keep `home`
public, and update the protected tab interactions so guests are sent to login
instead of seeing protected content.

**Rationale**: The existing shell is already the central layout and current spec
explicitly requires a public home surface. This avoids unnecessary routing
restructure and keeps the app understandable for guests.

**Alternatives considered**:

- Move login ahead of the shell as a mandatory app entry: rejected because it
  would remove the public discovery surface.
- Split the app into separate guest and authenticated shells: rejected because
  the current navigation needs only one shell with mixed public/private tabs.

## Decision 5: Add focused i18n copy and empty/error states for auth gating

**Decision**: Extend source translations with login page copy and protected-tab
auth-required messaging in English and Japanese, then regenerate `slang`.

**Rationale**: The app already uses `slang` directly and the repository
constitution requires generated artifacts to be regenerated. Auth gating needs
clear user-facing guidance, especially when a guest taps a protected tab or a
session expires.

**Alternatives considered**:

- Hardcode auth copy in widgets: rejected because it breaks the current i18n
  approach and would create new inconsistencies.
- Reuse Next.js copy verbatim without adaptation: rejected because the Flutter
  slice is intentionally smaller and needs only the subset relevant to login and
  gating.
