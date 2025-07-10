// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'multi_part_form_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MultiPartRequestData {
  Map<String, dynamic> get data => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Map<String, dynamic> data) fromMap,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Map<String, dynamic> data)? fromMap,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<String, dynamic> data)? fromMap,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_MultiPartRequestData value) fromMap,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_MultiPartRequestData value)? fromMap,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_MultiPartRequestData value)? fromMap,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of MultiPartRequestData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MultiPartRequestDataCopyWith<MultiPartRequestData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MultiPartRequestDataCopyWith<$Res> {
  factory $MultiPartRequestDataCopyWith(MultiPartRequestData value,
          $Res Function(MultiPartRequestData) then) =
      _$MultiPartRequestDataCopyWithImpl<$Res, MultiPartRequestData>;
  @useResult
  $Res call({Map<String, dynamic> data});
}

/// @nodoc
class _$MultiPartRequestDataCopyWithImpl<$Res,
        $Val extends MultiPartRequestData>
    implements $MultiPartRequestDataCopyWith<$Res> {
  _$MultiPartRequestDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MultiPartRequestData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_value.copyWith(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MultiPartRequestDataImplCopyWith<$Res>
    implements $MultiPartRequestDataCopyWith<$Res> {
  factory _$$MultiPartRequestDataImplCopyWith(_$MultiPartRequestDataImpl value,
          $Res Function(_$MultiPartRequestDataImpl) then) =
      __$$MultiPartRequestDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Map<String, dynamic> data});
}

/// @nodoc
class __$$MultiPartRequestDataImplCopyWithImpl<$Res>
    extends _$MultiPartRequestDataCopyWithImpl<$Res, _$MultiPartRequestDataImpl>
    implements _$$MultiPartRequestDataImplCopyWith<$Res> {
  __$$MultiPartRequestDataImplCopyWithImpl(_$MultiPartRequestDataImpl _value,
      $Res Function(_$MultiPartRequestDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of MultiPartRequestData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_$MultiPartRequestDataImpl(
      null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc

class _$MultiPartRequestDataImpl implements _MultiPartRequestData {
  const _$MultiPartRequestDataImpl(final Map<String, dynamic> data)
      : _data = data;

  final Map<String, dynamic> _data;
  @override
  Map<String, dynamic> get data {
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_data);
  }

  @override
  String toString() {
    return 'MultiPartRequestData.fromMap(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MultiPartRequestDataImpl &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_data));

  /// Create a copy of MultiPartRequestData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MultiPartRequestDataImplCopyWith<_$MultiPartRequestDataImpl>
      get copyWith =>
          __$$MultiPartRequestDataImplCopyWithImpl<_$MultiPartRequestDataImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Map<String, dynamic> data) fromMap,
  }) {
    return fromMap(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Map<String, dynamic> data)? fromMap,
  }) {
    return fromMap?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<String, dynamic> data)? fromMap,
    required TResult orElse(),
  }) {
    if (fromMap != null) {
      return fromMap(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_MultiPartRequestData value) fromMap,
  }) {
    return fromMap(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_MultiPartRequestData value)? fromMap,
  }) {
    return fromMap?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_MultiPartRequestData value)? fromMap,
    required TResult orElse(),
  }) {
    if (fromMap != null) {
      return fromMap(this);
    }
    return orElse();
  }
}

abstract class _MultiPartRequestData implements MultiPartRequestData {
  const factory _MultiPartRequestData(final Map<String, dynamic> data) =
      _$MultiPartRequestDataImpl;

  @override
  Map<String, dynamic> get data;

  /// Create a copy of MultiPartRequestData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MultiPartRequestDataImplCopyWith<_$MultiPartRequestDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$MultiPartFile {
  Uint8List get bytes => throw _privateConstructorUsedError;
  MultiPartFileSupportedExtension get extension =>
      throw _privateConstructorUsedError;
  String? get fileName => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Uint8List bytes,
            MultiPartFileSupportedExtension extension, String? fileName)
        fromBytes,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Uint8List bytes,
            MultiPartFileSupportedExtension extension, String? fileName)?
        fromBytes,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Uint8List bytes, MultiPartFileSupportedExtension extension,
            String? fileName)?
        fromBytes,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_MultiPartFile value) fromBytes,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_MultiPartFile value)? fromBytes,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_MultiPartFile value)? fromBytes,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of MultiPartFile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MultiPartFileCopyWith<MultiPartFile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MultiPartFileCopyWith<$Res> {
  factory $MultiPartFileCopyWith(
          MultiPartFile value, $Res Function(MultiPartFile) then) =
      _$MultiPartFileCopyWithImpl<$Res, MultiPartFile>;
  @useResult
  $Res call(
      {Uint8List bytes,
      MultiPartFileSupportedExtension extension,
      String? fileName});
}

