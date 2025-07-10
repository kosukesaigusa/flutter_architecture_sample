import 'package:dio/dio.dart';

/// 与えられた [headers] のうち、値が `null` でないものをリクエストヘッダに追加する dio
/// パッケージの [Interceptor].
class RequestHeaderInterceptor extends Interceptor {
  /// [RequestHeaderInterceptor] を生成する。
  RequestHeaderInterceptor(this.headers);

  /// リクエストヘッダ。
  final Map<String, dynamic>? headers;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    for (final entry in (headers ?? {}).entries) {
      if (entry.value != null) {
        options.headers[entry.key] = entry.value;
      }
    }
    super.onRequest(options, handler);
  }
}
