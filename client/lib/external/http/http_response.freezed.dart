// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'http_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$HttpResponse<T> {
  T? get data => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T data, Map<String, List<String>> headers)
        success,
    required TResult Function(T? data, Object e, ErrorStatus status) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(T data, Map<String, List<String>> headers)? success,
    TResult? Function(T? data, Object e, ErrorStatus status)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T data, Map<String, List<String>> headers)? success,
    TResult Function(T? data, Object e, ErrorStatus status)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SuccessHttpResponse<T> value) success,
    required TResult Function(FailureHttpResponse<T> value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SuccessHttpResponse<T> value)? success,
    TResult? Function(FailureHttpResponse<T> value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SuccessHttpResponse<T> value)? success,
    TResult Function(FailureHttpResponse<T> value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HttpResponseCopyWith<T, $Res> {
  factory $HttpResponseCopyWith(
          HttpResponse<T> value, $Res Function(HttpResponse<T>) then) =
      _$HttpResponseCopyWithImpl<T, $Res, HttpResponse<T>>;
}

/// @nodoc
class _$HttpResponseCopyWithImpl<T, $Res, $Val extends HttpResponse<T>>
    implements $HttpResponseCopyWith<T, $Res> {
  _$HttpResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HttpResponse
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$SuccessHttpResponseImplCopyWith<T, $Res> {
  factory _$$SuccessHttpResponseImplCopyWith(_$SuccessHttpResponseImpl<T> value,
          $Res Function(_$SuccessHttpResponseImpl<T>) then) =
      __$$SuccessHttpResponseImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({T data, Map<String, List<String>> headers});
}

/// @nodoc
class __$$SuccessHttpResponseImplCopyWithImpl<T, $Res>
    extends _$HttpResponseCopyWithImpl<T, $Res, _$SuccessHttpResponseImpl<T>>
    implements _$$SuccessHttpResponseImplCopyWith<T, $Res> {
  __$$SuccessHttpResponseImplCopyWithImpl(_$SuccessHttpResponseImpl<T> _value,
      $Res Function(_$SuccessHttpResponseImpl<T>) _then)
      : super(_value, _then);

  /// Create a copy of HttpResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
    Object? headers = null,
  }) {
    return _then(_$SuccessHttpResponseImpl<T>(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T,
      headers: null == headers
          ? _value._headers
          : headers // ignore: cast_nullable_to_non_nullable
              as Map<String, List<String>>,
    ));
  }
}

/// @nodoc

class _$SuccessHttpResponseImpl<T> implements SuccessHttpResponse<T> {
  const _$SuccessHttpResponseImpl(
      {required this.data, required final Map<String, List<String>> headers})
      : _headers = headers;

  @override
  final T data;
  final Map<String, List<String>> _headers;
  @override
  Map<String, List<String>> get headers {
    if (_headers is EqualUnmodifiableMapView) return _headers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_headers);
  }

  @override
  String toString() {
    return 'HttpResponse<$T>.success(data: $data, headers: $headers)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessHttpResponseImpl<T> &&
            const DeepCollectionEquality().equals(other.data, data) &&
            const DeepCollectionEquality().equals(other._headers, _headers));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(data),
      const DeepCollectionEquality().hash(_headers));

  /// Create a copy of HttpResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessHttpResponseImplCopyWith<T, _$SuccessHttpResponseImpl<T>>
      get copyWith => __$$SuccessHttpResponseImplCopyWithImpl<T,
          _$SuccessHttpResponseImpl<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T data, Map<String, List<String>> headers)
        success,
    required TResult Function(T? data, Object e, ErrorStatus status) failure,
  }) {
    return success(data, headers);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(T data, Map<String, List<String>> headers)? success,
    TResult? Function(T? data, Object e, ErrorStatus status)? failure,
  }) {
    return success?.call(data, headers);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T data, Map<String, List<String>> headers)? success,
    TResult Function(T? data, Object e, ErrorStatus status)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(data, headers);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SuccessHttpResponse<T> value) success,
    required TResult Function(FailureHttpResponse<T> value) failure,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SuccessHttpResponse<T> value)? success,
    TResult? Function(FailureHttpResponse<T> value)? failure,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SuccessHttpResponse<T> value)? success,
    TResult Function(FailureHttpResponse<T> value)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class SuccessHttpResponse<T> implements HttpResponse<T> {
  const factory SuccessHttpResponse(
          {required final T data,
          required final Map<String, List<String>> headers}) =
      _$SuccessHttpResponseImpl<T>;

  @override
  T get data;
  Map<String, List<String>> get headers;

  /// Create a copy of HttpResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SuccessHttpResponseImplCopyWith<T, _$SuccessHttpResponseImpl<T>>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FailureHttpResponseImplCopyWith<T, $Res> {
  factory _$$FailureHttpResponseImplCopyWith(_$FailureHttpResponseImpl<T> value,
          $Res Function(_$FailureHttpResponseImpl<T>) then) =
      __$$FailureHttpResponseImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({T? data, Object e, ErrorStatus status});
}

