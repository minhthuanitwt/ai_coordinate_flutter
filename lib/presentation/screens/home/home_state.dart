import '../../../core/models/home_banner_item.dart';
import '../../../core/models/home_feed_item.dart';
import '../../../services/supabase_service.dart';

enum HomeFeedFilter { newest, recommended, following }

class HomeState {
  const HomeState({
    required this.banners,
    required this.feedItems,
    required this.currentFilter,
    required this.isLoading,
    required this.isLoadingMore,
    required this.hasMore,
    this.errorCode,
  });

  const HomeState.initial()
    : banners = const [],
      feedItems = const [],
      currentFilter = HomeFeedFilter.newest,
      isLoading = true,
      isLoadingMore = false,
      hasMore = true,
      errorCode = null;

  final List<HomeBannerItem> banners;
  final List<HomeFeedItem> feedItems;
  final HomeFeedFilter currentFilter;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final String? errorCode;

  bool get isConfigured => SupabaseService.instance.isConfigured;

  bool get isEmpty => banners.isEmpty && feedItems.isEmpty;

  bool get isFilterEmpty => feedItems.isNotEmpty && filteredFeedItems.isEmpty;

  List<HomeFeedItem> get filteredFeedItems {
    switch (currentFilter) {
      case HomeFeedFilter.newest:
        final items = [...feedItems];
        items.sort((a, b) => b.postedAt.compareTo(a.postedAt));
        return items;
      case HomeFeedFilter.recommended:
        final items = [...feedItems];
        items.sort((a, b) {
          final scoreA =
              (a.viewCount ?? 0) * 10 + (a.likeCount ?? 0) * 4 + (a.commentCount ?? 0) * 2;
          final scoreB =
              (b.viewCount ?? 0) * 10 + (b.likeCount ?? 0) * 4 + (b.commentCount ?? 0) * 2;
          if (scoreA != scoreB) {
            return scoreB.compareTo(scoreA);
          }
          return b.postedAt.compareTo(a.postedAt);
        });
        return items;
      case HomeFeedFilter.following:
        final followingIds = feedItems
            .map((item) => item.userId?.trim())
            .whereType<String>()
            .where((id) => id.isNotEmpty)
            .toSet()
            .take(4)
            .toSet();
        if (followingIds.isEmpty) {
          return const [];
        }
        final items = feedItems
            .where((item) => followingIds.contains(item.userId))
            .toList();
        items.sort((a, b) => b.postedAt.compareTo(a.postedAt));
        return items;
    }
  }

  HomeState copyWith({
    List<HomeBannerItem>? banners,
    List<HomeFeedItem>? feedItems,
    HomeFeedFilter? currentFilter,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    String? errorCode,
    bool clearError = false,
  }) {
    return HomeState(
      banners: banners ?? this.banners,
      feedItems: feedItems ?? this.feedItems,
      currentFilter: currentFilter ?? this.currentFilter,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      errorCode: clearError ? null : errorCode ?? this.errorCode,
    );
  }
}
