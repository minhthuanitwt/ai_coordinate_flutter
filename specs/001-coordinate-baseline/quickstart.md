# Quickstart: Auth-Gated Protected Tabs

## Goal

Restore a minimal login flow so guests can browse `home` publicly but must log
in before accessing `coordinate`, `challenge`, `notifications`, and `my-page`.

## Implementation Steps

1. Add auth source files:
   - create login screen files under `lib/presentation/screens/auth/`
   - add session and login view-model/state handling using Riverpod
   - add minimal auth repository/service integration using `supabase_flutter`
2. Update routing:
   - add `LoginRoute` to `lib/routes/app_router.dart`
   - mark protected destinations for auth-gated navigation behavior
   - regenerate `auto_route` output
3. Update shell behavior:
   - keep `home` public
   - route guests tapping protected tabs to login
   - return authenticated users to the requested tab
4. Update protected screens:
   - prevent protected content from rendering for guests
   - handle session expiry by redirecting back to login
5. Update translations:
   - add `auth` copy and auth-required messaging in
     `assets/i18n/en.i18n.json`
   - add matching Japanese copy in
     `assets/i18n/ja.i18n.json`
   - regenerate `slang`
6. Verify:
   - run `fvm dart run build_runner build -d`
   - run `fvm dart run slang`
   - run `fvm dart analyze lib`
   - run focused widget tests for guest redirection and successful post-login
     return behavior

## Reference Inputs

- Flutter router and shell:
  - `lib/routes/app_router.dart`
  - `lib/presentation/screens/shell/app_shell_page.dart`
- Supabase bootstrap:
  - `lib/services/supabase_service.dart`
  - `lib/presentation/providers/app_bootstrap_provider.dart`
- Next.js reference:
  - `/Users/dongdm/Develop/Source/doi/ai_coordinate/lib/auth.ts`
  - `/Users/dongdm/Develop/Source/doi/ai_coordinate/messages/ja.ts`
