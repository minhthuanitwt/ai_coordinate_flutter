import '../../../core/models/coordinate_item.dart';
import '../../../services/supabase_service.dart';

class CoordinateState {
  const CoordinateState({
    required this.items,
    required this.isLoading,
    required this.isLoadingMore,
    required this.hasMore,
    this.errorCode,
  });

  const CoordinateState.initial()
    : items = const [],
      isLoading = true,
      isLoadingMore = false,
      hasMore = true,
      errorCode = null;

  final List<CoordinateItem> items;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final String? errorCode;

  bool get isConfigured => SupabaseService.instance.isConfigured;

  CoordinateState copyWith({
    List<CoordinateItem>? items,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    String? errorCode,
    bool clearError = false,
  }) {
    return CoordinateState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      errorCode: clearError ? null : errorCode ?? this.errorCode,
    );
  }
}
