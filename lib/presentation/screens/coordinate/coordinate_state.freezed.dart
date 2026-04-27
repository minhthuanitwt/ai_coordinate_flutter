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
  bool get isLoadingInitial => throw _privateConstructorUsedError;
  bool get isLoadingMore => throw _privateConstructorUsedError;
  bool get isSubmitting => throw _privateConstructorUsedError;
  bool get hasMore => throw _privateConstructorUsedError;
  bool get requiresAuth => throw _privateConstructorUsedError;
  String get prompt => throw _privateConstructorUsedError;
  CoordinateImageSourceMode get sourceMode =>
      throw _privateConstructorUsedError;
  CoordinateSourceImageType get sourceImageType =>
      throw _privateConstructorUsedError;
  CoordinateBackgroundMode get backgroundMode =>
      throw _privateConstructorUsedError;
  CoordinateModelTier get modelTier => throw _privateConstructorUsedError;
  int get outputCount => throw _privateConstructorUsedError;
  int get maxOutputCount => throw _privateConstructorUsedError;
  int get percoinBalance => throw _privateConstructorUsedError;
  int get estimatedPercoinCost => throw _privateConstructorUsedError;
  CoordinateSourceImageInput get sourceInput =>
      throw _privateConstructorUsedError;
  List<CoordinateGenerationJob> get activeJobs =>
      throw _privateConstructorUsedError;
  CoordinatePollingRecoveryState get pollingRecovery =>
      throw _privateConstructorUsedError;
  String? get errorCode => throw _privateConstructorUsedError;
  String? get submitErrorCode => throw _privateConstructorUsedError;
  String? get validationErrorCode => throw _privateConstructorUsedError;
  String? get infoMessageCode => throw _privateConstructorUsedError;

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
    bool isLoadingInitial,
    bool isLoadingMore,
    bool isSubmitting,
    bool hasMore,
    bool requiresAuth,
    String prompt,
    CoordinateImageSourceMode sourceMode,
    CoordinateSourceImageType sourceImageType,
    CoordinateBackgroundMode backgroundMode,
    CoordinateModelTier modelTier,
    int outputCount,
    int maxOutputCount,
    int percoinBalance,
    int estimatedPercoinCost,
    CoordinateSourceImageInput sourceInput,
    List<CoordinateGenerationJob> activeJobs,
    CoordinatePollingRecoveryState pollingRecovery,
    String? errorCode,
    String? submitErrorCode,
    String? validationErrorCode,
    String? infoMessageCode,
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
    Object? isLoadingInitial = null,
    Object? isLoadingMore = null,
    Object? isSubmitting = null,
    Object? hasMore = null,
    Object? requiresAuth = null,
    Object? prompt = null,
    Object? sourceMode = null,
    Object? sourceImageType = null,
    Object? backgroundMode = null,
    Object? modelTier = null,
    Object? outputCount = null,
    Object? maxOutputCount = null,
    Object? percoinBalance = null,
    Object? estimatedPercoinCost = null,
    Object? sourceInput = null,
    Object? activeJobs = null,
    Object? pollingRecovery = null,
    Object? errorCode = freezed,
    Object? submitErrorCode = freezed,
    Object? validationErrorCode = freezed,
    Object? infoMessageCode = freezed,
  }) {
    return _then(
      _value.copyWith(
            items: null == items
                ? _value.items
                : items // ignore: cast_nullable_to_non_nullable
                      as List<CoordinateItem>,
            isLoadingInitial: null == isLoadingInitial
                ? _value.isLoadingInitial
                : isLoadingInitial // ignore: cast_nullable_to_non_nullable
                      as bool,
            isLoadingMore: null == isLoadingMore
                ? _value.isLoadingMore
                : isLoadingMore // ignore: cast_nullable_to_non_nullable
                      as bool,
            isSubmitting: null == isSubmitting
                ? _value.isSubmitting
                : isSubmitting // ignore: cast_nullable_to_non_nullable
                      as bool,
            hasMore: null == hasMore
                ? _value.hasMore
                : hasMore // ignore: cast_nullable_to_non_nullable
                      as bool,
            requiresAuth: null == requiresAuth
                ? _value.requiresAuth
                : requiresAuth // ignore: cast_nullable_to_non_nullable
                      as bool,
            prompt: null == prompt
                ? _value.prompt
                : prompt // ignore: cast_nullable_to_non_nullable
                      as String,
            sourceMode: null == sourceMode
                ? _value.sourceMode
                : sourceMode // ignore: cast_nullable_to_non_nullable
                      as CoordinateImageSourceMode,
            sourceImageType: null == sourceImageType
                ? _value.sourceImageType
                : sourceImageType // ignore: cast_nullable_to_non_nullable
                      as CoordinateSourceImageType,
            backgroundMode: null == backgroundMode
                ? _value.backgroundMode
                : backgroundMode // ignore: cast_nullable_to_non_nullable
                      as CoordinateBackgroundMode,
            modelTier: null == modelTier
                ? _value.modelTier
                : modelTier // ignore: cast_nullable_to_non_nullable
                      as CoordinateModelTier,
            outputCount: null == outputCount
                ? _value.outputCount
                : outputCount // ignore: cast_nullable_to_non_nullable
                      as int,
            maxOutputCount: null == maxOutputCount
                ? _value.maxOutputCount
                : maxOutputCount // ignore: cast_nullable_to_non_nullable
                      as int,
            percoinBalance: null == percoinBalance
                ? _value.percoinBalance
                : percoinBalance // ignore: cast_nullable_to_non_nullable
                      as int,
            estimatedPercoinCost: null == estimatedPercoinCost
                ? _value.estimatedPercoinCost
                : estimatedPercoinCost // ignore: cast_nullable_to_non_nullable
                      as int,
            sourceInput: null == sourceInput
                ? _value.sourceInput
                : sourceInput // ignore: cast_nullable_to_non_nullable
                      as CoordinateSourceImageInput,
            activeJobs: null == activeJobs
                ? _value.activeJobs
                : activeJobs // ignore: cast_nullable_to_non_nullable
                      as List<CoordinateGenerationJob>,
            pollingRecovery: null == pollingRecovery
                ? _value.pollingRecovery
                : pollingRecovery // ignore: cast_nullable_to_non_nullable
                      as CoordinatePollingRecoveryState,
            errorCode: freezed == errorCode
                ? _value.errorCode
                : errorCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            submitErrorCode: freezed == submitErrorCode
                ? _value.submitErrorCode
                : submitErrorCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            validationErrorCode: freezed == validationErrorCode
                ? _value.validationErrorCode
                : validationErrorCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            infoMessageCode: freezed == infoMessageCode
                ? _value.infoMessageCode
                : infoMessageCode // ignore: cast_nullable_to_non_nullable
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
    bool isLoadingInitial,
    bool isLoadingMore,
    bool isSubmitting,
    bool hasMore,
    bool requiresAuth,
    String prompt,
    CoordinateImageSourceMode sourceMode,
    CoordinateSourceImageType sourceImageType,
    CoordinateBackgroundMode backgroundMode,
    CoordinateModelTier modelTier,
    int outputCount,
    int maxOutputCount,
    int percoinBalance,
    int estimatedPercoinCost,
    CoordinateSourceImageInput sourceInput,
    List<CoordinateGenerationJob> activeJobs,
    CoordinatePollingRecoveryState pollingRecovery,
    String? errorCode,
    String? submitErrorCode,
    String? validationErrorCode,
    String? infoMessageCode,
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
    Object? isLoadingInitial = null,
    Object? isLoadingMore = null,
    Object? isSubmitting = null,
    Object? hasMore = null,
    Object? requiresAuth = null,
    Object? prompt = null,
    Object? sourceMode = null,
    Object? sourceImageType = null,
    Object? backgroundMode = null,
    Object? modelTier = null,
    Object? outputCount = null,
    Object? maxOutputCount = null,
    Object? percoinBalance = null,
    Object? estimatedPercoinCost = null,
    Object? sourceInput = null,
    Object? activeJobs = null,
    Object? pollingRecovery = null,
    Object? errorCode = freezed,
    Object? submitErrorCode = freezed,
    Object? validationErrorCode = freezed,
    Object? infoMessageCode = freezed,
  }) {
    return _then(
      _$CoordinateStateImpl(
        items: null == items
            ? _value._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<CoordinateItem>,
        isLoadingInitial: null == isLoadingInitial
            ? _value.isLoadingInitial
            : isLoadingInitial // ignore: cast_nullable_to_non_nullable
                  as bool,
        isLoadingMore: null == isLoadingMore
            ? _value.isLoadingMore
            : isLoadingMore // ignore: cast_nullable_to_non_nullable
                  as bool,
        isSubmitting: null == isSubmitting
            ? _value.isSubmitting
            : isSubmitting // ignore: cast_nullable_to_non_nullable
                  as bool,
        hasMore: null == hasMore
            ? _value.hasMore
            : hasMore // ignore: cast_nullable_to_non_nullable
                  as bool,
        requiresAuth: null == requiresAuth
            ? _value.requiresAuth
            : requiresAuth // ignore: cast_nullable_to_non_nullable
                  as bool,
        prompt: null == prompt
            ? _value.prompt
            : prompt // ignore: cast_nullable_to_non_nullable
                  as String,
        sourceMode: null == sourceMode
            ? _value.sourceMode
            : sourceMode // ignore: cast_nullable_to_non_nullable
                  as CoordinateImageSourceMode,
        sourceImageType: null == sourceImageType
            ? _value.sourceImageType
            : sourceImageType // ignore: cast_nullable_to_non_nullable
                  as CoordinateSourceImageType,
        backgroundMode: null == backgroundMode
            ? _value.backgroundMode
            : backgroundMode // ignore: cast_nullable_to_non_nullable
                  as CoordinateBackgroundMode,
        modelTier: null == modelTier
            ? _value.modelTier
            : modelTier // ignore: cast_nullable_to_non_nullable
                  as CoordinateModelTier,
        outputCount: null == outputCount
            ? _value.outputCount
            : outputCount // ignore: cast_nullable_to_non_nullable
                  as int,
        maxOutputCount: null == maxOutputCount
            ? _value.maxOutputCount
            : maxOutputCount // ignore: cast_nullable_to_non_nullable
                  as int,
        percoinBalance: null == percoinBalance
            ? _value.percoinBalance
            : percoinBalance // ignore: cast_nullable_to_non_nullable
                  as int,
        estimatedPercoinCost: null == estimatedPercoinCost
            ? _value.estimatedPercoinCost
            : estimatedPercoinCost // ignore: cast_nullable_to_non_nullable
                  as int,
        sourceInput: null == sourceInput
            ? _value.sourceInput
            : sourceInput // ignore: cast_nullable_to_non_nullable
                  as CoordinateSourceImageInput,
        activeJobs: null == activeJobs
            ? _value._activeJobs
            : activeJobs // ignore: cast_nullable_to_non_nullable
                  as List<CoordinateGenerationJob>,
        pollingRecovery: null == pollingRecovery
            ? _value.pollingRecovery
            : pollingRecovery // ignore: cast_nullable_to_non_nullable
                  as CoordinatePollingRecoveryState,
        errorCode: freezed == errorCode
            ? _value.errorCode
            : errorCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        submitErrorCode: freezed == submitErrorCode
            ? _value.submitErrorCode
            : submitErrorCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        validationErrorCode: freezed == validationErrorCode
            ? _value.validationErrorCode
            : validationErrorCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        infoMessageCode: freezed == infoMessageCode
            ? _value.infoMessageCode
            : infoMessageCode // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$CoordinateStateImpl extends _CoordinateState {
  const _$CoordinateStateImpl({
    required final List<CoordinateItem> items,
    required this.isLoadingInitial,
    required this.isLoadingMore,
    required this.isSubmitting,
    required this.hasMore,
    required this.requiresAuth,
    required this.prompt,
    required this.sourceMode,
    required this.sourceImageType,
    required this.backgroundMode,
    required this.modelTier,
    required this.outputCount,
    required this.maxOutputCount,
    required this.percoinBalance,
    required this.estimatedPercoinCost,
    required this.sourceInput,
    required final List<CoordinateGenerationJob> activeJobs,
    required this.pollingRecovery,
    this.errorCode,
    this.submitErrorCode,
    this.validationErrorCode,
    this.infoMessageCode,
  }) : _items = items,
       _activeJobs = activeJobs,
       super._();

  final List<CoordinateItem> _items;
  @override
  List<CoordinateItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final bool isLoadingInitial;
  @override
  final bool isLoadingMore;
  @override
  final bool isSubmitting;
  @override
  final bool hasMore;
  @override
  final bool requiresAuth;
  @override
  final String prompt;
  @override
  final CoordinateImageSourceMode sourceMode;
  @override
  final CoordinateSourceImageType sourceImageType;
  @override
  final CoordinateBackgroundMode backgroundMode;
  @override
  final CoordinateModelTier modelTier;
  @override
  final int outputCount;
  @override
  final int maxOutputCount;
  @override
  final int percoinBalance;
  @override
  final int estimatedPercoinCost;
  @override
  final CoordinateSourceImageInput sourceInput;
  final List<CoordinateGenerationJob> _activeJobs;
  @override
  List<CoordinateGenerationJob> get activeJobs {
    if (_activeJobs is EqualUnmodifiableListView) return _activeJobs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_activeJobs);
  }

  @override
  final CoordinatePollingRecoveryState pollingRecovery;
  @override
  final String? errorCode;
  @override
  final String? submitErrorCode;
  @override
  final String? validationErrorCode;
  @override
  final String? infoMessageCode;

  @override
  String toString() {
    return 'CoordinateState(items: $items, isLoadingInitial: $isLoadingInitial, isLoadingMore: $isLoadingMore, isSubmitting: $isSubmitting, hasMore: $hasMore, requiresAuth: $requiresAuth, prompt: $prompt, sourceMode: $sourceMode, sourceImageType: $sourceImageType, backgroundMode: $backgroundMode, modelTier: $modelTier, outputCount: $outputCount, maxOutputCount: $maxOutputCount, percoinBalance: $percoinBalance, estimatedPercoinCost: $estimatedPercoinCost, sourceInput: $sourceInput, activeJobs: $activeJobs, pollingRecovery: $pollingRecovery, errorCode: $errorCode, submitErrorCode: $submitErrorCode, validationErrorCode: $validationErrorCode, infoMessageCode: $infoMessageCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CoordinateStateImpl &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.isLoadingInitial, isLoadingInitial) ||
                other.isLoadingInitial == isLoadingInitial) &&
            (identical(other.isLoadingMore, isLoadingMore) ||
                other.isLoadingMore == isLoadingMore) &&
            (identical(other.isSubmitting, isSubmitting) ||
                other.isSubmitting == isSubmitting) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore) &&
            (identical(other.requiresAuth, requiresAuth) ||
                other.requiresAuth == requiresAuth) &&
            (identical(other.prompt, prompt) || other.prompt == prompt) &&
            (identical(other.sourceMode, sourceMode) ||
                other.sourceMode == sourceMode) &&
            (identical(other.sourceImageType, sourceImageType) ||
                other.sourceImageType == sourceImageType) &&
            (identical(other.backgroundMode, backgroundMode) ||
                other.backgroundMode == backgroundMode) &&
            (identical(other.modelTier, modelTier) ||
                other.modelTier == modelTier) &&
            (identical(other.outputCount, outputCount) ||
                other.outputCount == outputCount) &&
            (identical(other.maxOutputCount, maxOutputCount) ||
                other.maxOutputCount == maxOutputCount) &&
            (identical(other.percoinBalance, percoinBalance) ||
                other.percoinBalance == percoinBalance) &&
            (identical(other.estimatedPercoinCost, estimatedPercoinCost) ||
                other.estimatedPercoinCost == estimatedPercoinCost) &&
            (identical(other.sourceInput, sourceInput) ||
                other.sourceInput == sourceInput) &&
            const DeepCollectionEquality().equals(
              other._activeJobs,
              _activeJobs,
            ) &&
            (identical(other.pollingRecovery, pollingRecovery) ||
                other.pollingRecovery == pollingRecovery) &&
            (identical(other.errorCode, errorCode) ||
                other.errorCode == errorCode) &&
            (identical(other.submitErrorCode, submitErrorCode) ||
                other.submitErrorCode == submitErrorCode) &&
            (identical(other.validationErrorCode, validationErrorCode) ||
                other.validationErrorCode == validationErrorCode) &&
            (identical(other.infoMessageCode, infoMessageCode) ||
                other.infoMessageCode == infoMessageCode));
  }

  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    const DeepCollectionEquality().hash(_items),
    isLoadingInitial,
    isLoadingMore,
    isSubmitting,
    hasMore,
    requiresAuth,
    prompt,
    sourceMode,
    sourceImageType,
    backgroundMode,
    modelTier,
    outputCount,
    maxOutputCount,
    percoinBalance,
    estimatedPercoinCost,
    sourceInput,
    const DeepCollectionEquality().hash(_activeJobs),
    pollingRecovery,
    errorCode,
    submitErrorCode,
    validationErrorCode,
    infoMessageCode,
  ]);

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
    required final bool isLoadingInitial,
    required final bool isLoadingMore,
    required final bool isSubmitting,
    required final bool hasMore,
    required final bool requiresAuth,
    required final String prompt,
    required final CoordinateImageSourceMode sourceMode,
    required final CoordinateSourceImageType sourceImageType,
    required final CoordinateBackgroundMode backgroundMode,
    required final CoordinateModelTier modelTier,
    required final int outputCount,
    required final int maxOutputCount,
    required final int percoinBalance,
    required final int estimatedPercoinCost,
    required final CoordinateSourceImageInput sourceInput,
    required final List<CoordinateGenerationJob> activeJobs,
    required final CoordinatePollingRecoveryState pollingRecovery,
    final String? errorCode,
    final String? submitErrorCode,
    final String? validationErrorCode,
    final String? infoMessageCode,
  }) = _$CoordinateStateImpl;
  const _CoordinateState._() : super._();

  @override
  List<CoordinateItem> get items;
  @override
  bool get isLoadingInitial;
  @override
  bool get isLoadingMore;
  @override
  bool get isSubmitting;
  @override
  bool get hasMore;
  @override
  bool get requiresAuth;
  @override
  String get prompt;
  @override
  CoordinateImageSourceMode get sourceMode;
  @override
  CoordinateSourceImageType get sourceImageType;
  @override
  CoordinateBackgroundMode get backgroundMode;
  @override
  CoordinateModelTier get modelTier;
  @override
  int get outputCount;
  @override
  int get maxOutputCount;
  @override
  int get percoinBalance;
  @override
  int get estimatedPercoinCost;
  @override
  CoordinateSourceImageInput get sourceInput;
  @override
  List<CoordinateGenerationJob> get activeJobs;
  @override
  CoordinatePollingRecoveryState get pollingRecovery;
  @override
  String? get errorCode;
  @override
  String? get submitErrorCode;
  @override
  String? get validationErrorCode;
  @override
  String? get infoMessageCode;

  /// Create a copy of CoordinateState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CoordinateStateImplCopyWith<_$CoordinateStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
