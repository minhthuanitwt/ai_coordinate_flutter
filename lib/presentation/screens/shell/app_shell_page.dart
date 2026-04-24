import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../i18n/strings.g.dart';
import '../../providers/auth_session_provider.dart';
import '../../../routes/app_router.dart';
import '../../../themes/app_colors.dart';

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
        MyProfileRoute(),
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
            ref.read(authRedirectTargetProvider.notifier).state = protectedTarget;
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
                            const _ShellHeader(),
                            _SessionBanner(
                              isAuthenticated: isAuthenticated,
                              email: authSession?.email,
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
                      const _ShellHeader(),
                      _SessionBanner(
                        isAuthenticated: isAuthenticated,
                        email: authSession?.email,
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
            context.t.app_name,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            context.t.shell.subtitle,
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
            context.t.shell.footer_tagline,
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
            ],
          ),
        ),
      ),
    );
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
                  t.shell.header_title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 6),
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

class _ShellFooter extends StatelessWidget {
  const _ShellFooter();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 18),
      child: Text(
        context.t.shell.footer_tagline,
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
  });

  final String label;
  final IconData icon;
  final IconData activeIcon;
}
