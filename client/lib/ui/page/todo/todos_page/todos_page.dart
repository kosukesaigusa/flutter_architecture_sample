import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'todos_page_handler.dart';
import 'todos_page_view_model.dart';

/// Todo 一覧ページ。
class TodosPage extends ConsumerWidget {
  /// [TodosPage] を生成する。
  const TodosPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ViewModel を watch する。
    final viewModelAsyncValue = ref.watch(todosPageViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Todo 一覧')),
      floatingActionButton: FloatingActionButton(
        // Todo を作成するためのダイアログを表示する。
        onPressed: () => ref
            .read(todosPageHandlerProvider)
            .showCreateTodoDialog(context: context),
        child: const Icon(Icons.add),
      ),
      body: viewModelAsyncValue.when(
        data: (viewModel) {
          final todos = viewModel.todos;
          if (todos.isEmpty) {
            return const Center(child: Text('Todo がありません。'));
          }
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];
              return ListTile(
                title: Text(todo.title),
                subtitle: Text(todo.description),
              );
            },
          );
        },
        error: (error, stackTrace) =>
            const Scaffold(body: Center(child: Text('エラーが発生しました。'))),
        loading: () =>
            const Scaffold(body: Center(child: CircularProgressIndicator())),
      ),
    );
  }
}
