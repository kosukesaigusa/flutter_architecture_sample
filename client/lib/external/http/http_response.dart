import 'package:freezed_annotation/freezed_annotation.dart';

part 'http_response.freezed.dart';

/// HTTP レスポンスの成功失敗を freezed の sealed class でまとめて表現するクラス。
@freezed
sealed class HttpResponse<T> with _$HttpResponse<T> {
  /// 成功時のレスポンス。
  ///
  /// - [data] は HTTP のレスポンスボディ。
  /// - [headers] は HTTP のレスポンスヘッダ。
  const factory HttpResponse.success({
    required T data,
    required Map<String, List<String>> headers,
  }) = SuccessHttpResponse<T>;

  /// 失敗時のレスポンス。
  ///
  /// - [data] は存在する場合の HTTP のレスポンスボディ（エラーレスポンスでは一般にレスポンス
  /// ボディが存在しない場合もあるので任意である）。
  /// - [e] は HTTP リクエスト時に発生した例外。
  /// - [status] は HTTP エラーの種別。
  const factory HttpResponse.failure({
    T? data,
    required Object e,
    required ErrorStatus status,
  }) = FailureHttpResponse<T>;
}

/// HTTP レスポンスの主なエラーの種別を表現する列挙型。
enum ErrorStatus {
  /// 400 Bad Request に対応するエラー。
  badRequest,

  /// 401 Unauthorized に対応するエラー。
  unauthorized,

  /// 403 Forbidden に対応するエラー。
  forbidden,

  /// 404 Not Found に対応するエラー。
  notFound,

  /// 500 Internal Server Error に対応するエラー。
  internalServerError,

  /// 503 Service Unavailable に対応するエラー。
  serviceUnavailable,

  /// 504 Gateway Timeout に対応するエラー。
  gatewayTimeout,

  /// その他のエラー。
  unknown;

  /// エラーの種別を HTTP ステータスコードから判定する。
  factory ErrorStatus.fromStatusCode(int statusCode) => switch (statusCode) {
    400 => ErrorStatus.badRequest,
    401 => ErrorStatus.unauthorized,
    403 => ErrorStatus.forbidden,
    404 => ErrorStatus.notFound,
    500 => ErrorStatus.internalServerError,
    503 => ErrorStatus.serviceUnavailable,
    504 => ErrorStatus.gatewayTimeout,
    _ => ErrorStatus.unknown,
  };

  /// エラーの種別を文字列で表現する。
  String get toStatusString => switch (this) {
    ErrorStatus.badRequest => '400 Bad Request',
    ErrorStatus.unauthorized => '401 Unauthorized',
    ErrorStatus.forbidden => '403 Forbidden',
    ErrorStatus.notFound => '404 Not Found',
    ErrorStatus.internalServerError => '500 Internal Server Error',
    ErrorStatus.serviceUnavailable => '503 Service Unavailable',
    ErrorStatus.gatewayTimeout => '504 Gateway Timeout',
    ErrorStatus.unknown => 'Unknown',
  };

  /// エラーの種別を HTTP ステータスコードに変換する。
  int get toStatusCode => switch (this) {
    ErrorStatus.badRequest => 400,
    ErrorStatus.unauthorized => 401,
    ErrorStatus.forbidden => 403,
    ErrorStatus.notFound => 404,
    ErrorStatus.internalServerError => 500,
    ErrorStatus.serviceUnavailable => 503,
    ErrorStatus.gatewayTimeout => 504,
    // NOTE: エラーの種別が不明な場合は代わりに 0 を返す。
    ErrorStatus.unknown => 0,
  };
}
