import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/models/coordinate_item.dart';
import '../../../services/supabase_service.dart';

part 'coordinate_state.freezed.dart';

@freezed
class CoordinateState with _$CoordinateState {
  const CoordinateState._();

  const factory CoordinateState({
    required List<CoordinateItem> items,
    required bool isLoading,
    required bool isLoadingMore,
    required bool hasMore,
    required bool requiresAuth,
    String? errorCode,
  }) = _CoordinateState;

  factory CoordinateState.initial() => const CoordinateState(
    items: [],
    isLoading: true,
    isLoadingMore: false,
    hasMore: true,
    requiresAuth: false,
    errorCode: null,
  );

  bool get isConfigured => SupabaseService.instance.isConfigured;
}
