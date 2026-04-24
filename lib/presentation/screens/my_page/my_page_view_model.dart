import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/models/my_page_balance.dart';
import '../../../core/models/my_page_image_item.dart';
import '../../../core/models/my_page_profile.dart';
import '../../../core/models/my_page_stats.dart';
import '../../../presentation/providers/auth_session_provider.dart';
import '../../../presentation/providers/my_page_provider.dart';
import '../../../services/supabase_my_page_repository.dart';
import 'my_page_state.dart';

final myPageViewModelProvider =
    AutoDisposeNotifierProvider<MyPageViewModel, MyPageState>(
      MyPageViewModel.new,
    );

class MyPageViewModel extends AutoDisposeNotifier<MyPageState> {
  static const _pageSize = 20;

  @override
  MyPageState build() {
    return MyPageState.initial();
  }

  Future<void> loadInitial() async {
    final userId = _userIdOrNull();
    if (userId == null || userId.isEmpty) {
      state = state.copyWith(
        isLoadingInitial: false,
        isRefreshing: false,
        isLoadingMoreImages: false,
        hasMoreImages: false,
        errorCode: 'unauthorized',
      );
      return;
    }

    state = state.copyWith(
      isLoadingInitial: true,
      isRefreshing: false,
      isLoadingMoreImages: false,
      hasMoreImages: true,
      errorCode: null,
      profileErrorCode: null,
      statsErrorCode: null,
      balanceErrorCode: null,
      imagesErrorCode: null,
      images: const [],
    );

    await _loadAllSections(userId: userId, resetImages: true);
  }

  Future<void> refresh() async {
    final userId = _userIdOrNull();
    if (userId == null || userId.isEmpty) {
      state = state.copyWith(errorCode: 'unauthorized');
      return;
    }

    state = state.copyWith(
      isRefreshing: true,
      errorCode: null,
      profileErrorCode: null,
      statsErrorCode: null,
      balanceErrorCode: null,
      imagesErrorCode: null,
      hasMoreImages: true,
    );

    await _loadAllSections(userId: userId, resetImages: true);
  }

  Future<void> loadMoreImages() async {
    if (state.isLoadingInitial || state.isRefreshing || state.isLoadingMoreImages) {
      return;
    }
    if (!state.hasMoreImages) {
      return;
    }
    final userId = _userIdOrNull();
    if (userId == null || userId.isEmpty) {
      return;
    }

    state = state.copyWith(isLoadingMoreImages: true, imagesErrorCode: null);
    try {
      final items = await ref
          .read(myPageRepositoryProvider)
          .listMyImages(
            userId: userId,
            offset: state.images.length,
            limit: _pageSize,
          );
      state = state.copyWith(
        isLoadingMoreImages: false,
        images: [...state.images, ...items],
        hasMoreImages: items.length == _pageSize,
        imagesErrorCode: null,
      );
    } on MyPageRepositoryException catch (error) {
      state = state.copyWith(
        isLoadingMoreImages: false,
        imagesErrorCode: error.code,
      );
    } catch (_) {
      state = state.copyWith(
        isLoadingMoreImages: false,
        imagesErrorCode: 'my_page_images_failed',
      );
    }
  }

  void clearError() {
    state = state.copyWith(
      errorCode: null,
      profileErrorCode: null,
      statsErrorCode: null,
      balanceErrorCode: null,
      imagesErrorCode: null,
    );
  }

  Future<void> _loadAllSections({
    required String userId,
    required bool resetImages,
  }) async {
    MyPageProfile? profile;
    MyPageStats? stats;
    MyPageBalance? balance;
    List<MyPageImageItem> images = state.images;
    String? profileErrorCode;
    String? statsErrorCode;
    String? balanceErrorCode;
    String? imagesErrorCode;

    try {
      profile = await ref.read(myPageRepositoryProvider).getMyProfile(userId: userId);
    } on MyPageRepositoryException catch (error) {
      profileErrorCode = error.code;
    } catch (_) {
      profileErrorCode = 'my_page_profile_failed';
    }

    try {
      stats = await ref.read(myPageRepositoryProvider).getMyStats(userId: userId);
    } on MyPageRepositoryException catch (error) {
      statsErrorCode = error.code;
    } catch (_) {
      statsErrorCode = 'my_page_stats_failed';
    }

    try {
      balance = await ref.read(myPageRepositoryProvider).getMyBalance(userId: userId);
    } on MyPageRepositoryException catch (error) {
      balanceErrorCode = error.code;
    } catch (_) {
      balanceErrorCode = 'my_page_balance_failed';
    }

    try {
      images = await ref
          .read(myPageRepositoryProvider)
          .listMyImages(
            userId: userId,
            offset: resetImages ? 0 : images.length,
            limit: _pageSize,
          );
    } on MyPageRepositoryException catch (error) {
      imagesErrorCode = error.code;
    } catch (_) {
      imagesErrorCode = 'my_page_images_failed';
    }

    final hasBlockingError =
        profile == null &&
        stats == null &&
        balance == null &&
        images.isEmpty &&
        (profileErrorCode != null ||
            statsErrorCode != null ||
            balanceErrorCode != null ||
            imagesErrorCode != null);

    state = state.copyWith(
      profile: profile ?? state.profile,
      stats: stats ?? state.stats,
      balance: balance ?? state.balance,
      images: images,
      isLoadingInitial: false,
      isRefreshing: false,
      isLoadingMoreImages: false,
      hasMoreImages: images.length == _pageSize,
      errorCode: hasBlockingError ? 'my_page_fetch_failed' : null,
      profileErrorCode: profileErrorCode,
      statsErrorCode: statsErrorCode,
      balanceErrorCode: balanceErrorCode,
      imagesErrorCode: imagesErrorCode,
    );
  }

  String? _userIdOrNull() {
    return ref.read(authSessionProvider).valueOrNull?.userId?.trim();
  }
}
