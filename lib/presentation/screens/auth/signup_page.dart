import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../l10n/app_strings.dart';
import '../../../routes/app_router.dart';
import '../../../themes/app_colors.dart';
import 'auth_page_scaffold.dart';
import 'auth_view_model.dart';

@RoutePage()
class SignupPage extends HookConsumerWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final confirmController = useTextEditingController();
    final obscurePassword = useState(true);
    final obscureConfirm = useState(true);
    final authState = ref.watch(authViewModelProvider);
    final strings = AppStrings.of(context);

    Future<void> handleSubmit() async {
      final email = emailController.text.trim();
      final password = passwordController.text;
      final confirm = confirmController.text;

      if (email.isEmpty || password.isEmpty || confirm.isEmpty) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(strings.authMissingFields)));
        return;
      }

      if (password.length < 8) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(strings.passwordRule)));
        return;
      }

      if (password != confirm) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(strings.passwordMismatch)));
        return;
      }

      await ref
          .read(authViewModelProvider.notifier)
          .signUp(email: email, password: password);

      if (!context.mounted) {
        return;
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(strings.signupSuccess)));
      context.router.replace(const LoginRoute());
    }

    return AuthPageScaffold(
      title: strings.signupTitle,
      subtitle: strings.signupSubtitle,
      footerPrompt: strings.signupFooterPrompt,
      footerAction: strings.loginCta,
      onFooterPressed: () => context.router.replace(const LoginRoute()),
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
          const SizedBox(height: 16),
          TextField(
            controller: confirmController,
            obscureText: obscureConfirm.value,
            decoration: InputDecoration(
              labelText: strings.confirmPasswordLabel,
              hintText: strings.passwordHint,
              prefixIcon: const Icon(Icons.lock_person_outlined),
              suffixIcon: IconButton(
                onPressed: () {
                  obscureConfirm.value = !obscureConfirm.value;
                },
                icon: Icon(
                  obscureConfirm.value
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              strings.passwordRule,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: AppColors.textMuted),
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
                  : Text(strings.signUpButton),
            ),
          ),
        ],
      ),
    );
  }
}
