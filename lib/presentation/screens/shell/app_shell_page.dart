import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../i18n/strings.g.dart';
import '../../../routes/app_router.dart';
import '../../../themes/app_colors.dart';
import '../../providers/auth_session_provider.dart';

@RoutePage()
class AppShellPage extends ConsumerWidget {
  const AppShellPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final authSession = ref.watch(authSessionProvider).valueOrNull;
    final isAuthenticated = authSession?.isAuthenticated ?? false;

    return AutoTabsRouter(
      routes: const [
        HomeRoute(),
        CoordinateRoute(),
        ChallengeRoute(),
        NotificationsRoute(),
        MyPageRoute(),
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        final showTopAuthHeader = tabsRouter.activeIndex == 4;
        final items = [
          _ShellItem(
            label: t.nav.home,
            icon: Icons.home_outlined,
            activeIcon: Icons.home_rounded,
          ),
          _ShellItem(
            label: t.nav.coordinate,
            icon: Icons.hub_outlined,
            activeIcon: Icons.hub,
          ),
          _ShellItem(
            label: t.nav.challenge,
            icon: Icons.auto_awesome_outlined,
            activeIcon: Icons.auto_awesome,
          ),
          _ShellItem(
            label: t.nav.notifications,
            icon: Icons.notifications_outlined,
            activeIcon: Icons.notifications,
          ),
          _ShellItem(
            label: t.nav.my_page,
            icon: Icons.person_outline,
            activeIcon: Icons.person,
          ),
        ];

        void openIndex(int index) {
          final protectedTarget = _protectedTargetForIndex(index);
          if (protectedTarget != null && !isAuthenticated) {
            ref.read(authRedirectTargetProvider.notifier).state =
                protectedTarget;
            final messenger = ScaffoldMessenger.maybeOf(context);
            messenger?.clearSnackBars();
            messenger?.showSnackBar(
              SnackBar(content: Text(t.auth.required_body)),
            );
            context.router.root.push(const LoginRoute());
            return;
          }
          tabsRouter.setActiveIndex(index);
        }

        return Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: Column(
              children: [
                if (showTopAuthHeader) ...[
                  const _ShellHeader(),
                  _SessionBanner(
                    isAuthenticated: isAuthenticated,
                    email: authSession?.email,
                  ),
                ],
                Expanded(child: child),
              ],
            ),
          ),
          bottomNavigationBar: NavigationBarTheme(
            data: NavigationBarThemeData(
              labelTextStyle: WidgetStatePropertyAll(
                Theme.of(
                  context,
                ).textTheme.labelSmall?.copyWith(fontSize: 12, height: 1.0),
              ),
            ),
            child: NavigationBar(
              selectedIndex: tabsRouter.activeIndex,
              onDestinationSelected: openIndex,
              destinations: items
                  .map(
                    (item) => NavigationDestination(
                      icon: Icon(item.icon),
                      selectedIcon: Icon(item.activeIcon),
                      label: item.label,
                    ),
                  )
                  .toList(),
            ),
          ),
        );
      },
    );
  }

  ProtectedDestination? _protectedTargetForIndex(int index) {
    return switch (index) {
      1 => ProtectedDestination.coordinate,
      2 => ProtectedDestination.challenge,
      3 => ProtectedDestination.notifications,
      4 => ProtectedDestination.myPage,
      _ => null,
    };
  }
}

class _ShellHeader extends ConsumerWidget {
  const _ShellHeader();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final authSession = ref.watch(authSessionProvider).valueOrNull;
    final isAuthenticated = authSession?.isAuthenticated ?? false;
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.shell.subtitle,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: AppColors.textMuted),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          if (isAuthenticated)
            OutlinedButton.icon(
              onPressed: () async {
                await ref.read(authRepositoryProvider).signOut();
                ref.read(authRedirectTargetProvider.notifier).state = null;
              },
              icon: const Icon(Icons.logout_outlined),
              label: Text(t.shell.logout_cta),
            )
          else
            FilledButton.icon(
              onPressed: () {
                context.router.root.push(const LoginRoute());
              },
              icon: const Icon(Icons.login),
              label: Text(t.shell.login_cta),
            ),
        ],
      ),
    );
  }
}

class _SessionBanner extends StatelessWidget {
  const _SessionBanner({required this.isAuthenticated, required this.email});

  final bool isAuthenticated;
  final String? email;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Text(
        isAuthenticated
            ? '${t.shell.member_badge}: ${email ?? ''}'
            : t.shell.guest_badge,
        style: Theme.of(
          context,
        ).textTheme.bodyMedium?.copyWith(color: AppColors.textMuted),
      ),
    );
  }
}

class _ShellItem {
  const _ShellItem({
    required this.label,
    required this.icon,
    required this.activeIcon,
  });

  final String label;
  final IconData icon;
  final IconData activeIcon;
}
