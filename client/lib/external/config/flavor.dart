/// `--dart-define` で与える Flavor 一覧。
enum Flavor {
  /// develop 環境。
  develop,

  /// production 環境。
  production;

  /// サーバとの通信時に用いられるベース URL.
  String get serverBaseUrl => switch (this) {
    Flavor.develop => 'https://dev.example.com',
    Flavor.production => 'https://example.com',
  };

  /// 開発環境（本番環境でない）かどうか。
  bool get isDevelopment => this != Flavor.production;
}
