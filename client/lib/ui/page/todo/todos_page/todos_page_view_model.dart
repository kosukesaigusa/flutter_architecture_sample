import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../model/entity/feature/todo.dart';
import '../../../../model/repository/feature/todo/todo_repository.dart';

part 'todos_page_view_model.freezed.dart';
part 'todos_page_view_model.g.dart';

/// TodosPage の状態を表す State.
@freezed
class TodosPageState with _$TodosPageState {
  /// [TodosPageState] を生成する。
  const factory TodosPageState({required List<Todo> todos}) = _TodosPageState;
}

/// TodosPage の ViewModel.
@riverpod
class TodosPageViewModel extends _$TodosPageViewModel {
  @override
  Future<TodosPageState> build() async {
    final todos = await ref.read(todoRepositoryProvider).fetchTodos();
    return TodosPageState(todos: todos);
  }

  /// Todo を作成する。
  ///
  /// 作成後、ViewModel をリビルドする。
  Future<void> createTodo({
    required String title,
    required String description,
  }) async {
    await ref
        .read(todoRepositoryProvider)
        .createTodo(title: title, description: description);
    ref.invalidateSelf();
  }
}