/// @nodoc
class __$$FailureHttpResponseImplCopyWithImpl<T, $Res>
    extends _$HttpResponseCopyWithImpl<T, $Res, _$FailureHttpResponseImpl<T>>
    implements _$$FailureHttpResponseImplCopyWith<T, $Res> {
  __$$FailureHttpResponseImplCopyWithImpl(_$FailureHttpResponseImpl<T> _value,
      $Res Function(_$FailureHttpResponseImpl<T>) _then)
      : super(_value, _then);

  /// Create a copy of HttpResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
    Object? e = null,
    Object? status = null,
  }) {
    return _then(_$FailureHttpResponseImpl<T>(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T?,
      e: null == e ? _value.e : e,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ErrorStatus,
    ));
  }
}

/// @nodoc

class _$FailureHttpResponseImpl<T> implements FailureHttpResponse<T> {
  const _$FailureHttpResponseImpl(
      {this.data, required this.e, required this.status});

  @override
  final T? data;
  @override
  final Object e;
  @override
  final ErrorStatus status;

  @override
  String toString() {
    return 'HttpResponse<$T>.failure(data: $data, e: $e, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FailureHttpResponseImpl<T> &&
            const DeepCollectionEquality().equals(other.data, data) &&
            const DeepCollectionEquality().equals(other.e, e) &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(data),
      const DeepCollectionEquality().hash(e),
      status);

  /// Create a copy of HttpResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FailureHttpResponseImplCopyWith<T, _$FailureHttpResponseImpl<T>>
      get copyWith => __$$FailureHttpResponseImplCopyWithImpl<T,
          _$FailureHttpResponseImpl<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T data, Map<String, List<String>> headers)
        success,
    required TResult Function(T? data, Object e, ErrorStatus status) failure,
  }) {
    return failure(data, e, status);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(T data, Map<String, List<String>> headers)? success,
    TResult? Function(T? data, Object e, ErrorStatus status)? failure,
  }) {
    return failure?.call(data, e, status);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T data, Map<String, List<String>> headers)? success,
    TResult Function(T? data, Object e, ErrorStatus status)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(data, e, status);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SuccessHttpResponse<T> value) success,
    required TResult Function(FailureHttpResponse<T> value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SuccessHttpResponse<T> value)? success,
    TResult? Function(FailureHttpResponse<T> value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SuccessHttpResponse<T> value)? success,
    TResult Function(FailureHttpResponse<T> value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class FailureHttpResponse<T> implements HttpResponse<T> {
  const factory FailureHttpResponse(
      {final T? data,
      required final Object e,
      required final ErrorStatus status}) = _$FailureHttpResponseImpl<T>;

  @override
  T? get data;
  Object get e;
  ErrorStatus get status;

  /// Create a copy of HttpResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FailureHttpResponseImplCopyWith<T, _$FailureHttpResponseImpl<T>>
      get copyWith => throw _privateConstructorUsedError;
}
