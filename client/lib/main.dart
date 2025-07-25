import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'external/config/flavor.dart';
import 'external/firebase/firebase.dart';
import 'external/http/extract_http_request_headers.dart';
import 'external/http/http_client.dart';
import 'external/package_info/package_info.dart';
import 'model/logic/feature/auth/fetch_id_token.dart';
import 'ui/page/top/top_page.dart';
import 'util/logger.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Flavor を環境変数から取得する。
  final flavor = Flavor.values.byName(const String.fromEnvironment('FLAVOR'));
  logger.d('flavor: $flavor');

  // 環境に応じた Firebase SDK を初期化する。
  final firebaseApp = switch (flavor) {
    Flavor.dev => await initializeDevFirebase(),
    Flavor.prod => await initializeProdFirebase(),
  };
  logger.d('Initialized FirebaseApp: ${firebaseApp.options.projectId}');

  // アプリのパッケージ情報を取得する。
  final packageInfo = await getPackageInfo();
  logger.d('PackageInfo: ${packageInfo.appName} (${packageInfo.version})');

  // ベース URL を与えて HttpClient のインスタンスを作成する。
  final httpClient = getHttpClient(baseUrl: flavor.serverBaseUrl);

  // ProviderContainer を生成し、上記の一連の初期化処理で得られたインスタンス等をオーバーライド
  // して使用する。
  final container = ProviderContainer(
    overrides: [
      extractHttpRequestHeadersProvider.overrideWith(
        (ref) => () async {
          final idToken = await ref.read(fetchIdTokenUseCaseProvider).invoke();
          logger.d('idToken: $idToken');
          return {'Authorization': 'Bearer $idToken'};
        },
      ),
      httpClientProvider.overrideWith((_) => httpClient),
      packageInfoProvider.overrideWith((_) => packageInfo),
    ],
  );

  // UncontrolledProviderScope に container を渡して、Flutter アプリを起動する。
  runApp(
    UncontrolledProviderScope(container: container, child: const MainApp()),
  );
}

/// アプリのメインウィジェット。
class MainApp extends StatelessWidget {
  /// [MainApp] を生成する。
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: TopPage());
  }
}
