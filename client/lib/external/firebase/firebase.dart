import 'package:firebase_core/firebase_core.dart';

/// Develop 環境の Firebase を初期化する。
///
/// 本実装以外が、firebase_core パッケージに直接依存しないように、初期化メソッドをラップして呼び出す。
Future<FirebaseApp> initializeDevelopFirebase() => Firebase.initializeApp(
  // TODO: Develop 環境の Firebase のオプションを設定する。
  // options: develop.DefaultFirebaseOptions.currentPlatform,
);

/// Production 環境の Firebase を初期化する。
///
/// 本実装以外が、firebase_core パッケージに直接依存しないように、初期化メソッドをラップして呼び出す。
Future<FirebaseApp> initializeProductionFirebase() => Firebase.initializeApp(
  // TODO: Production 環境の Firebase のオプションを設定する。
  // options: production.DefaultFirebaseOptions.currentPlatform,
);
