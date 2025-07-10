// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'todo_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TodosDto _$TodosDtoFromJson(Map<String, dynamic> json) {
  return _TodosDto.fromJson(json);
}

/// @nodoc
mixin _$TodosDto {
  List<TodoDto> get todos => throw _privateConstructorUsedError;

  /// Serializes this TodosDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TodosDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TodosDtoCopyWith<TodosDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TodosDtoCopyWith<$Res> {
  factory $TodosDtoCopyWith(TodosDto value, $Res Function(TodosDto) then) =
      _$TodosDtoCopyWithImpl<$Res, TodosDto>;
  @useResult
  $Res call({List<TodoDto> todos});
}

/// @nodoc
class _$TodosDtoCopyWithImpl<$Res, $Val extends TodosDto>
    implements $TodosDtoCopyWith<$Res> {
  _$TodosDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TodosDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? todos = null,
  }) {
    return _then(_value.copyWith(
      todos: null == todos
          ? _value.todos
          : todos // ignore: cast_nullable_to_non_nullable
              as List<TodoDto>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TodosDtoImplCopyWith<$Res>
    implements $TodosDtoCopyWith<$Res> {
  factory _$$TodosDtoImplCopyWith(
          _$TodosDtoImpl value, $Res Function(_$TodosDtoImpl) then) =
      __$$TodosDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<TodoDto> todos});
}

/// @nodoc
class __$$TodosDtoImplCopyWithImpl<$Res>
    extends _$TodosDtoCopyWithImpl<$Res, _$TodosDtoImpl>
    implements _$$TodosDtoImplCopyWith<$Res> {
  __$$TodosDtoImplCopyWithImpl(
      _$TodosDtoImpl _value, $Res Function(_$TodosDtoImpl) _then)
      : super(_value, _then);

  /// Create a copy of TodosDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? todos = null,
  }) {
    return _then(_$TodosDtoImpl(
      todos: null == todos
          ? _value._todos
          : todos // ignore: cast_nullable_to_non_nullable
              as List<TodoDto>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TodosDtoImpl implements _TodosDto {
  const _$TodosDtoImpl({final List<TodoDto> todos = const []}) : _todos = todos;

  factory _$TodosDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$TodosDtoImplFromJson(json);

  final List<TodoDto> _todos;
  @override
  @JsonKey()
  List<TodoDto> get todos {
    if (_todos is EqualUnmodifiableListView) return _todos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_todos);
  }

  @override
  String toString() {
    return 'TodosDto(todos: $todos)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TodosDtoImpl &&
            const DeepCollectionEquality().equals(other._todos, _todos));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_todos));

  /// Create a copy of TodosDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TodosDtoImplCopyWith<_$TodosDtoImpl> get copyWith =>
      __$$TodosDtoImplCopyWithImpl<_$TodosDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TodosDtoImplToJson(
      this,
    );
  }
}

abstract class _TodosDto implements TodosDto {
  const factory _TodosDto({final List<TodoDto> todos}) = _$TodosDtoImpl;

  factory _TodosDto.fromJson(Map<String, dynamic> json) =
      _$TodosDtoImpl.fromJson;

  @override
  List<TodoDto> get todos;

  /// Create a copy of TodosDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TodosDtoImplCopyWith<_$TodosDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TodoDto _$TodoDtoFromJson(Map<String, dynamic> json) {
  return _TodoDto.fromJson(json);
}

/// @nodoc
mixin _$TodoDto {
// Todo の ID.
  String get id => throw _privateConstructorUsedError; // Todo のタイトル。
  String get title => throw _privateConstructorUsedError; // Todo の説明。
  String get description => throw _privateConstructorUsedError; // Todo の作成日時。
  DateTime get createdAt => throw _privateConstructorUsedError; // Todo の更新日時。
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this TodoDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TodoDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TodoDtoCopyWith<TodoDto> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TodoDtoCopyWith<$Res> {
  factory $TodoDtoCopyWith(TodoDto value, $Res Function(TodoDto) then) =
      _$TodoDtoCopyWithImpl<$Res, TodoDto>;
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class _$TodoDtoCopyWithImpl<$Res, $Val extends TodoDto>
    implements $TodoDtoCopyWith<$Res> {
  _$TodoDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TodoDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TodoDtoImplCopyWith<$Res> implements $TodoDtoCopyWith<$Res> {
  factory _$$TodoDtoImplCopyWith(
          _$TodoDtoImpl value, $Res Function(_$TodoDtoImpl) then) =
      __$$TodoDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class __$$TodoDtoImplCopyWithImpl<$Res>
    extends _$TodoDtoCopyWithImpl<$Res, _$TodoDtoImpl>
    implements _$$TodoDtoImplCopyWith<$Res> {
  __$$TodoDtoImplCopyWithImpl(
      _$TodoDtoImpl _value, $Res Function(_$TodoDtoImpl) _then)
      : super(_value, _then);

  /// Create a copy of TodoDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$TodoDtoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TodoDtoImpl implements _TodoDto {
  const _$TodoDtoImpl(
      {required this.id,
      required this.title,
      required this.description,
      required this.createdAt,
      required this.updatedAt});

  factory _$TodoDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$TodoDtoImplFromJson(json);

// Todo の ID.
  @override
  final String id;
// Todo のタイトル。
  @override
  final String title;
// Todo の説明。
  @override
  final String description;
// Todo の作成日時。
  @override
  final DateTime createdAt;
// Todo の更新日時。
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'TodoDto(id: $id, title: $title, description: $description, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TodoDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, title, description, createdAt, updatedAt);

  /// Create a copy of TodoDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TodoDtoImplCopyWith<_$TodoDtoImpl> get copyWith =>
      __$$TodoDtoImplCopyWithImpl<_$TodoDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TodoDtoImplToJson(
      this,
    );
  }
}

abstract class _TodoDto implements TodoDto {
  const factory _TodoDto(
      {required final String id,
      required final String title,
      required final String description,
      required final DateTime createdAt,
      required final DateTime updatedAt}) = _$TodoDtoImpl;

  factory _TodoDto.fromJson(Map<String, dynamic> json) = _$TodoDtoImpl.fromJson;

// Todo の ID.
  @override
  String get id; // Todo のタイトル。
  @override
  String get title; // Todo の説明。
  @override
  String get description; // Todo の作成日時。
  @override
  DateTime get createdAt; // Todo の更新日時。
  @override
  DateTime get updatedAt;

  /// Create a copy of TodoDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TodoDtoImplCopyWith<_$TodoDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
