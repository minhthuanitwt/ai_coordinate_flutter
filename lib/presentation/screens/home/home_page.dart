import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/models/home_banner_item.dart';
import '../../../core/models/home_feed_item.dart';
import '../../../l10n/app_strings.dart';
import '../../../themes/app_colors.dart';
import 'home_view_model.dart';

@RoutePage()
class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final _pageController = PageController(viewportFraction: 0.92);
  var _activeBannerIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(homeViewModelProvider.notifier).loadInitial();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppStrings.of(context);
    final theme = Theme.of(context);
    final state = ref.watch(homeViewModelProvider);
    final activeBannerIndex = state.banners.isEmpty
        ? 0
        : _activeBannerIndex.clamp(0, state.banners.length - 1);

    return RefreshIndicator(
      onRefresh: ref.read(homeViewModelProvider.notifier).refresh,
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification.metrics.pixels >=
              notification.metrics.maxScrollExtent - 280) {
            ref.read(homeViewModelProvider.notifier).loadMore();
          }
          return false;
        },
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      strings.homeHeadline,
                      style: theme.textTheme.displaySmall,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      strings.homeLead,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (state.isLoading)
              const SliverPadding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 28),
                sliver: _HomeLoadingSliver(),
              )
            else if (state.errorCode != null)
              SliverFillRemaining(
                hasScrollBody: false,
                child: _HomeErrorView(errorCode: state.errorCode!),
              )
            else if (state.isEmpty)
              SliverFillRemaining(
                hasScrollBody: false,
                child: _HomeEmptyView(
                  onRetry: () =>
                      ref.read(homeViewModelProvider.notifier).refresh(),
                ),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 28),
                sliver: SliverList.list(
                  children: [
                    if (state.banners.isNotEmpty) ...[
                      SizedBox(
                        height: 242,
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: state.banners.length,
                          onPageChanged: (index) {
                            setState(() {
                              _activeBannerIndex = index;
                            });
                          },
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(
                                left: index == 0 ? 20 : 8,
                                right: index == state.banners.length - 1
                                    ? 20
                                    : 8,
                              ),
                              child: _BannerCard(
                                banner: state.banners[index],
                                onTap: () =>
                                    _handleBannerTap(state.banners[index]),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 14),
                      _BannerIndicator(
                        count: state.banners.length,
                        activeIndex: activeBannerIndex,
                      ),
                      const SizedBox(height: 24),
                    ],
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              strings.homeFeedTitle,
                              style: theme.textTheme.titleLarge,
                            ),
                          ),
                          Text(
                            strings.homeFeedAction,
                            style: theme.textTheme.labelLarge?.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final width = constraints.maxWidth;
                          final columns = width >= 1100
                              ? 3
                              : width >= 700
                              ? 2
                              : 1;
                          return GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.feedItems.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: columns,
                                  crossAxisSpacing: 16,
                                  mainAxisSpacing: 16,
                                  mainAxisExtent: columns == 1 ? 420 : 388,
                                ),
                            itemBuilder: (context, index) {
                              final item = state.feedItems[index];
                              return _FeedCard(
                                item: item,
                                onTap: () => _showFeedDetails(item),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    if (state.isLoadingMore) ...[
                      const SizedBox(height: 18),
                      const Center(child: CircularProgressIndicator()),
                    ] else if (state.hasMore) ...[
                      const SizedBox(height: 18),
                      Center(
                        child: OutlinedButton(
                          onPressed: () => ref
                              .read(homeViewModelProvider.notifier)
                              .loadMore(),
                          child: Text(strings.loadMoreButton),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleBannerTap(HomeBannerItem banner) async {
    final strings = AppStrings.of(context);
    final link = banner.linkUrl?.trim();
    if (link == null || link.isEmpty) {
      return;
    }

    if (link.startsWith('https://')) {
      final uri = Uri.tryParse(link);
      if (uri == null ||
          !await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        if (!mounted) {
          return;
        }
        _showMessage(strings.homeLinkError);
      }
      return;
    }

    if (link == '/coordinate') {
      context.tabsRouter.setActiveIndex(1);
      return;
    }
    if (link == '/challenge') {
      context.tabsRouter.setActiveIndex(2);
      return;
    }
    if (link == '/notifications') {
      context.tabsRouter.setActiveIndex(3);
      return;
    }
    if (link == '/my-page') {
      context.tabsRouter.setActiveIndex(4);
      return;
    }

    _showMessage(strings.homeLinkUnavailable);
  }

  Future<void> _showFeedDetails(HomeFeedItem item) {
    final strings = AppStrings.of(context);
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.86,
          child: DecoratedBox(
            decoration: const BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
              child: ListView(
                children: [
                  Center(
                    child: Container(
                      width: 44,
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppColors.border,
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(24),
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
                                  size: 40,
                                ),
                              ),
                            ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    item.previewText.isEmpty
                        ? strings.homeFeedMissingPreview
                        : item.previewText,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 18),
                  _MetadataRow(
                    label: strings.homePostedAtLabel,
                    value: _formatDateTime(item.postedAt),
                  ),
                  _MetadataRow(
                    label: strings.homeCreatorLabel,
                    value: item.creatorName?.trim().isNotEmpty == true
                        ? item.creatorName!
                        : strings.defaultUserLabel,
                  ),
                  if (item.viewCount != null)
                    _MetadataRow(
                      label: strings.homeViewsLabel,
                      value: '${item.viewCount}',
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String _formatDateTime(DateTime value) {
    final month = value.month.toString().padLeft(2, '0');
    final day = value.day.toString().padLeft(2, '0');
    final hour = value.hour.toString().padLeft(2, '0');
    final minute = value.minute.toString().padLeft(2, '0');
    return '${value.year}-$month-$day $hour:$minute';
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}

class _BannerCard extends StatelessWidget {
  const _BannerCard({required this.banner, required this.onTap});

  final HomeBannerItem banner;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(28),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            color: AppColors.surface,
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF132238).withValues(alpha: 0.12),
                blurRadius: 32,
                offset: const Offset(0, 18),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(28),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  banner.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const ColoredBox(
                        color: AppColors.softBlue,
                        child: Center(
                          child: Icon(
                            Icons.image_outlined,
                            color: AppColors.primary,
                            size: 42,
                          ),
                        ),
                      ),
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withValues(alpha: 0.02),
                        Colors.black.withValues(alpha: 0.58),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.18),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          AppStrings.of(context).homeBannerChip,
                          style: Theme.of(context).textTheme.labelMedium
                              ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        banner.alt.trim().isEmpty
                            ? AppStrings.of(context).homeBannerFallbackTitle
                            : banner.alt,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BannerIndicator extends StatelessWidget {
  const _BannerIndicator({required this.count, required this.activeIndex});

  final int count;
  final int activeIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var index = 0; index < count; index++)
          AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: index == activeIndex ? 22 : 8,
            height: 8,
            decoration: BoxDecoration(
              color: index == activeIndex
                  ? AppColors.primary
                  : AppColors.border,
              borderRadius: BorderRadius.circular(999),
            ),
          ),
      ],
    );
  }
}

class _FeedCard extends StatelessWidget {
  const _FeedCard({required this.item, required this.onTap});

  final HomeFeedItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final strings = AppStrings.of(context);
    final previewText = item.previewText.isEmpty
        ? strings.homeFeedMissingPreview
        : item.previewText;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(26),
        child: Ink(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(26),
            border: Border.all(color: AppColors.border),
          ),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
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
                                  size: 38,
                                ),
                              ),
                            ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    _AvatarBadge(
                      imageUrl: item.creatorAvatarUrl,
                      fallback: item.creatorName?.trim().isNotEmpty == true
                          ? item.creatorName!
                                .trim()
                                .characters
                                .first
                                .toUpperCase()
                          : strings.defaultUserLabel.characters.first
                                .toUpperCase(),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.creatorName?.trim().isNotEmpty == true
                                ? item.creatorName!
                                : strings.defaultUserLabel,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleSmall
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            _formatDate(item.postedAt),
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: AppColors.textMuted),
                          ),
                        ],
                      ),
                    ),
                    if (item.viewCount != null)
                      _MetricChip(
                        icon: Icons.visibility_outlined,
                        value: '${item.viewCount}',
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  previewText,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textPrimary,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime value) {
    final month = value.month.toString().padLeft(2, '0');
    final day = value.day.toString().padLeft(2, '0');
    return '${value.year}-$month-$day';
  }
}

