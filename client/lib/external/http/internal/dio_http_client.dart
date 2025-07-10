import 'package:dio/dio.dart';

import 'interceptor/request_curl_logger_interceptor.dart';
import 'interceptor/request_header_interceptor.dart';

/// HTTP 接続が確立されるまでのタイムアウト時間
const _defaultConnectTimeoutDuration = Duration(seconds: 30);

/// HTTP 送信が送信されるまでのタイムアウト時間。
const _defaultSendTimeoutDuration = Duration(seconds: 30);

/// HTTP のデータが受信されるまでのタイムアウト時間。
const _defaultReceiveTimeoutDuration = Duration(seconds: 30);

/// [Dio] の基本オプションのデフォルト設定。
final _defaultBaseOptions = BaseOptions(
  connectTimeout: _defaultConnectTimeoutDuration,
  sendTimeout: _defaultSendTimeoutDuration,
  receiveTimeout: _defaultReceiveTimeoutDuration,
);

/// [Dio] を拡張した HTTP リクエストを行うためのクラス。
class DioHttpClient extends DioMixin implements Dio {
  /// [DioHttpClient] を生成する。
  ///
  /// - [baseUrl] には HTTP リクエストの基底 URL を与える。
  /// - 任意で [headers] には追加したいリクエストヘッダを与える。
  /// - 任意で [httpClientAdapter] には HTTP クライアントアダプタを与える。
  DioHttpClient({
    required String baseUrl,
    Map<String, dynamic>? headers,
    HttpClientAdapter? httpClientAdapter,
  }) {
    options = _defaultBaseOptions;
    options.baseUrl = baseUrl;

    this.httpClientAdapter = httpClientAdapter ?? HttpClientAdapter();

    interceptors.addAll([
      RequestHeaderInterceptor(headers),
      RequestCurlLoggerInterceptor(),
    ]);
  }
}
