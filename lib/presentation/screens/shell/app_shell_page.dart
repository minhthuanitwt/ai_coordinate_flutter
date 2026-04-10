import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../l10n/app_strings.dart';
import '../../../routes/app_router.dart';
import '../../../themes/app_colors.dart';
import 'app_shell_view_model.dart';

@RoutePage()
class AppShellPage extends ConsumerWidget {
  const AppShellPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final strings = AppStrings.of(context);
    final state = ref.watch(appShellStateProvider);
    final viewModel = ref.watch(appShellViewModelProvider);
    final isAuthenticated = state.isAuthenticated;

    return AutoTabsRouter(
      routes: const [
        HomeRoute(),
        CoordinateRoute(),
        ChallengeRoute(),
        NotificationsRoute(),
        MyProfileRoute(),
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        final items = [
          _ShellItem(
            label: strings.navHome,
            icon: Icons.home_outlined,
            activeIcon: Icons.home_rounded,
            protected: false,
          ),
          _ShellItem(
            label: strings.navCoordinate,
            icon: Icons.hub_outlined,
            activeIcon: Icons.hub,
            protected: true,
          ),
          _ShellItem(
            label: strings.navChallenge,
            icon: Icons.auto_awesome_outlined,
            activeIcon: Icons.auto_awesome,
            protected: true,
          ),
          _ShellItem(
            label: strings.navNotifications,
            icon: Icons.notifications_outlined,
            activeIcon: Icons.notifications,
            protected: true,
          ),
          _ShellItem(
            label: strings.navMyPage,
            icon: Icons.person_outline,
            activeIcon: Icons.person,
            protected: true,
          ),
        ];

        void openIndex(int index) {
          final item = items[index];
          if (item.protected && !isAuthenticated) {
            context.router.push(const LoginRoute());
            return;
          }
          tabsRouter.setActiveIndex(index);
        }

        final isDesktop = MediaQuery.sizeOf(context).width >= 960;

        return Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: isDesktop
                ? Row(
                    children: [
                      _DesktopSidebar(
                        items: items,
                        currentIndex: tabsRouter.activeIndex,
                        onTap: openIndex,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            _ShellHeader(
                              email: state.email,
                              isAuthenticated: isAuthenticated,
                              isSupabaseConfigured: state.isSupabaseConfigured,
                              onAuthPressed: () async {
                                if (!isAuthenticated) {
                                  context.router.push(const LoginRoute());
                                  return;
                                }
                                await viewModel.signOut();
                                if (context.mounted) {
                                  tabsRouter.setActiveIndex(0);
                                }
                              },
                            ),
                            Expanded(child: child),
                            const _ShellFooter(),
                          ],
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      _ShellHeader(
                        email: state.email,
                        isAuthenticated: isAuthenticated,
                        isSupabaseConfigured: state.isSupabaseConfigured,
                        onAuthPressed: () async {
                          if (!isAuthenticated) {
                            context.router.push(const LoginRoute());
                            return;
                          }
                          await viewModel.signOut();
                          if (context.mounted) {
                            tabsRouter.setActiveIndex(0);
                          }
                        },
                      ),
                      Expanded(child: child),
                    ],
                  ),
          ),
          bottomNavigationBar: isDesktop
              ? null
              : NavigationBar(
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
        );
      },
    );
  }
}

class _DesktopSidebar extends StatelessWidget {
  const _DesktopSidebar({
    required this.items,
    required this.currentIndex,
    required this.onTap,
  });

  final List<_ShellItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 268,
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(right: BorderSide(color: AppColors.border)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.of(context).appName,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            AppStrings.of(context).shellSubtitle,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: AppColors.textMuted),
          ),
          const SizedBox(height: 28),
          for (var i = 0; i < items.length; i++) ...[
            _SidebarTile(
              item: items[i],
              selected: i == currentIndex,
              onTap: () => onTap(i),
            ),
            const SizedBox(height: 8),
          ],
          const Spacer(),
          Text(
            AppStrings.of(context).footerTagline,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: AppColors.textMuted),
          ),
        ],
      ),
    );
  }
}

class _SidebarTile extends StatelessWidget {
  const _SidebarTile({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  final _ShellItem item;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? AppColors.softBlue : Colors.transparent,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Icon(
                selected ? item.activeIcon : item.icon,
                color: selected ? AppColors.primary : AppColors.textMuted,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  item.label,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: selected ? AppColors.primary : AppColors.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              if (item.protected)
                const Icon(
                  Icons.lock_outline,
                  size: 18,
                  color: AppColors.textMuted,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ShellHeader extends StatelessWidget {
  const _ShellHeader({
    required this.email,
    required this.isAuthenticated,
    required this.isSupabaseConfigured,
    required this.onAuthPressed,
  });

  final String? email;
  final bool isAuthenticated;
  final bool isSupabaseConfigured;
  final VoidCallback onAuthPressed;

  @override
  Widget build(BuildContext context) {
    final strings = AppStrings.of(context);
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
                  strings.shellHeaderTitle,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 6),
                Text(
                  isAuthenticated
                      ? strings.shellSignedIn(email ?? strings.defaultUserLabel)
                      : strings.shellSignedOut(isSupabaseConfigured),
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: AppColors.textMuted),
                ),
              ],
            ),
          ),
          FilledButton.tonalIcon(
            onPressed: onAuthPressed,
            icon: Icon(
              isAuthenticated ? Icons.logout_outlined : Icons.login_outlined,
            ),
            label: Text(
              isAuthenticated ? strings.signOutButton : strings.loginCta,
            ),
          ),
        ],
      ),
    );
  }
}

class _ShellFooter extends StatelessWidget {
  const _ShellFooter();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 18),
      child: Text(
        AppStrings.of(context).footerTagline,
        style: Theme.of(
          context,
        ).textTheme.bodySmall?.copyWith(color: AppColors.textMuted),
      ),
    );
  }
}

class _ShellItem {
  const _ShellItem({
    required this.label,
    required this.icon,
    required this.activeIcon,
    required this.protected,
  });

  final String label;
  final IconData icon;
  final IconData activeIcon;
  final bool protected;
}
