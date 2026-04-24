import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/models/home_banner_item.dart';
import '../../../core/models/home_feed_item.dart';
import '../../../services/supabase_service.dart';

part 'home_state.freezed.dart';

enum HomeFeedFilter { newest, recommended, following }

@freezed
class HomeState with _$HomeState {
  const HomeState._();

  const factory HomeState({
    required List<HomeBannerItem> banners,
    required List<HomeFeedItem> feedItems,
    required HomeFeedFilter currentFilter,
    required bool isLoading,
    required bool isLoadingMore,
    required bool hasMore,
    String? errorCode,
  }) = _HomeState;

  factory HomeState.initial() => const HomeState(
    banners: [],
    feedItems: [],
    currentFilter: HomeFeedFilter.newest,
    isLoading: true,
    isLoadingMore: false,
    hasMore: true,
    errorCode: null,
  );

  bool get isConfigured => SupabaseService.instance.isConfigured;

  bool get isEmpty => banners.isEmpty && feedItems.isEmpty;

  bool get isFilterEmpty =>
      !isLoading && currentFilter != HomeFeedFilter.newest && feedItems.isEmpty;
}