/// @nodoc
class _$MultiPartFileCopyWithImpl<$Res, $Val extends MultiPartFile>
    implements $MultiPartFileCopyWith<$Res> {
  _$MultiPartFileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MultiPartFile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bytes = null,
    Object? extension = null,
    Object? fileName = freezed,
  }) {
    return _then(_value.copyWith(
      bytes: null == bytes
          ? _value.bytes
          : bytes // ignore: cast_nullable_to_non_nullable
              as Uint8List,
      extension: null == extension
          ? _value.extension
          : extension // ignore: cast_nullable_to_non_nullable
              as MultiPartFileSupportedExtension,
      fileName: freezed == fileName
          ? _value.fileName
          : fileName // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MultiPartFileImplCopyWith<$Res>
    implements $MultiPartFileCopyWith<$Res> {
  factory _$$MultiPartFileImplCopyWith(
          _$MultiPartFileImpl value, $Res Function(_$MultiPartFileImpl) then) =
      __$$MultiPartFileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Uint8List bytes,
      MultiPartFileSupportedExtension extension,
      String? fileName});
}

/// @nodoc
class __$$MultiPartFileImplCopyWithImpl<$Res>
    extends _$MultiPartFileCopyWithImpl<$Res, _$MultiPartFileImpl>
    implements _$$MultiPartFileImplCopyWith<$Res> {
  __$$MultiPartFileImplCopyWithImpl(
      _$MultiPartFileImpl _value, $Res Function(_$MultiPartFileImpl) _then)
      : super(_value, _then);

  /// Create a copy of MultiPartFile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bytes = null,
    Object? extension = null,
    Object? fileName = freezed,
  }) {
    return _then(_$MultiPartFileImpl(
      bytes: null == bytes
          ? _value.bytes
          : bytes // ignore: cast_nullable_to_non_nullable
              as Uint8List,
      extension: null == extension
          ? _value.extension
          : extension // ignore: cast_nullable_to_non_nullable
              as MultiPartFileSupportedExtension,
      fileName: freezed == fileName
          ? _value.fileName
          : fileName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$MultiPartFileImpl implements _MultiPartFile {
  const _$MultiPartFileImpl(
      {required this.bytes, required this.extension, this.fileName});

  @override
  final Uint8List bytes;
  @override
  final MultiPartFileSupportedExtension extension;
  @override
  final String? fileName;

  @override
  String toString() {
    return 'MultiPartFile.fromBytes(bytes: $bytes, extension: $extension, fileName: $fileName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MultiPartFileImpl &&
            const DeepCollectionEquality().equals(other.bytes, bytes) &&
            (identical(other.extension, extension) ||
                other.extension == extension) &&
            (identical(other.fileName, fileName) ||
                other.fileName == fileName));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(bytes), extension, fileName);

  /// Create a copy of MultiPartFile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MultiPartFileImplCopyWith<_$MultiPartFileImpl> get copyWith =>
      __$$MultiPartFileImplCopyWithImpl<_$MultiPartFileImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Uint8List bytes,
            MultiPartFileSupportedExtension extension, String? fileName)
        fromBytes,
  }) {
    return fromBytes(bytes, extension, fileName);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Uint8List bytes,
            MultiPartFileSupportedExtension extension, String? fileName)?
        fromBytes,
  }) {
    return fromBytes?.call(bytes, extension, fileName);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Uint8List bytes, MultiPartFileSupportedExtension extension,
            String? fileName)?
        fromBytes,
    required TResult orElse(),
  }) {
    if (fromBytes != null) {
      return fromBytes(bytes, extension, fileName);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_MultiPartFile value) fromBytes,
  }) {
    return fromBytes(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_MultiPartFile value)? fromBytes,
  }) {
    return fromBytes?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_MultiPartFile value)? fromBytes,
    required TResult orElse(),
  }) {
    if (fromBytes != null) {
      return fromBytes(this);
    }
    return orElse();
  }
}

abstract class _MultiPartFile implements MultiPartFile {
  const factory _MultiPartFile(
      {required final Uint8List bytes,
      required final MultiPartFileSupportedExtension extension,
      final String? fileName}) = _$MultiPartFileImpl;

  @override
  Uint8List get bytes;
  @override
  MultiPartFileSupportedExtension get extension;
  @override
  String? get fileName;

  /// Create a copy of MultiPartFile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MultiPartFileImplCopyWith<_$MultiPartFileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
