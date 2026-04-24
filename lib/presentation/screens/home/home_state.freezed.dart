// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$HomeState {
  List<HomeBannerItem> get banners => throw _privateConstructorUsedError;
  List<HomeFeedItem> get feedItems => throw _privateConstructorUsedError;
  HomeFeedFilter get currentFilter => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isLoadingMore => throw _privateConstructorUsedError;
  bool get hasMore => throw _privateConstructorUsedError;
  String? get errorCode => throw _privateConstructorUsedError;

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HomeStateCopyWith<HomeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeStateCopyWith<$Res> {
  factory $HomeStateCopyWith(HomeState value, $Res Function(HomeState) then) =
      _$HomeStateCopyWithImpl<$Res, HomeState>;
  @useResult
  $Res call({
    List<HomeBannerItem> banners,
    List<HomeFeedItem> feedItems,
    HomeFeedFilter currentFilter,
    bool isLoading,
    bool isLoadingMore,
    bool hasMore,
    String? errorCode,
  });
}

/// @nodoc
class _$HomeStateCopyWithImpl<$Res, $Val extends HomeState>
    implements $HomeStateCopyWith<$Res> {
  _$HomeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? banners = null,
    Object? feedItems = null,
    Object? currentFilter = null,
    Object? isLoading = null,
    Object? isLoadingMore = null,
    Object? hasMore = null,
    Object? errorCode = freezed,
  }) {
    return _then(
      _value.copyWith(
            banners: null == banners
                ? _value.banners
                : banners // ignore: cast_nullable_to_non_nullable
                      as List<HomeBannerItem>,
            feedItems: null == feedItems
                ? _value.feedItems
                : feedItems // ignore: cast_nullable_to_non_nullable
                      as List<HomeFeedItem>,
            currentFilter: null == currentFilter
                ? _value.currentFilter
                : currentFilter // ignore: cast_nullable_to_non_nullable
                      as HomeFeedFilter,
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            isLoadingMore: null == isLoadingMore
                ? _value.isLoadingMore
                : isLoadingMore // ignore: cast_nullable_to_non_nullable
                      as bool,
            hasMore: null == hasMore
                ? _value.hasMore
                : hasMore // ignore: cast_nullable_to_non_nullable
                      as bool,
            errorCode: freezed == errorCode
                ? _value.errorCode
                : errorCode // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$HomeStateImplCopyWith<$Res>
    implements $HomeStateCopyWith<$Res> {
  factory _$$HomeStateImplCopyWith(
    _$HomeStateImpl value,
    $Res Function(_$HomeStateImpl) then,
  ) = __$$HomeStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<HomeBannerItem> banners,
    List<HomeFeedItem> feedItems,
    HomeFeedFilter currentFilter,
    bool isLoading,
    bool isLoadingMore,
    bool hasMore,
    String? errorCode,
  });
}

/// @nodoc
class __$$HomeStateImplCopyWithImpl<$Res>
    extends _$HomeStateCopyWithImpl<$Res, _$HomeStateImpl>
    implements _$$HomeStateImplCopyWith<$Res> {
  __$$HomeStateImplCopyWithImpl(
    _$HomeStateImpl _value,
    $Res Function(_$HomeStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? banners = null,
    Object? feedItems = null,
    Object? currentFilter = null,
    Object? isLoading = null,
    Object? isLoadingMore = null,
    Object? hasMore = null,
    Object? errorCode = freezed,
  }) {
    return _then(
      _$HomeStateImpl(
        banners: null == banners
            ? _value._banners
            : banners // ignore: cast_nullable_to_non_nullable
                  as List<HomeBannerItem>,
        feedItems: null == feedItems
            ? _value._feedItems
            : feedItems // ignore: cast_nullable_to_non_nullable
                  as List<HomeFeedItem>,
        currentFilter: null == currentFilter
            ? _value.currentFilter
            : currentFilter // ignore: cast_nullable_to_non_nullable
                  as HomeFeedFilter,
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        isLoadingMore: null == isLoadingMore
            ? _value.isLoadingMore
            : isLoadingMore // ignore: cast_nullable_to_non_nullable
                  as bool,
        hasMore: null == hasMore
            ? _value.hasMore
            : hasMore // ignore: cast_nullable_to_non_nullable
                  as bool,
        errorCode: freezed == errorCode
            ? _value.errorCode
            : errorCode // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$HomeStateImpl extends _HomeState {
  const _$HomeStateImpl({
    required final List<HomeBannerItem> banners,
    required final List<HomeFeedItem> feedItems,
    required this.currentFilter,
    required this.isLoading,
    required this.isLoadingMore,
    required this.hasMore,
    this.errorCode,
  }) : _banners = banners,
       _feedItems = feedItems,
       super._();

  final List<HomeBannerItem> _banners;
  @override
  List<HomeBannerItem> get banners {
    if (_banners is EqualUnmodifiableListView) return _banners;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_banners);
  }

  final List<HomeFeedItem> _feedItems;
  @override
  List<HomeFeedItem> get feedItems {
    if (_feedItems is EqualUnmodifiableListView) return _feedItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_feedItems);
  }

  @override
  final HomeFeedFilter currentFilter;
  @override
  final bool isLoading;
  @override
  final bool isLoadingMore;
  @override
  final bool hasMore;
  @override
  final String? errorCode;

  @override
  String toString() {
    return 'HomeState(banners: $banners, feedItems: $feedItems, currentFilter: $currentFilter, isLoading: $isLoading, isLoadingMore: $isLoadingMore, hasMore: $hasMore, errorCode: $errorCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeStateImpl &&
            const DeepCollectionEquality().equals(other._banners, _banners) &&
            const DeepCollectionEquality().equals(
              other._feedItems,
              _feedItems,
            ) &&
            (identical(other.currentFilter, currentFilter) ||
                other.currentFilter == currentFilter) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isLoadingMore, isLoadingMore) ||
                other.isLoadingMore == isLoadingMore) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore) &&
            (identical(other.errorCode, errorCode) ||
                other.errorCode == errorCode));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_banners),
    const DeepCollectionEquality().hash(_feedItems),
    currentFilter,
    isLoading,
    isLoadingMore,
    hasMore,
    errorCode,
  );

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeStateImplCopyWith<_$HomeStateImpl> get copyWith =>
      __$$HomeStateImplCopyWithImpl<_$HomeStateImpl>(this, _$identity);
}

abstract class _HomeState extends HomeState {
  const factory _HomeState({
    required final List<HomeBannerItem> banners,
    required final List<HomeFeedItem> feedItems,
    required final HomeFeedFilter currentFilter,
    required final bool isLoading,
    required final bool isLoadingMore,
    required final bool hasMore,
    final String? errorCode,
  }) = _$HomeStateImpl;
  const _HomeState._() : super._();

  @override
  List<HomeBannerItem> get banners;
  @override
  List<HomeFeedItem> get feedItems;
  @override
  HomeFeedFilter get currentFilter;
  @override
  bool get isLoading;
  @override
  bool get isLoadingMore;
  @override
  bool get hasMore;
  @override
  String? get errorCode;

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HomeStateImplCopyWith<_$HomeStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
