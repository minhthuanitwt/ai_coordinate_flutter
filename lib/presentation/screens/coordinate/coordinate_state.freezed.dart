// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'coordinate_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$CoordinateState {
  List<CoordinateItem> get items => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isLoadingMore => throw _privateConstructorUsedError;
  bool get hasMore => throw _privateConstructorUsedError;
  bool get requiresAuth => throw _privateConstructorUsedError;
  String? get errorCode => throw _privateConstructorUsedError;

  /// Create a copy of CoordinateState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CoordinateStateCopyWith<CoordinateState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CoordinateStateCopyWith<$Res> {
  factory $CoordinateStateCopyWith(
    CoordinateState value,
    $Res Function(CoordinateState) then,
  ) = _$CoordinateStateCopyWithImpl<$Res, CoordinateState>;
  @useResult
  $Res call({
    List<CoordinateItem> items,
    bool isLoading,
    bool isLoadingMore,
    bool hasMore,
    bool requiresAuth,
    String? errorCode,
  });
}

/// @nodoc
class _$CoordinateStateCopyWithImpl<$Res, $Val extends CoordinateState>
    implements $CoordinateStateCopyWith<$Res> {
  _$CoordinateStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CoordinateState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? isLoading = null,
    Object? isLoadingMore = null,
    Object? hasMore = null,
    Object? requiresAuth = null,
    Object? errorCode = freezed,
  }) {
    return _then(
      _value.copyWith(
            items: null == items
                ? _value.items
                : items // ignore: cast_nullable_to_non_nullable
                      as List<CoordinateItem>,
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
            requiresAuth: null == requiresAuth
                ? _value.requiresAuth
                : requiresAuth // ignore: cast_nullable_to_non_nullable
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
abstract class _$$CoordinateStateImplCopyWith<$Res>
    implements $CoordinateStateCopyWith<$Res> {
  factory _$$CoordinateStateImplCopyWith(
    _$CoordinateStateImpl value,
    $Res Function(_$CoordinateStateImpl) then,
  ) = __$$CoordinateStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<CoordinateItem> items,
    bool isLoading,
    bool isLoadingMore,
    bool hasMore,
    bool requiresAuth,
    String? errorCode,
  });
}

/// @nodoc
class __$$CoordinateStateImplCopyWithImpl<$Res>
    extends _$CoordinateStateCopyWithImpl<$Res, _$CoordinateStateImpl>
    implements _$$CoordinateStateImplCopyWith<$Res> {
  __$$CoordinateStateImplCopyWithImpl(
    _$CoordinateStateImpl _value,
    $Res Function(_$CoordinateStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CoordinateState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? isLoading = null,
    Object? isLoadingMore = null,
    Object? hasMore = null,
    Object? requiresAuth = null,
    Object? errorCode = freezed,
  }) {
    return _then(
      _$CoordinateStateImpl(
        items: null == items
            ? _value._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<CoordinateItem>,
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
        requiresAuth: null == requiresAuth
            ? _value.requiresAuth
            : requiresAuth // ignore: cast_nullable_to_non_nullable
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

class _$CoordinateStateImpl extends _CoordinateState {
  const _$CoordinateStateImpl({
    required final List<CoordinateItem> items,
    required this.isLoading,
    required this.isLoadingMore,
    required this.hasMore,
    required this.requiresAuth,
    this.errorCode,
  }) : _items = items,
       super._();

  final List<CoordinateItem> _items;
  @override
  List<CoordinateItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final bool isLoading;
  @override
  final bool isLoadingMore;
  @override
  final bool hasMore;
  @override
  final bool requiresAuth;
  @override
  final String? errorCode;

  @override
  String toString() {
    return 'CoordinateState(items: $items, isLoading: $isLoading, isLoadingMore: $isLoadingMore, hasMore: $hasMore, requiresAuth: $requiresAuth, errorCode: $errorCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CoordinateStateImpl &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isLoadingMore, isLoadingMore) ||
                other.isLoadingMore == isLoadingMore) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore) &&
            (identical(other.requiresAuth, requiresAuth) ||
                other.requiresAuth == requiresAuth) &&
            (identical(other.errorCode, errorCode) ||
                other.errorCode == errorCode));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_items),
    isLoading,
    isLoadingMore,
    hasMore,
    requiresAuth,
    errorCode,
  );

  /// Create a copy of CoordinateState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CoordinateStateImplCopyWith<_$CoordinateStateImpl> get copyWith =>
      __$$CoordinateStateImplCopyWithImpl<_$CoordinateStateImpl>(
        this,
        _$identity,
      );
}

abstract class _CoordinateState extends CoordinateState {
  const factory _CoordinateState({
    required final List<CoordinateItem> items,
    required final bool isLoading,
    required final bool isLoadingMore,
    required final bool hasMore,
    required final bool requiresAuth,
    final String? errorCode,
  }) = _$CoordinateStateImpl;
  const _CoordinateState._() : super._();

  @override
  List<CoordinateItem> get items;
  @override
  bool get isLoading;
  @override
  bool get isLoadingMore;
  @override
  bool get hasMore;
  @override
  bool get requiresAuth;
  @override
  String? get errorCode;

  /// Create a copy of CoordinateState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CoordinateStateImplCopyWith<_$CoordinateStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
