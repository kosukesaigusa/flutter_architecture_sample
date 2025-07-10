// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TodosDtoImpl _$$TodosDtoImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$TodosDtoImpl',
      json,
      ($checkedConvert) {
        final val = _$TodosDtoImpl(
          todos: $checkedConvert(
              'todos',
              (v) =>
                  (v as List<dynamic>?)
                      ?.map((e) => TodoDto.fromJson(e as Map<String, dynamic>))
                      .toList() ??
                  const []),
        );
        return val;
      },
    );

Map<String, dynamic> _$$TodosDtoImplToJson(_$TodosDtoImpl instance) =>
    <String, dynamic>{
      'todos': instance.todos,
    };

_$TodoDtoImpl _$$TodoDtoImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$TodoDtoImpl',
      json,
      ($checkedConvert) {
        final val = _$TodoDtoImpl(
          id: $checkedConvert('id', (v) => v as String),
          title: $checkedConvert('title', (v) => v as String),
          description: $checkedConvert('description', (v) => v as String),
          createdAt:
              $checkedConvert('createdAt', (v) => DateTime.parse(v as String)),
          updatedAt:
              $checkedConvert('updatedAt', (v) => DateTime.parse(v as String)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$TodoDtoImplToJson(_$TodoDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
