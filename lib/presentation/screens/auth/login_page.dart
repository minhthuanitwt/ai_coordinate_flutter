import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../l10n/app_strings.dart';
import '../../../routes/app_router.dart';
import '../../../services/supabase_service.dart';
import '../../../themes/app_colors.dart';
import 'auth_page_scaffold.dart';
import 'auth_view_model.dart';

@RoutePage()
class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final obscurePassword = useState(true);
    final authState = ref.watch(authViewModelProvider);
    final strings = AppStrings.of(context);

    Future<void> handleSubmit() async {
      final email = emailController.text.trim();
      final password = passwordController.text;

      if (email.isEmpty || password.isEmpty) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(strings.authMissingFields)));
        return;
      }

      final success = await ref
          .read(authViewModelProvider.notifier)
          .signIn(email: email, password: password);

      if (!context.mounted) {
        return;
      }

      if (success) {
        context.router.replace(const AppShellRoute());
        return;
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(strings.authSignInFailed)));
    }

    return AuthPageScaffold(
      title: strings.loginTitle,
      subtitle: strings.loginSubtitle(SupabaseService.instance.isConfigured),
      footerPrompt: strings.loginFooterPrompt,
      footerAction: strings.signUpCta,
      onFooterPressed: () => context.router.replace(const SignupRoute()),
      child: Column(
        children: [
          TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: strings.emailLabel,
              hintText: strings.emailHint,
              prefixIcon: const Icon(Icons.mail_outline),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: passwordController,
            obscureText: obscurePassword.value,
            decoration: InputDecoration(
              labelText: strings.passwordLabel,
              hintText: strings.passwordHint,
              prefixIcon: const Icon(Icons.lock_outline),
              suffixIcon: IconButton(
                onPressed: () {
                  obscurePassword.value = !obscurePassword.value;
                },
                icon: Icon(
                  obscurePassword.value
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: authState.isLoading ? null : handleSubmit,
              child: authState.isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(strings.loginButton),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            strings.authAlternativeActions,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: AppColors.textMuted),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: null,
                  icon: const Icon(Icons.g_mobiledata),
                  label: Text(strings.googlePlaceholder),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: null,
                  icon: const Icon(Icons.apple),
                  label: Text(strings.applePlaceholder),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
