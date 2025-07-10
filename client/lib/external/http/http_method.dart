/// HTTP メソッドの列挙型。
enum HttpMethod {
  /// GET メソッド。
  get,

  /// POST メソッド。
  post,

  /// PUT メソッド。
  put,

  /// DELETE メソッド。
  delete,

  /// PATCH メソッド。
  patch,
  ;

  /// HTTP メソッドを文字列に変換する。
  String toHttpString() {
    switch (this) {
      case HttpMethod.get:
        return 'GET';
      case HttpMethod.post:
        return 'POST';
      case HttpMethod.put:
        return 'PUT';
      case HttpMethod.delete:
        return 'DELETE';
      case HttpMethod.patch:
        return 'PATCH';
    }
  }
}
