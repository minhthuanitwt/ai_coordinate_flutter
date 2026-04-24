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
        final items = [
          _ShellItem(
            label: t.nav.home,
            icon: Icons.home_outlined,
            activeIcon: Icons.home_rounded,
          ),
          _ShellItem(
            label: t.nav.coordinate,
            icon: Icons.auto_awesome_outlined,
            activeIcon: Icons.hub,
          ),
          _ShellItem(
            label: t.nav.mission,
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
          body: SafeArea(child: child),
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
