import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../external/http/http_response.dart';
import '../../util/http/http_endpoint.dart';
import '../../util/http/http_request_helper.dart';
import 'todo_dto.dart';

part 'todo_service.g.dart';

/// [TodoService] クラスのインスタンスを提供する。
@riverpod
TodoService todoService(Ref ref) => TodoService(ref);

/// Todo 関係のサービスクラス。
class TodoService {
  /// [TodoService] を生成する。
  const TodoService(this._ref);

  final Ref _ref;

  /// Todo 一覧を取得する。
  Future<HttpResponse<TodosDto>> fetchTodos() async {
    final response = await _ref
        .read(httpRequestHelperProvider)
        .request(const TodosGetHttpEndpoint());
    switch (response) {
      case SuccessHttpResponse(:final data):
        final json = data as Map<String, dynamic>? ?? {};
        final todosDto = TodosDto.fromJson(json);
        return HttpResponse.success(data: todosDto, headers: {});
      case FailureHttpResponse(:final data, :final e):
        // final json = data as Map<String, dynamic>?;
        // final errorDto = ErrorDto.fromJson(json ?? {});
        // return HttpResponse.failure(e, errorDto: errorDto);
        // TODO: 後で、エラー用のデータを返すようにする。
        throw Exception();
    }
  }

  /// Todo を作成する。
  ///
  /// - [title] には Todo のタイトルを指定する。
  /// - [description] には Todo の説明を指定する。
  Future<HttpResponse<TodoDto>> createTodo({
    required String title,
    required String description,
  }) async {
    final response = await _ref
        .read(httpRequestHelperProvider)
        .request(TodosPostHttpEndpoint(title: title, description: description));
    switch (response) {
      case SuccessHttpResponse(:final data):
        final json = data as Map<String, dynamic>? ?? {};
        final todoDto = TodoDto.fromJson(json);
        return HttpResponse.success(data: todoDto, headers: {});
      case FailureHttpResponse(:final data, :final e):
        // final json = data as Map<String, dynamic>?;
        // final errorDto = ErrorDto.fromJson(json ?? {});
        // return HttpResponse.failure(e, errorDto: errorDto);
        // TODO: 後で、エラー用のデータを返すようにする。
        throw Exception();
    }
  }
}
