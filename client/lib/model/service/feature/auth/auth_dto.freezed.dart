// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AuthDto {
  String get userId => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  bool get isEmailVerified => throw _privateConstructorUsedError;

  /// Create a copy of AuthDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AuthDtoCopyWith<AuthDto> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthDtoCopyWith<$Res> {
  factory $AuthDtoCopyWith(AuthDto value, $Res Function(AuthDto) then) =
      _$AuthDtoCopyWithImpl<$Res, AuthDto>;
  @useResult
  $Res call({String userId, String email, bool isEmailVerified});
}

/// @nodoc
class _$AuthDtoCopyWithImpl<$Res, $Val extends AuthDto>
    implements $AuthDtoCopyWith<$Res> {
  _$AuthDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? email = null,
    Object? isEmailVerified = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      isEmailVerified: null == isEmailVerified
          ? _value.isEmailVerified
          : isEmailVerified // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AuthDtoImplCopyWith<$Res> implements $AuthDtoCopyWith<$Res> {
  factory _$$AuthDtoImplCopyWith(
          _$AuthDtoImpl value, $Res Function(_$AuthDtoImpl) then) =
      __$$AuthDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String userId, String email, bool isEmailVerified});
}

/// @nodoc
class __$$AuthDtoImplCopyWithImpl<$Res>
    extends _$AuthDtoCopyWithImpl<$Res, _$AuthDtoImpl>
    implements _$$AuthDtoImplCopyWith<$Res> {
  __$$AuthDtoImplCopyWithImpl(
      _$AuthDtoImpl _value, $Res Function(_$AuthDtoImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? email = null,
    Object? isEmailVerified = null,
  }) {
    return _then(_$AuthDtoImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      isEmailVerified: null == isEmailVerified
          ? _value.isEmailVerified
          : isEmailVerified // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$AuthDtoImpl implements _AuthDto {
  const _$AuthDtoImpl(
      {required this.userId,
      required this.email,
      required this.isEmailVerified});

  @override
  final String userId;
  @override
  final String email;
  @override
  final bool isEmailVerified;

  @override
  String toString() {
    return 'AuthDto(userId: $userId, email: $email, isEmailVerified: $isEmailVerified)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthDtoImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.isEmailVerified, isEmailVerified) ||
                other.isEmailVerified == isEmailVerified));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userId, email, isEmailVerified);

  /// Create a copy of AuthDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthDtoImplCopyWith<_$AuthDtoImpl> get copyWith =>
      __$$AuthDtoImplCopyWithImpl<_$AuthDtoImpl>(this, _$identity);
}

abstract class _AuthDto implements AuthDto {
  const factory _AuthDto(
      {required final String userId,
      required final String email,
      required final bool isEmailVerified}) = _$AuthDtoImpl;

  @override
  String get userId;
  @override
  String get email;
  @override
  bool get isEmailVerified;

  /// Create a copy of AuthDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthDtoImplCopyWith<_$AuthDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
