import 'package:firebase_core/firebase_core.dart';

import 'dev_firebase_options.dart' as dev;
import 'prod_firebase_options.dart' as prod;

/// dev 環境の Firebase を初期化する。
///
/// 本実装以外が、firebase_core パッケージに直接依存しないように、初期化メソッドをラップして呼び出す。
Future<FirebaseApp> initializeDevFirebase() =>
    Firebase.initializeApp(options: dev.DefaultFirebaseOptions.currentPlatform);

/// prod 環境の Firebase を初期化する。
///
/// 本実装以外が、firebase_core パッケージに直接依存しないように、初期化メソッドをラップして呼び出す。
Future<FirebaseApp> initializeProdFirebase() => Firebase.initializeApp(
  options: prod.DefaultFirebaseOptions.currentPlatform,
);
