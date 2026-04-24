import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/repository/coordinate_repository.dart';
import '../../../services/supabase_service.dart';
import 'coordinate_state.dart';

final coordinateViewModelProvider =
    AutoDisposeNotifierProvider<CoordinateViewModel, CoordinateState>(
      CoordinateViewModel.new,
    );

class CoordinateViewModel extends AutoDisposeNotifier<CoordinateState> {
  static const _pageSize = 20;

  @override
  CoordinateState build() {
    return CoordinateState.initial();
  }

  Future<void> loadInitial() async {
    if (state.isLoading && state.items.isNotEmpty) {
      return;
    }
    state = state.copyWith(
      isLoading: true,
      isLoadingMore: false,
      errorCode: null,
      items: const [],
      hasMore: true,
      requiresAuth: false,
    );
    await _fetchPage(reset: true);
  }

  Future<void> refresh() async {
    state = state.copyWith(
      isLoading: true,
      isLoadingMore: false,
      errorCode: null,
      hasMore: true,
      requiresAuth: false,
    );
    await _fetchPage(reset: true);
  }

  Future<void> loadMore() async {
    if (state.isLoading || state.isLoadingMore || !state.hasMore) {
      return;
    }
    state = state.copyWith(isLoadingMore: true, errorCode: null);
    await _fetchPage(reset: false);
  }

  Future<void> _fetchPage({required bool reset}) async {
    try {
      final service = SupabaseService.instance;
      if (!service.isConfigured) {
        state = state.copyWith(
          isLoading: false,
          isLoadingMore: false,
          errorCode: 'supabase_not_configured',
          hasMore: false,
        );
        return;
      }

      final userId = service.client.auth.currentUser?.id;
      if (userId == null || userId.isEmpty) {
        state = state.copyWith(
          items: const [],
          isLoading: false,
          isLoadingMore: false,
          requiresAuth: true,
          errorCode: null,
          hasMore: false,
        );
        return;
      }

      final offset = reset ? 0 : state.items.length;
      final nextItems = await ref
          .read(coordinateRepositoryProvider)
          .listCoordinateItems(
            userId: userId,
            limit: _pageSize,
            offset: offset,
          );

      final mergedItems = reset ? nextItems : [...state.items, ...nextItems];
      state = state.copyWith(
        items: mergedItems,
        isLoading: false,
        isLoadingMore: false,
        hasMore: nextItems.length == _pageSize,
        requiresAuth: false,
        errorCode: null,
      );
    } catch (_) {
      state = state.copyWith(
        isLoading: false,
        isLoadingMore: false,
        errorCode: 'coordinate_fetch_failed',
      );
    }
  }
}
