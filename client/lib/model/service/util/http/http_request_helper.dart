import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../external/http/content_type.dart';
import '../../../../external/http/extract_http_request_headers.dart';
import '../../../../external/http/http_client.dart';
import '../../../../external/http/http_method.dart';
import '../../../../external/http/http_response.dart';
import '../../../../util/multi_part_form_data/multi_part_form_data.dart';
import 'http_endpoint.dart';

part 'http_request_helper.g.dart';

/// [HttpRequestHelper] クラスのインスタンスを提供する。
@riverpod
HttpRequestHelper httpRequestHelper(Ref ref) => HttpRequestHelper(ref);

///  サーバへの HTTP リクエストを行うためのヘルパークラス。
/// 暗号化（該当する場合）
class HttpRequestHelper {
  /// [HttpRequestHelper] を生成する。
  HttpRequestHelper(this._ref);

  final Ref _ref;

  ///  サーバへの HTTP リクエストを行う。
  Future<HttpResponse<dynamic>> request(HttpEndpoint endpoint) async {
    // 各条件からリクエストヘッダを作成する。
    final extendedHeaders = {
      ...endpoint.headers ?? {},
      // 与えられたヘッダに Content-Type を追加する。
      'Content-Type': endpoint.contentType.value,
      // その他のヘッダを追加する。
      ...await _ref.read(extractHttpRequestHeadersProvider)(),
    };
    return _request(
      method: endpoint.method,
      endpointPath: endpoint.path,
      contentType: endpoint.contentType,
      data: endpoint.requestBody,
      queryParameters: endpoint.queryParameters,
      headers: extendedHeaders,
    );
  }

  ///  サーバへの HTTP リクエストを行う。
  ///
  /// - [method] には HTTP メソッドを与える。
  /// - [endpointPath] にはリクエスト先のパスを与える。
  /// - [contentType] にはコンテントタイプを与える。
  /// - 任意で [data] にはリクエストボディを与える。
  /// - 任意で [queryParameters] にはクエリパラメータを与える。
  /// - 任意で [headers] にはリクエストヘッダを与える。
  Future<HttpResponse<dynamic>> _request({
    required HttpMethod method,
    required String endpointPath,
    required HttpContentType contentType,
    required Map<String, dynamic>? data,
    required Map<String, dynamic>? queryParameters,
    required Map<String, dynamic>? headers,
  }) async {
    // HttpClient を通じて HTTP リクエストを行い、結果 (HttpResponse) を返す。
    final result = await _ref
        .read(httpClientProvider)
        .request(
          method: method,
          path: endpointPath,
          queryParameters: queryParameters,
          data: switch (method) {
            HttpMethod.post ||
            HttpMethod.put ||
            HttpMethod.patch => switch (contentType) {
              // NOTE: マルチパートリクエストの場合は data を整形する。その際、やや雑だが
              // non-null assertion でリクエストボディが null でない前提としている。
              HttpContentType.multipartFormData => MultiPartRequestData.fromMap(
                data!,
              ),
              _ => data ?? {},
            },
            _ => null,
          },
          headers: headers,
        );
    switch (result) {
      case SuccessHttpResponse():
        return result;
      case FailureHttpResponse():
        return result;
    }
  }
}
