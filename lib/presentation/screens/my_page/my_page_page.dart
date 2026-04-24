import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/models/my_page_balance.dart';
import '../../../domain/models/my_page_image_item.dart';
import '../../../domain/models/my_page_profile.dart';
import '../../../domain/models/my_page_stats.dart';
import '../../../i18n/strings.g.dart';
import '../../../presentation/providers/auth_session_provider.dart';
import '../../../themes/app_colors.dart';
import 'my_page_view_model.dart';

@RoutePage(name: 'MyPageRoute')
class MyPagePage extends ConsumerStatefulWidget {
  const MyPagePage({super.key});

  @override
  ConsumerState<MyPagePage> createState() => _MyPagePageState();
}

class _MyPagePageState extends ConsumerState<MyPagePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(myPageViewModelProvider.notifier).loadInitial();
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final state = ref.watch(myPageViewModelProvider);
    final isAuthenticated = ref.watch(isAuthenticatedProvider);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(t.my_page.title),
        actions: [
          if (isAuthenticated)
            IconButton(
              tooltip: t.my_page.appbar.menu_action,
              onPressed: () => _scaffoldKey.currentState?.openEndDrawer(),
              icon: const Icon(Icons.menu),
            ),
        ],
      ),
      endDrawer: Drawer(
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Text(
                  t.my_page.drawer.title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const Divider(height: 1),
              const SizedBox(height: 8),
              ListTile(
                leading: const Icon(Icons.person_outline),
                title: Text(t.my_page.drawer.account_action),
                onTap: () {
                  Navigator.of(context).maybePop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.language),
                title: Text(t.my_page.drawer.language_settings_action),
                onTap: () {
                  Navigator.of(context).maybePop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.support_agent_outlined),
                title: Text(t.my_page.drawer.contact_action),
                onTap: () {
                  Navigator.of(context).maybePop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.add_circle_outline),
                title: Text(t.my_page.drawer.buy_percoins_action),
                onTap: () {
                  Navigator.of(context).maybePop();
                },
              ),
              if (isAuthenticated)
                ListTile(
                  leading: const Icon(Icons.logout_outlined),
                  title: Text(t.my_page.drawer.logout_action),
                  onTap: () async {
                    Navigator.of(context).maybePop();
                    await _onTapLogout();
                  },
                ),
            ],
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: ref.read(myPageViewModelProvider.notifier).refresh,
        child: NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            if (notification.metrics.pixels >=
                notification.metrics.maxScrollExtent - 280) {
              ref.read(myPageViewModelProvider.notifier).loadMoreImages();
            }
            return false;
          },
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: _MyPageTopHeader(
                  profile: state.profile,
                  isLoading: state.isLoadingInitial && state.profile == null,
                ),
              ),
              if (state.errorCode != null && !state.hasAnyData)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: _MyPageBlockingErrorView(
                    onRetry: () => ref
                        .read(myPageViewModelProvider.notifier)
                        .loadInitial(),
                  ),
                )
              else ...[
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                    child: _StatsSection(
                      stats: state.stats,
                      isLoading: state.isLoadingInitial && state.stats == null,
                      errorCode: state.statsErrorCode,
                      onRetry: () => ref
                          .read(myPageViewModelProvider.notifier)
                          .loadInitial(),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                    child: _BalanceSection(
                      balance: state.balance,
                      isLoading:
                          state.isLoadingInitial && state.balance == null,
                      errorCode: state.balanceErrorCode,
                      onRetry: () => ref
                          .read(myPageViewModelProvider.notifier)
                          .loadInitial(),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
                    child: Text(
                      t.my_page.gallery_title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ),
                if (state.isLoadingInitial && state.images.isEmpty)
                  const SliverPadding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 28),
                    sliver: _ImageLoadingSliver(),
                  )
                else if (state.imagesErrorCode != null && state.images.isEmpty)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                      child: _SectionErrorCard(
                        title: t.my_page.gallery_error_title,
                        body: t.my_page.gallery_error_body,
                        onRetry: () => ref
                            .read(myPageViewModelProvider.notifier)
                            .loadInitial(),
                      ),
                    ),
                  )
                else if (state.isGalleryEmpty)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                      child: _SectionEmptyCard(
                        title: t.my_page.gallery_empty_title,
                        body: t.my_page.gallery_empty_body,
                      ),
                    ),
                  )
                else
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    sliver: SliverLayoutBuilder(
                      builder: (context, constraints) {
                        final width = constraints.crossAxisExtent;
                        final columns = width >= 1100
                            ? 3
                            : width >= 700
                            ? 2
                            : 1;
                        return SliverGrid.builder(
                          itemCount: state.images.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: columns,
                                crossAxisSpacing: 14,
                                mainAxisSpacing: 14,
                                mainAxisExtent: columns == 1 ? 378 : 332,
                              ),
                          itemBuilder: (context, index) {
                            return _MyImageCard(item: state.images[index]);
                          },
                        );
                      },
                    ),
                  ),
                if (state.images.isNotEmpty && state.isLoadingMoreImages)
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 28),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  )
                else if (state.images.isNotEmpty && state.hasMoreImages)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 28),
                      child: Center(
                        child: OutlinedButton(
                          onPressed: () => ref
                              .read(myPageViewModelProvider.notifier)
                              .loadMoreImages(),
                          child: Text(t.common.load_more_button),
                        ),
                      ),
                    ),
                  ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onTapLogout() async {
    await ref.read(authRepositoryProvider).signOut();
    if (!mounted) {
      return;
    }
    ref.read(authRedirectTargetProvider.notifier).state = null;
    context.tabsRouter.setActiveIndex(0);
  }
}

class _MyPageTopHeader extends StatelessWidget {
  const _MyPageTopHeader({required this.profile, required this.isLoading});

