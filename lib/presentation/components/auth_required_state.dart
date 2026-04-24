import 'package:flutter/material.dart';

import '../../i18n/strings.g.dart';
import '../../themes/app_colors.dart';

class AuthRequiredState extends StatelessWidget {
  const AuthRequiredState({
    super.key,
    required this.title,
    required this.description,
    required this.onLogin,
  });

  final String title;
  final String description;
  final VoidCallback onLogin;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(28),
              border: Border.all(color: AppColors.border),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircleAvatar(
                    radius: 28,
                    backgroundColor: AppColors.softBlue,
                    child: Icon(Icons.lock_outline, color: AppColors.primary),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    description,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(color: AppColors.textMuted),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 18),
                  FilledButton(
                    onPressed: onLogin,
                    child: Text(t.auth.login_action),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
