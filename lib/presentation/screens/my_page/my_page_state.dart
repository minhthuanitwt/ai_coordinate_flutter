import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/models/my_page_balance.dart';
import '../../../core/models/my_page_image_item.dart';
import '../../../core/models/my_page_profile.dart';
import '../../../core/models/my_page_stats.dart';
import '../../../services/supabase_service.dart';

part 'my_page_state.freezed.dart';

@freezed
class MyPageState with _$MyPageState {
  const MyPageState._();

  const factory MyPageState({
    MyPageProfile? profile,
    MyPageStats? stats,
    MyPageBalance? balance,
    required List<MyPageImageItem> images,
    required bool isLoadingInitial,
    required bool isRefreshing,
    required bool isLoadingMoreImages,
    required bool hasMoreImages,
    String? errorCode,
    String? profileErrorCode,
    String? statsErrorCode,
    String? balanceErrorCode,
    String? imagesErrorCode,
  }) = _MyPageState;

  factory MyPageState.initial() => const MyPageState(
    images: [],
    isLoadingInitial: true,
    isRefreshing: false,
    isLoadingMoreImages: false,
    hasMoreImages: true,
    errorCode: null,
    profileErrorCode: null,
    statsErrorCode: null,
    balanceErrorCode: null,
    imagesErrorCode: null,
  );

  bool get isConfigured => SupabaseService.instance.isConfigured;

  bool get hasAnyData =>
      profile != null || stats != null || balance != null || images.isNotEmpty;

  bool get isGalleryEmpty =>
      !isLoadingInitial && imagesErrorCode == null && images.isEmpty;
}
