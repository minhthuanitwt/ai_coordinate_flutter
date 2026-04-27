import 'package:flutter/material.dart';

import '../../../../domain/models/coordinate_item.dart';
import '../../../../i18n/strings.g.dart';
import '../coordinate_state.dart';

class CoordinateGallerySection extends StatelessWidget {
  const CoordinateGallerySection({
    required this.state,
    required this.onLoadMore,
    required this.onRetry,
    required this.title,
    super.key,
  });

  final CoordinateState state;
  final VoidCallback onLoadMore;
  final VoidCallback onRetry;
  final String title;

  @override
  Widget build(BuildContext context) {
    if (state.isLoadingInitial) {
      return const SliverFillRemaining(
        hasScrollBody: false,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (state.errorCode != null) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(context.t.coordinate.error_history_failed),
                const SizedBox(height: 12),
                FilledButton(
                  onPressed: onRetry,
                  child: Text(context.t.common.retry_button),
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (state.items.isEmpty) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: Center(child: Text(context.t.coordinate.empty_results)),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 28),
      sliver: SliverList.list(
        children: [
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 10),
          GridView.builder(
            itemCount: state.items.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              mainAxisExtent: 252,
            ),
            itemBuilder: (context, index) =>
                _GalleryCard(item: state.items[index]),
          ),
          if (state.isLoadingMore) ...[
            const SizedBox(height: 10),
            const Center(child: CircularProgressIndicator()),
          ] else if (state.hasMore) ...[
            const SizedBox(height: 10),
            Center(
              child: OutlinedButton(
                onPressed: onLoadMore,
                child: Text(context.t.common.load_more_button),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _GalleryCard extends StatelessWidget {
  const _GalleryCard({required this.item});

  final CoordinateItem item;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image.network(
              item.imageUrl,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const ColoredBox(
                color: Color(0xFFE6EAF0),
                child: Center(child: Icon(Icons.broken_image_outlined)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 6, 8, 8),
            child: Text(
              item.prompt.isEmpty
                  ? context.t.coordinate.prompt_missing_fallback
                  : item.prompt,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}
