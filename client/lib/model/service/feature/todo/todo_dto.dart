import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo_dto.freezed.dart';
part 'todo_dto.g.dart';

// TODO: 後で Open API のスキーマから生成することを検討する。

/// Todo の一覧を表す DTO.
@freezed
class TodosDto with _$TodosDto {
  /// Todo の一覧を表す DTO を生成する。
  const factory TodosDto({@Default([]) List<TodoDto> todos}) = _TodosDto;

  /// JSON から [TodosDto] を生成する。
  factory TodosDto.fromJson(Map<String, dynamic> json) =>
      _$TodosDtoFromJson(json);
}

/// Todo のデータを表す DTO.
@freezed
class TodoDto with _$TodoDto {
  /// Todo のデータを表す DTO を生成する。
  const factory TodoDto({
    // Todo の ID.
    required String id,

    // Todo のタイトル。
    required String title,

    // Todo の説明。
    required String description,

    // Todo の作成日時。
    required DateTime createdAt,

    // Todo の更新日時。
    required DateTime updatedAt,
  }) = _TodoDto;

  /// JSON から [TodoDto] を生成する。
  factory TodoDto.fromJson(Map<String, dynamic> json) =>
      _$TodoDtoFromJson(json);
}