class _AvatarBadge extends StatelessWidget {
  const _AvatarBadge({required this.imageUrl, required this.fallback});

  final String? imageUrl;
  final String fallback;

  @override
  Widget build(BuildContext context) {
    final trimmedUrl = imageUrl?.trim();
    if (trimmedUrl != null && trimmedUrl.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(999),
        child: Image.network(
          trimmedUrl,
          width: 36,
          height: 36,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) =>
              _FallbackAvatar(fallback: fallback),
        ),
      );
    }

    return _FallbackAvatar(fallback: fallback);
  }
}

class _FallbackAvatar extends StatelessWidget {
  const _FallbackAvatar({required this.fallback});

  final String fallback;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: AppColors.softBlue,
        borderRadius: BorderRadius.circular(999),
      ),
      alignment: Alignment.center,
      child: Text(
        fallback,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
          color: AppColors.primary,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class _MetricChip extends StatelessWidget {
  const _MetricChip({required this.icon, required this.value});

  final IconData icon;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.softBlue,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColors.primary),
          const SizedBox(width: 4),
          Text(
            value,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _HomeLoadingSliver extends StatelessWidget {
  const _HomeLoadingSliver();

  @override
  Widget build(BuildContext context) {
    return SliverList.list(
      children: [
        Container(
          height: 242,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(28),
          ),
        ),
        const SizedBox(height: 14),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            3,
            (_) => Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Wrap(
            runSpacing: 16,
            children: List.generate(
              3,
              (_) => Container(
                height: 388,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(26),
                  border: Border.all(color: AppColors.border),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _HomeErrorView extends StatelessWidget {
  const _HomeErrorView({required this.errorCode});

  final String errorCode;

  @override
  Widget build(BuildContext context) {
    final strings = AppStrings.of(context);
    final isConfigError = errorCode == 'supabase_not_configured';

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
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
                Icon(
                  isConfigError
                      ? Icons.cloud_off_outlined
                      : Icons.error_outline,
                  size: 38,
                  color: AppColors.primary,
                ),
                const SizedBox(height: 14),
                Text(
                  isConfigError
                      ? strings.homeConfigTitle
                      : strings.homeErrorTitle,
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  isConfigError
                      ? strings.homeConfigBody
                      : strings.homeErrorBody,
                  textAlign: TextAlign.center,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: AppColors.textMuted),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HomeEmptyView extends StatelessWidget {
  const _HomeEmptyView({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final strings = AppStrings.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
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
                const Icon(
                  Icons.photo_library_outlined,
                  size: 38,
                  color: AppColors.primary,
                ),
                const SizedBox(height: 14),
                Text(
                  strings.homeEmptyTitle,
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  strings.homeEmptyBody,
                  textAlign: TextAlign.center,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: AppColors.textMuted),
                ),
                const SizedBox(height: 18),
                OutlinedButton(
                  onPressed: onRetry,
                  child: Text(strings.retryButton),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MetadataRow extends StatelessWidget {
  const _MetadataRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 108,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textMuted,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(value, style: Theme.of(context).textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }
}
