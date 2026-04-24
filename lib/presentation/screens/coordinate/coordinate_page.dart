import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/models/coordinate_item.dart';
import '../../../i18n/strings.g.dart';
import '../../../themes/app_colors.dart';
import 'coordinate_view_model.dart';

@RoutePage()
class CoordinatePage extends ConsumerStatefulWidget {
  const CoordinatePage({super.key});

  @override
  ConsumerState<CoordinatePage> createState() => _CoordinatePageState();
}

class _CoordinatePageState extends ConsumerState<CoordinatePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(coordinateViewModelProvider.notifier).loadInitial();
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;

    final state = ref.watch(coordinateViewModelProvider);

    return RefreshIndicator(
      onRefresh: ref.read(coordinateViewModelProvider.notifier).refresh,
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification.metrics.pixels >=
              notification.metrics.maxScrollExtent - 280) {
            ref.read(coordinateViewModelProvider.notifier).loadMore();
          }
          return false;
        },
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.coordinate.board_title,
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      t.coordinate.board_subtitle,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (state.isLoading)
              const SliverPadding(
                padding: EdgeInsets.fromLTRB(20, 4, 20, 24),
                sliver: _CoordinateSkeletonGrid(),
              )
            else if (state.errorCode != null)
              SliverFillRemaining(
                hasScrollBody: false,
                child: _CoordinateErrorView(errorCode: state.errorCode!),
              )
            else if (state.items.isEmpty)
              SliverFillRemaining(
                hasScrollBody: false,
                child: _CoordinateEmptyView(
                  onRetry: () =>
                      ref.read(coordinateViewModelProvider.notifier).refresh(),
                ),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 4, 20, 28),
                sliver: SliverList.list(
                  children: [
                    _CoordinateSummary(count: state.items.length),
                    const SizedBox(height: 18),
                    LayoutBuilder(
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
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: columns,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                                mainAxisExtent: 324,
                              ),
                          itemCount: state.items.length,
                          itemBuilder: (context, index) {
                            final item = state.items[index];
                            return _CoordinateCard(
                              item: item,
                              onTap: () =>
                                  _showCoordinateDetails(context, item),
                            );
                          },
                        );
                      },
                    ),
                    if (state.isLoadingMore) ...[
                      const SizedBox(height: 18),
                      const Center(child: CircularProgressIndicator()),
                    ] else if (state.hasMore) ...[
                      const SizedBox(height: 18),
                      Center(
                        child: OutlinedButton(
                          onPressed: () => ref
                              .read(coordinateViewModelProvider.notifier)
                              .loadMore(),
                          child: Text(t.common.load_more_button),
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

  Future<void> _showCoordinateDetails(
    BuildContext context,
    CoordinateItem item,
  ) {
    final t = context.t;
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.84,
          child: DecoratedBox(
            decoration: const BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
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
                            const DecoratedBox(
                              decoration: BoxDecoration(
                                color: AppColors.softBlue,
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.image_not_supported_outlined,
                                  color: AppColors.primary,
                                  size: 36,
                                ),
                              ),
                            ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _TagChip(
                        label: item.isPosted
                            ? t.coordinate.posted_badge
                            : t.coordinate.draft_badge,
                        background: item.isPosted
                            ? AppColors.softGreen
                            : AppColors.softBlue,
                        foreground: item.isPosted
                            ? AppColors.success
                            : AppColors.primary,
                      ),
                      _TagChip(
                        label: item.generationType,
                        background: const Color(0xFFFFF0E5),
                        foreground: const Color(0xFFD76A18),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Text(
                    t.coordinate.prompt_label,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item.prompt.isEmpty
                        ? t.coordinate.missing_prompt
                        : item.prompt,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(color: AppColors.textMuted),
                  ),
                  const SizedBox(height: 18),
                  _MetadataRow(
                    label: t.coordinate.created_at_label,
                    value: _formatDateTime(context, item.createdAt),
                  ),
                  if (item.model != null && item.model!.isNotEmpty)
                    _MetadataRow(
                      label: t.coordinate.model_label,
                      value: item.model!,
                    ),
                  if (item.sourceImageStockId != null &&
                      item.sourceImageStockId!.isNotEmpty)
                    _MetadataRow(
                      label: t.coordinate.source_label,
                      value: item.sourceImageStockId!,
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String _formatDateTime(BuildContext context, DateTime value) {
    final date =
        '${value.year.toString().padLeft(4, '0')}-'
        '${value.month.toString().padLeft(2, '0')}-'
        '${value.day.toString().padLeft(2, '0')}';
    final time =
        '${value.hour.toString().padLeft(2, '0')}:'
        '${value.minute.toString().padLeft(2, '0')}';
    return '$date $time';
  }
}

class _CoordinateSummary extends StatelessWidget {
  const _CoordinateSummary({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: AppColors.softBlue,
              child: const Icon(Icons.auto_awesome, color: AppColors.primary),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t.coordinate.summary_title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${t.coordinate.summary_count_prefix}: $count',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CoordinateCard extends StatelessWidget {
  const _CoordinateCard({required this.item, required this.onTap});

  final CoordinateItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final dateText =
        '${item.createdAt.year.toString().padLeft(4, '0')}-'
        '${item.createdAt.month.toString().padLeft(2, '0')}-'
        '${item.createdAt.day.toString().padLeft(2, '0')}';

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Ink(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        item.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const DecoratedBox(
                              decoration: BoxDecoration(
                                color: AppColors.softBlue,
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.image_not_supported_outlined,
                                  color: AppColors.primary,
                                  size: 32,
                                ),
                              ),
                            ),
                      ),
                      Positioned(
                        top: 12,
                        left: 12,
                        child: _TagChip(
                          label: item.isPosted
                              ? t.coordinate.posted_badge
                              : t.coordinate.draft_badge,
                          background: Colors.black.withValues(alpha: 0.58),
                          foreground: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.prompt.isEmpty
                          ? t.coordinate.missing_prompt
                          : item.prompt,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      dateText,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CoordinateSkeletonGrid extends StatelessWidget {
  const _CoordinateSkeletonGrid();

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, index) => DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFFE7EDF6),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Container(height: 16, color: const Color(0xFFE7EDF6)),
                    const SizedBox(height: 10),
                    Container(height: 12, color: const Color(0xFFE7EDF6)),
                  ],
                ),
              ),
            ],
          ),
        ),
        childCount: 6,
      ),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 360,
        mainAxisExtent: 324,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
      ),
    );
  }
}