  final MyPageProfile? profile;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final displayName = profile?.displayName.trim();
    final effectiveDisplayName = (displayName != null && displayName.isNotEmpty)
        ? displayName
        : t.my_page.default_display_name;
    final avatarUrl = profile?.avatarUrl?.trim();
    final hasAvatar = avatarUrl != null && avatarUrl.isNotEmpty;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isCompact = constraints.maxWidth <= 360;
        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: isCompact ? 42 : 48,
                backgroundColor: AppColors.softBlue,
                backgroundImage: hasAvatar ? NetworkImage(avatarUrl) : null,
                child: hasAvatar
                    ? null
                    : Icon(
                        Icons.person_outline,
                        color: AppColors.primary,
                        size: isCompact ? 36 : 44,
                      ),
              ),
              const SizedBox(height: 14),
              Text(
                isLoading ? t.loading : effectiveDisplayName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  fontSize: isCompact ? 30 : 36,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _StatsSection extends StatelessWidget {
  const _StatsSection({
    required this.stats,
    required this.isLoading,
    required this.errorCode,
    required this.onRetry,
  });

  final MyPageStats? stats;
  final bool isLoading;
  final String? errorCode;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    if (isLoading) {
      return const _LoadingCard(height: 164);
    }
    if (stats == null) {
      return _SectionErrorCard(
        title: t.my_page.stats_error_title,
        body: t.my_page.stats_error_body,
        onRetry: onRetry,
      );
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    t.my_page.stats_title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                if (errorCode != null)
                  TextButton(
                    onPressed: onRetry,
                    child: Text(t.common.retry_button),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                _StatChip(
                  label: t.my_page.stats_generated,
                  value: '${stats!.generatedCount}',
                ),
                _StatChip(
                  label: t.my_page.stats_posted,
                  value: '${stats!.postedCount}',
                ),
                _StatChip(
                  label: t.my_page.stats_likes,
                  value: '${stats!.likeCount}',
                ),
                _StatChip(
                  label: t.my_page.stats_views,
                  value: '${stats!.viewCount}',
                ),
                _StatChip(
                  label: t.my_page.stats_followers,
                  value: '${stats!.followerCount}',
                ),
                _StatChip(
                  label: t.my_page.stats_following,
                  value: '${stats!.followingCount}',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _BalanceSection extends StatelessWidget {
  const _BalanceSection({
    required this.balance,
    required this.isLoading,
    required this.errorCode,
    required this.onRetry,
  });

  final MyPageBalance? balance;
  final bool isLoading;
  final String? errorCode;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    if (isLoading) {
      return const _LoadingCard(height: 150);
    }
    if (balance == null) {
      return _SectionErrorCard(
        title: t.my_page.balance_error_title,
        body: t.my_page.balance_error_body,
        onRetry: onRetry,
      );
    }
    final data = balance!;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    t.my_page.balance_title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                if (errorCode != null)
                  TextButton(
                    onPressed: onRetry,
                    child: Text(t.common.retry_button),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              '${data.total} ${t.my_page.balance_unit}',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                _StatChip(
                  label: t.my_page.balance_regular,
                  value: '${data.regular}',
                ),
                _StatChip(label: t.my_page.balance_paid, value: '${data.paid}'),
                _StatChip(
                  label: t.my_page.balance_unlimited_bonus,
                  value: '${data.unlimitedBonus}',
                ),
                _StatChip(
                  label: t.my_page.balance_period_limited,
                  value: '${data.periodLimited}',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MyImageCard extends StatelessWidget {
  const _MyImageCard({required this.item});

  final MyPageImageItem item;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: AspectRatio(
                aspectRatio: 1,
                child: Image.network(
                  item.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const ColoredBox(
                        color: AppColors.softBlue,
                        child: Center(
                          child: Icon(
                            Icons.image_not_supported_outlined,
                            color: AppColors.primary,
                            size: 30,
                          ),
                        ),
                      ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              item.previewText.isEmpty
                  ? t.my_page.gallery_missing_preview
                  : item.previewText,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            Text(
              _formatDate(item.postedAt ?? item.createdAt),
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: AppColors.textMuted),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) {
      return '-';
    }
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '${date.year}-$month-$day';
  }
}

class _StatChip extends StatelessWidget {
  const _StatChip({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: Theme.of(
                context,
              ).textTheme.labelMedium?.copyWith(color: AppColors.textMuted),
            ),
            const SizedBox(height: 2),
            Text(value, style: Theme.of(context).textTheme.titleSmall),
          ],
        ),
      ),
    );
  }
}

class _LoadingCard extends StatelessWidget {
  const _LoadingCard({required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border),
      ),
      child: SizedBox(
        height: height,
        child: const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class _SectionErrorCard extends StatelessWidget {
  const _SectionErrorCard({
    required this.title,
    required this.body,
    required this.onRetry,
  });

  final String title;
  final String body;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(
              body,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.textMuted),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: onRetry,
              child: Text(t.common.retry_button),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionEmptyCard extends StatelessWidget {
  const _SectionEmptyCard({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(
              body,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.textMuted),
            ),
          ],
        ),
      ),
    );
  }
}

class _MyPageBlockingErrorView extends StatelessWidget {
  const _MyPageBlockingErrorView({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    return Padding(
      padding: const EdgeInsets.all(24),
      child: _SectionErrorCard(
        title: t.my_page.error_title,
        body: t.my_page.error_body,
        onRetry: onRetry,
      ),
    );
  }
}

class _ImageLoadingSliver extends StatelessWidget {
  const _ImageLoadingSliver();

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      itemCount: 4,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
        mainAxisExtent: 280,
      ),
      itemBuilder: (context, index) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppColors.border),
          ),
          child: const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
