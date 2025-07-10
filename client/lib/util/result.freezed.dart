// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Result<S, E> {
  Object? get data => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(S data) success,
    required TResult Function(Object? e, E? data, StackTrace? stackTrace)
        failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(S data)? success,
    TResult? Function(Object? e, E? data, StackTrace? stackTrace)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(S data)? success,
    TResult Function(Object? e, E? data, StackTrace? stackTrace)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SuccessResult<S, E> value) success,
    required TResult Function(FailureResult<S, E> value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SuccessResult<S, E> value)? success,
    TResult? Function(FailureResult<S, E> value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SuccessResult<S, E> value)? success,
    TResult Function(FailureResult<S, E> value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResultCopyWith<S, E, $Res> {
  factory $ResultCopyWith(
          Result<S, E> value, $Res Function(Result<S, E>) then) =
      _$ResultCopyWithImpl<S, E, $Res, Result<S, E>>;
}

/// @nodoc
class _$ResultCopyWithImpl<S, E, $Res, $Val extends Result<S, E>>
    implements $ResultCopyWith<S, E, $Res> {
  _$ResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Result
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$SuccessResultImplCopyWith<S, E, $Res> {
  factory _$$SuccessResultImplCopyWith(_$SuccessResultImpl<S, E> value,
          $Res Function(_$SuccessResultImpl<S, E>) then) =
      __$$SuccessResultImplCopyWithImpl<S, E, $Res>;
  @useResult
  $Res call({S data});
}

/// @nodoc
class __$$SuccessResultImplCopyWithImpl<S, E, $Res>
    extends _$ResultCopyWithImpl<S, E, $Res, _$SuccessResultImpl<S, E>>
    implements _$$SuccessResultImplCopyWith<S, E, $Res> {
  __$$SuccessResultImplCopyWithImpl(_$SuccessResultImpl<S, E> _value,
      $Res Function(_$SuccessResultImpl<S, E>) _then)
      : super(_value, _then);

  /// Create a copy of Result
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$SuccessResultImpl<S, E>(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as S,
    ));
  }
}

/// @nodoc

class _$SuccessResultImpl<S, E> implements SuccessResult<S, E> {
  const _$SuccessResultImpl({required this.data});

  @override
  final S data;

  @override
  String toString() {
    return 'Result<$S, $E>.success(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessResultImpl<S, E> &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(data));

  /// Create a copy of Result
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessResultImplCopyWith<S, E, _$SuccessResultImpl<S, E>> get copyWith =>
      __$$SuccessResultImplCopyWithImpl<S, E, _$SuccessResultImpl<S, E>>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(S data) success,
    required TResult Function(Object? e, E? data, StackTrace? stackTrace)
        failure,
  }) {
    return success(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(S data)? success,
    TResult? Function(Object? e, E? data, StackTrace? stackTrace)? failure,
  }) {
    return success?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(S data)? success,
    TResult Function(Object? e, E? data, StackTrace? stackTrace)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SuccessResult<S, E> value) success,
    required TResult Function(FailureResult<S, E> value) failure,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SuccessResult<S, E> value)? success,
    TResult? Function(FailureResult<S, E> value)? failure,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SuccessResult<S, E> value)? success,
    TResult Function(FailureResult<S, E> value)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class SuccessResult<S, E> implements Result<S, E> {
  const factory SuccessResult({required final S data}) =
      _$SuccessResultImpl<S, E>;

  @override
  S get data;

  /// Create a copy of Result
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SuccessResultImplCopyWith<S, E, _$SuccessResultImpl<S, E>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FailureResultImplCopyWith<S, E, $Res> {
  factory _$$FailureResultImplCopyWith(_$FailureResultImpl<S, E> value,
          $Res Function(_$FailureResultImpl<S, E>) then) =
      __$$FailureResultImplCopyWithImpl<S, E, $Res>;
  @useResult
  $Res call({Object? e, E? data, StackTrace? stackTrace});
}

/// @nodoc
class __$$FailureResultImplCopyWithImpl<S, E, $Res>
    extends _$ResultCopyWithImpl<S, E, $Res, _$FailureResultImpl<S, E>>
    implements _$$FailureResultImplCopyWith<S, E, $Res> {
  __$$FailureResultImplCopyWithImpl(_$FailureResultImpl<S, E> _value,
      $Res Function(_$FailureResultImpl<S, E>) _then)
      : super(_value, _then);

  /// Create a copy of Result
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? e = freezed,
    Object? data = freezed,
    Object? stackTrace = freezed,
  }) {
    return _then(_$FailureResultImpl<S, E>(
      e: freezed == e ? _value.e : e,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as E?,
      stackTrace: freezed == stackTrace
          ? _value.stackTrace
          : stackTrace // ignore: cast_nullable_to_non_nullable
              as StackTrace?,
    ));
  }
}

/// @nodoc

class _$FailureResultImpl<S, E> implements FailureResult<S, E> {
  const _$FailureResultImpl(
      {required this.e, required this.data, this.stackTrace});

  @override
  final Object? e;
  @override
  final E? data;
  @override
  final StackTrace? stackTrace;

  @override
  String toString() {
    return 'Result<$S, $E>.failure(e: $e, data: $data, stackTrace: $stackTrace)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FailureResultImpl<S, E> &&
            const DeepCollectionEquality().equals(other.e, e) &&
            const DeepCollectionEquality().equals(other.data, data) &&
            (identical(other.stackTrace, stackTrace) ||
                other.stackTrace == stackTrace));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(e),
      const DeepCollectionEquality().hash(data),
      stackTrace);

  /// Create a copy of Result
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FailureResultImplCopyWith<S, E, _$FailureResultImpl<S, E>> get copyWith =>
      __$$FailureResultImplCopyWithImpl<S, E, _$FailureResultImpl<S, E>>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(S data) success,
    required TResult Function(Object? e, E? data, StackTrace? stackTrace)
        failure,
  }) {
    return failure(e, data, stackTrace);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(S data)? success,
    TResult? Function(Object? e, E? data, StackTrace? stackTrace)? failure,
  }) {
    return failure?.call(e, data, stackTrace);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(S data)? success,
    TResult Function(Object? e, E? data, StackTrace? stackTrace)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(e, data, stackTrace);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SuccessResult<S, E> value) success,
    required TResult Function(FailureResult<S, E> value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SuccessResult<S, E> value)? success,
    TResult? Function(FailureResult<S, E> value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SuccessResult<S, E> value)? success,
    TResult Function(FailureResult<S, E> value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class FailureResult<S, E> implements Result<S, E> {
  const factory FailureResult(
      {required final Object? e,
      required final E? data,
      final StackTrace? stackTrace}) = _$FailureResultImpl<S, E>;

  Object? get e;
  @override
  E? get data;
  StackTrace? get stackTrace;

  /// Create a copy of Result
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FailureResultImplCopyWith<S, E, _$FailureResultImpl<S, E>> get copyWith =>
      throw _privateConstructorUsedError;
}
