/// `--dart-define` で与える Flavor 一覧。
enum Flavor {
  /// dev 環境。
  dev,

  /// prod 環境。
  prod;

  /// サーバとの通信時に用いられるベース URL.
  String get serverBaseUrl => switch (this) {
    Flavor.dev =>
      'https://architecture-sample-app-dev.saigusa758cloudy.workers.dev',
    Flavor.prod =>
      'https://architecture-sample-app.saigusa758cloudy.workers.dev',
  };

  /// 開発環境（本番環境でない）かどうか。
  bool get isDev => this != Flavor.prod;
}
