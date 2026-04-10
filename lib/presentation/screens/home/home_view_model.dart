import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/models/home_banner_item.dart';
import '../../../core/models/home_feed_item.dart';
import '../../../services/supabase_home_repository.dart';
import '../../../services/supabase_service.dart';
import 'home_state.dart';

final homeViewModelProvider =
    AutoDisposeNotifierProvider<HomeViewModel, HomeState>(HomeViewModel.new);

class HomeViewModel extends AutoDisposeNotifier<HomeState> {
  static const _pageSize = 20;

  @override
  HomeState build() {
    return const HomeState.initial();
  }

  Future<void> loadInitial() async {
    state = state.copyWith(
      banners: const [],
      feedItems: const [],
      isLoading: true,
      isLoadingMore: false,
      hasMore: true,
      clearError: true,
    );
    await _fetch(reset: true);
  }

  Future<void> refresh() async {
    state = state.copyWith(
      isLoading: true,
      isLoadingMore: false,
      hasMore: true,
      clearError: true,
    );
    await _fetch(reset: true);
  }

  Future<void> loadMore() async {
    if (state.isLoading || state.isLoadingMore || !state.hasMore) {
      return;
    }

    state = state.copyWith(isLoadingMore: true, clearError: true);
    await _fetch(reset: false);
  }

  Future<void> _fetch({required bool reset}) async {
    try {
      if (!SupabaseService.instance.isConfigured) {
        state = state.copyWith(
          isLoading: false,
          isLoadingMore: false,
          hasMore: false,
          errorCode: 'supabase_not_configured',
        );
        return;
      }

      final repository = ref.read(homeRepositoryProvider);
      final offset = reset ? 0 : state.feedItems.length;

      final results = await Future.wait([
        if (reset)
          repository.listHomeBanners()
        else
          Future.value(state.banners),
        repository.listHomeFeedItems(limit: _pageSize, offset: offset),
      ]);

      final banners = results[0] as List<HomeBannerItem>;
      final nextFeedItems = results[1] as List<HomeFeedItem>;
      final mergedFeedItems = reset
          ? nextFeedItems
          : [...state.feedItems, ...nextFeedItems];

      state = state.copyWith(
        banners: banners,
        feedItems: mergedFeedItems,
        isLoading: false,
        isLoadingMore: false,
        hasMore: nextFeedItems.length == _pageSize,
        clearError: true,
      );
    } catch (_) {
      state = state.copyWith(
        isLoading: false,
        isLoadingMore: false,
        hasMore: false,
        errorCode: 'home_fetch_failed',
      );
    }
  }
}
