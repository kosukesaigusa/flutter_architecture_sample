import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../util/logger.dart';

/// リクエストの内容を curl コマンドの形式で出力する dio パッケージの [Interceptor].
class RequestCurlLoggerInterceptor extends Interceptor {
  /// [RequestCurlLoggerInterceptor] を生成する。
  RequestCurlLoggerInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final stringBuffer = StringBuffer();
    final params = options.queryParameters;
    var query = '';
    if (options.method == 'GET' && params.isNotEmpty) {
      final queries = params.entries
          .map((e) {
            final key = e.key;
            final value = e.value;
            if (value is List) {
              return value.map((v) => '$key=$v').join('&');
            }
            return '$key=$value';
          })
          .join('&');
      query = '?$queries';
    }
    final requestUrl = '${options.baseUrl}${options.path}$query';
    stringBuffer.write("curl --request ${options.method} '$requestUrl'");
    for (final key in options.headers.keys) {
      stringBuffer.write(" -H '$key: ${options.headers[key]}'");
    }
    if (options.data != null) {
      if (options.data is Map) {
        stringBuffer.write(" --data-binary '${jsonEncode(options.data)}'");
      } else if (options.data is String) {
        stringBuffer.write(" --data-binary '${options.data}'");
      }
    }
    logger.d(stringBuffer.toString());
    super.onRequest(options, handler);
  }
}
