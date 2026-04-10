import '../../../core/models/home_banner_item.dart';
import '../../../core/models/home_feed_item.dart';
import '../../../services/supabase_service.dart';

class HomeState {
  const HomeState({
    required this.banners,
    required this.feedItems,
    required this.isLoading,
    required this.isLoadingMore,
    required this.hasMore,
    this.errorCode,
  });

  const HomeState.initial()
    : banners = const [],
      feedItems = const [],
      isLoading = true,
      isLoadingMore = false,
      hasMore = true,
      errorCode = null;

  final List<HomeBannerItem> banners;
  final List<HomeFeedItem> feedItems;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final String? errorCode;

  bool get isConfigured => SupabaseService.instance.isConfigured;

  bool get isEmpty => banners.isEmpty && feedItems.isEmpty;

  HomeState copyWith({
    List<HomeBannerItem>? banners,
    List<HomeFeedItem>? feedItems,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    String? errorCode,
    bool clearError = false,
  }) {
    return HomeState(
      banners: banners ?? this.banners,
      feedItems: feedItems ?? this.feedItems,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      errorCode: clearError ? null : errorCode ?? this.errorCode,
    );
  }
}
