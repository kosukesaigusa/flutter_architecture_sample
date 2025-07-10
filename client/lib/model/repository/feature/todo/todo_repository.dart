import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../external/http/http_response.dart';
import '../../../../util/logger.dart';
import '../../../entity/feature/todo.dart';
import '../../../service/feature/todo/todo_service.dart';

part 'todo_repository.g.dart';

/// [TodoRepository] クラスのインスタンスを提供する。
@riverpod
TodoRepository todoRepository(Ref ref) => TodoRepository(ref);

/// Todo 関係の通信を行うリポジトリクラス。
class TodoRepository {
  /// [TodoRepository] を生成する。
  const TodoRepository(this._ref);

  final Ref _ref;

  /// Todo 一覧を取得する。
  ///
  /// 取得に失敗した場合は、空の配列を返す。
  Future<List<Todo>> fetchTodos() async {
    final todos = await _ref.read(todoServiceProvider).fetchTodos();
    switch (todos) {
      case SuccessHttpResponse(:final data):
        return data.todos.map(Todo.fromDto).toList();
      case FailureHttpResponse(:final e):
        logger.e(e);
        return [];
    }
  }

  /// Todo を作成する。
  ///
  /// 作成に失敗した場合は、例外をスローする。
  Future<void> createTodo({
    required String title,
    required String description,
  }) async {
    final response = await _ref
        .read(todoServiceProvider)
        .createTodo(title: title, description: description);
    switch (response) {
      case SuccessHttpResponse():
        return;
      case FailureHttpResponse(:final e):
        logger.e(e);
        throw FetchTodosException();
    }
  }
}

/// Todo 一覧の取得に失敗した場合にスローされる例外。
class FetchTodosException implements Exception {}
