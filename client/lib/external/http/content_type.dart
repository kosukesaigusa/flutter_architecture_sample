/// HTTP リクエストのコンテントタイプ。
enum HttpContentType {
  /// JSON 形式。
  json,

  /// URL エンコード形式。
  formUrlEncoded,

  /// マルチパートフォームデータ形式。
  multipartFormData;

  /// コンテントタイプの値を取得する。
  String get value => switch (this) {
    json => 'application/json',
    formUrlEncoded => 'application/x-www-form-urlencoded',
    multipartFormData => 'multipart/form-data',
  };
}
