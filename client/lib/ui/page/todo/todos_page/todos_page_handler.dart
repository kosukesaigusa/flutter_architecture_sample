import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'todos_page_view_model.dart';

part 'todos_page_handler.g.dart';

/// [TodosPageHandler] クラスのインスタンスを提供する。
@riverpod
TodosPageHandler todosPageHandler(Ref ref) => TodosPageHandler(ref);

/// TodosPage の Handler.
class TodosPageHandler {
  /// [TodosPageHandler] を生成する。
  const TodosPageHandler(this._ref);

  final Ref _ref;

  /// Todo を作成するためのダイアログを表示する。
  Future<void> showCreateTodoDialog({required BuildContext context}) async {
    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('新しい Todo'),
        content: const Text('新しい Todo の説明'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('キャンセル'),
          ),
          TextButton(
            onPressed: () async {
              await _ref
                  .read(todosPageViewModelProvider.notifier)
                  .createTodo(title: '新しい Todo', description: '新しい Todo の説明');
              if (!context.mounted) {
                return;
              }
              Navigator.pop(context);
            },
            child: const Text('作成'),
          ),
        ],
      ),
    );
  }
}
