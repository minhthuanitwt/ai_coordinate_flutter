import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/models/home_banner_item.dart';
import '../../../core/models/home_feed_item.dart';
import '../../../domain/repository/home_repository.dart';
import '../../providers/auth_session_provider.dart';
import '../../../services/supabase_service.dart';
import 'home_state.dart';

final homeViewModelProvider =
    AutoDisposeNotifierProvider<HomeViewModel, HomeState>(HomeViewModel.new);

class HomeViewModel extends AutoDisposeNotifier<HomeState> {
  static const _pageSize = 20;

  @override
  HomeState build() {
    return HomeState.initial();
  }

  Future<void> loadInitial() async {
    state = state.copyWith(
      banners: const [],
      feedItems: const [],
      isLoading: true,
      isLoadingMore: false,
      hasMore: true,
      errorCode: null,
    );
    await _fetch(reset: true);
  }

  Future<void> refresh() async {
    state = state.copyWith(
      isLoading: true,
      isLoadingMore: false,
      hasMore: true,
      errorCode: null,
    );
    await _fetch(reset: true);
  }

  Future<void> loadMore() async {
    if (state.isLoading || state.isLoadingMore || !state.hasMore) {
      return;
    }

    state = state.copyWith(isLoadingMore: true, errorCode: null);
    await _fetch(reset: false);
  }

  Future<void> updateFilter(HomeFeedFilter filter) async {
    if (state.currentFilter == filter) {
      return;
    }
    state = state.copyWith(
      currentFilter: filter,
      isLoading: false,
      isLoadingMore: true,
      hasMore: true,
      errorCode: null,
    );
    await _fetch(reset: true, reloadBanners: false);
  }

  Future<void> _fetch({required bool reset, bool reloadBanners = true}) async {
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
      final sort = switch (state.currentFilter) {
        HomeFeedFilter.newest => HomeFeedSort.newest,
        HomeFeedFilter.recommended => HomeFeedSort.recommended,
        HomeFeedFilter.following => HomeFeedSort.following,
      };
      final viewerUserId =
          ref.read(authSessionProvider).valueOrNull?.userId?.trim();

      final results = await Future.wait([
        if (reloadBanners)
          repository.listHomeBanners()
        else
          Future.value(state.banners),
        repository.listHomeFeedItems(
          limit: _pageSize,
          offset: offset,
          sort: sort,
          viewerUserId: viewerUserId,
        ),
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
        errorCode: null,
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
