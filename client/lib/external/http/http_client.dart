import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:meta/meta.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../util/logger.dart';
import '../../util/multi_part_form_data/multi_part_form_data.dart';
import 'http_method.dart';
import 'http_response.dart';
import 'internal/dio_http_client.dart';
import 'internal/interceptor/multi_part_request.dart';

part 'http_client.g.dart';

/// [HttpClient] クラスのインスタンスを提供する。
///
/// 実際のアプリやユニットテストなどの動作環境によって適切な `ProviderScope` でオーバーライド
/// して使用される。
@riverpod
HttpClient httpClient(Ref ref) => throw UnimplementedError();

/// 与えられた [baseUrl] で [HttpClient] を作成する。
HttpClient getHttpClient({required String baseUrl}) =>
    HttpClient(baseUrl: baseUrl);

/// HTTP リクエストを行うクライアントクラス。
class HttpClient {
  /// [HttpClient] を生成する。
  ///
  /// - [baseUrl] にはリクエスト先のベース URL を与える。
  /// - 任意で [headers] には追加したいリクエストヘッダを与える。
  /// - テスト時にモックで差し替えたいときに [httpClientAdapter] には HTTP クライアントアダプタを与える。
  /// - テスト時にモックで差し替えたいときに [dioHttpClient] には Dio の HTTP クライアントを与える。
  HttpClient({
    required String baseUrl,
    Map<String, dynamic>? headers,
    @visibleForTesting HttpClientAdapter? httpClientAdapter,
    @visibleForTesting DioHttpClient? dioHttpClient,
  }) : _client =
           dioHttpClient ??
           DioHttpClient(
             baseUrl: baseUrl,
             headers: headers,
             httpClientAdapter: httpClientAdapter,
           );

  /// Dio の HTTP クライアントインスタンス。
  final DioHttpClient _client;

  /// HTTP リクエストを行う。
  ///
  /// - [method] には HTTP のリクエストメソッドを与える。
  /// - [path] にはリクエスト先のパスを与える。
  /// - 任意で [queryParameters] にはクエリパラメータを与える。
  /// - 任意で [data] にはリクエストボディを与える。
  /// - 任意で [headers] にはリクエストヘッダを与える。
  ///
  /// 返り値は [HttpResponse] であり、リクエストが成功した場合は [HttpResponse.success]
  /// が返る。
  ///
  /// リクエストが失敗した場合は、利用する側で dio パッケージに直接依存して [DioException] を
  /// 直接扱わないで済むように、[DioException] および [Exception] は内部でキャッチして、
  /// [HttpResponse.failure] を返す。
  Future<HttpResponse<dynamic>> request({
    required HttpMethod method,
    required String path,
    Map<String, dynamic>? queryParameters,
    Object? data,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _client.request<dynamic>(
        path,
        queryParameters: queryParameters,
        // マルチパートリクエストの場合は、自作の MultiPartRequestData 型から
        // dio の FormData 型に変換して利用する。
        data: data is MultiPartRequestData ? data.toDioFormData() : data,
        options: Options(
          method: method.toHttpString(),
          headers: headers,
          followRedirects: false,
          validateStatus: (status) => (status ?? 500) < 400,
        ),
      );
      return HttpResponse.success(
        data: response.data,
        headers: response.headers.map,
      );
    } on DioException catch (e) {
      return _httpResponseFromDioException(e);
    } on Exception catch (e) {
      logger.e(e);
      return HttpResponse.failure(e: e, status: ErrorStatus.unknown);
    }
  }

  /// [DioException] から [HttpResponse.failure] を生成する。
  ///
  /// - [DioException] 型の [e] にレスポンスが存在しない場合は、
  /// 直ちに [ErrorStatus.unknown] の失敗レスポンスを返す。
  /// - [DioException] 型の [e] にレスポンスが存在する場合は、
  /// ステータスコードに応じた [ErrorStatus] の失敗レスポンスを返す。
  ///
  /// ログ出力の内容は 下記の dio パッケージの README を参考にしている：
  ///
  /// https://pub.dev/packages/dio#handling-errors
  HttpResponse<dynamic> _httpResponseFromDioException(DioException e) {
    final requestOptions = e.requestOptions;
    final errorResponse = e.response;
    if (errorResponse == null) {
      logger.e('''
${requestOptions.method} ${requestOptions.path}

message: ${e.message}''');
      return HttpResponse.failure(e: e, status: ErrorStatus.unknown);
    }

    logger.e('''
statusCode: ${errorResponse.statusCode}

${requestOptions.method} ${requestOptions.path}
headers: ${errorResponse.headers}

data: ${errorResponse.data}''');

    final data = errorResponse.data;
    final statusCode = errorResponse.statusCode;

    if (statusCode == null) {
      return HttpResponse.failure(
        data: data,
        e: e,
        status: ErrorStatus.unknown,
      );
    }

    return HttpResponse.failure(
      data: data,
      e: e,
      status: ErrorStatus.fromStatusCode(statusCode),
    );
  }
}
