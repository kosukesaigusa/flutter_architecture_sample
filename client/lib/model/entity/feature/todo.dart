import 'package:freezed_annotation/freezed_annotation.dart';

import '../../service/feature/todo/todo_dto.dart';

part 'todo.freezed.dart';

/// Todo エンティティ。
@freezed
class Todo with _$Todo {
  /// [Todo] を生成する。
  const factory Todo({
    required String id,
    required String title,
    required String description,
  }) = _Todo;

  /// [TodoDto] から [Todo] を生成する。
  factory Todo.fromDto(TodoDto dto) =>
      Todo(id: dto.id, title: dto.title, description: dto.description);
}
