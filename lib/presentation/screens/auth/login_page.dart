import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/models/auth_session.dart';
import '../../../i18n/strings.g.dart';
import '../../../presentation/providers/auth_session_provider.dart';
import '../../../routes/app_router.dart';
import '../../../themes/app_colors.dart';
import 'login_view_model.dart';

@RoutePage()
class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final state = ref.watch(loginViewModelProvider);
    final session = ref.watch(authSessionProvider).valueOrNull;

    _maybeRedirectAuthenticatedUser(session);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 460),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(color: AppColors.border),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        t.auth.login_title,
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        t.auth.login_description,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.textMuted,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        t.auth.email_label,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        autofillHints: const [AutofillHints.username],
                        onChanged: ref
                            .read(loginViewModelProvider.notifier)
                            .updateEmail,
                        decoration: InputDecoration(
                          hintText: 'name@example.com',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),
                      Text(
                        t.auth.password_label,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        obscureText: _obscurePassword,
                        autocorrect: false,
                        autofillHints: const [AutofillHints.password],
                        onChanged: ref
                            .read(loginViewModelProvider.notifier)
                            .updatePassword,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                            ),
                          ),
                        ),
                      ),
                      if (state.errorCode != null) ...[
                        const SizedBox(height: 14),
                        Text(
                          _errorText(context, state.errorCode!),
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: Colors.red.shade700),
                        ),
                      ],
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: state.isSubmitting ? null : _submit,
                          child: Text(
                            state.isSubmitting
                                ? t.auth.logging_in
                                : t.auth.login_action,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: state.isSubmitting ? null : _goHome,
                          icon: const Icon(Icons.home_outlined),
                          label: Text(t.auth.back_home_action),
                        ),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        SupabaseServiceNote.message(context),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _maybeRedirectAuthenticatedUser(AuthSession? session) {
    if (session?.isAuthenticated != true) {
      return;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      final target = ref.read(authRedirectTargetProvider);
      ref.read(authRedirectTargetProvider.notifier).state = null;
      context.router.replaceAll([
        AppShellRoute(children: [_routeForTarget(target)]),
      ]);
    });
  }

  Future<void> _submit() async {
    final success = await ref.read(loginViewModelProvider.notifier).signIn();
    if (!success || !mounted) {
      return;
    }

    final target = ref.read(authRedirectTargetProvider);
    ref.read(authRedirectTargetProvider.notifier).state = null;
    context.router.replaceAll([
      AppShellRoute(children: [_routeForTarget(target)]),
    ]);
  }

  void _goHome() {
    ref.read(authRedirectTargetProvider.notifier).state = null;
    context.router.replaceAll([
      const AppShellRoute(children: [HomeRoute()]),
    ]);
  }

  PageRouteInfo _routeForTarget(ProtectedDestination? target) {
    return switch (target) {
      ProtectedDestination.coordinate => const CoordinateRoute(),
      ProtectedDestination.challenge => const ChallengeRoute(),
      ProtectedDestination.notifications => const NotificationsRoute(),
      ProtectedDestination.myPage => const MyPageRoute(),
      null => const HomeRoute(),
    };
  }

  String _errorText(BuildContext context, String errorCode) {
    final t = context.t;
    return switch (errorCode) {
      'missing_credentials' => t.auth.validation_missing_credentials,
      _ => t.auth.login_failed,
    };
  }
}

class SupabaseServiceNote {
  static String message(BuildContext context) {
    final t = context.t;
    return t.auth.login_hint;
  }
}