class _CoordinateEmptyView extends StatelessWidget {
  const _CoordinateEmptyView({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    return Center(
      child: Padding(
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
                    child: Icon(
                      Icons.photo_library_outlined,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    t.coordinate.empty_title,
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    t.coordinate.empty_body,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(color: AppColors.textMuted),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 18),
                  OutlinedButton(
                    onPressed: onRetry,
                    child: Text(t.common.retry_button),
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

class _CoordinateErrorView extends ConsumerWidget {
  const _CoordinateErrorView({required this.errorCode});

  final String errorCode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;
    final isConfigIssue = errorCode == 'supabase_not_configured';
    final title = isConfigIssue
        ? t.coordinate.config_title
        : t.coordinate.error_title;
    final body = isConfigIssue
        ? t.coordinate.config_body
        : t.coordinate.error_body;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 460),
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
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: const Color(0xFFFFF0E5),
                    child: Icon(
                      isConfigIssue
                          ? Icons.settings_ethernet_outlined
                          : Icons.warning_amber_rounded,
                      color: const Color(0xFFD76A18),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    body,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(color: AppColors.textMuted),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 18),
                  FilledButton.tonal(
                    onPressed: () => ref
                        .read(coordinateViewModelProvider.notifier)
                        .loadInitial(),
                    child: Text(t.common.retry_button),
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
            width: 132,
            child: Text(
              label,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.textMuted),
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

class _TagChip extends StatelessWidget {
  const _TagChip({
    required this.label,
    required this.background,
    required this.foreground,
  });

  final String label;
  final Color background;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: foreground,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
