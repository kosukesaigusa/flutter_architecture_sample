import '../../../../external/http/content_type.dart';
import '../../../../external/http/http_method.dart';

/// サーバサイド API のエンドポイント情報。
sealed class HttpEndpoint {
  const HttpEndpoint({
    required this.method,
    this.contentType = HttpContentType.json,
  });

  /// HTTP メソッド。
  final HttpMethod method;

  /// コンテントタイプ。
  final HttpContentType contentType;

  /// エンドポイントパス。
  String get path;

  /// リクエストボディ。
  Map<String, dynamic>? get requestBody => null;

  /// クエリパラメータ。
  Map<String, dynamic>? get queryParameters => null;

  /// リクエストヘッダ。
  Map<String, dynamic>? get headers => null;

  /// ID トークンを必要とするかどうか。
  bool get requiresIdToken => true;
}

/// `GET /api/todos` のエンドポイント情報。
class TodosGetHttpEndpoint extends HttpEndpoint {
  /// `GET /api/todos` のエンドポイント情報を生成する。
  const TodosGetHttpEndpoint()
    : super(method: HttpMethod.get, contentType: HttpContentType.json);

  @override
  String get path => '/api/todos';
}

/// `POST /api/todos` のエンドポイント情報。
class TodosPostHttpEndpoint extends HttpEndpoint {
  /// `POST /api/todos` のエンドポイント情報を生成する。
  const TodosPostHttpEndpoint({required this.title, required this.description})
    : super(method: HttpMethod.post, contentType: HttpContentType.json);

  /// Todo のタイトル。
  final String title;

  /// Todo の説明。
  final String description;

  @override
  String get path => '/api/todos';

  @override
  Map<String, dynamic>? get requestBody => {
    'title': title,
    'description': description,
  };
}
