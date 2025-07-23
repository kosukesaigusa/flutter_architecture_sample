import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../util/result.dart';
import '../../../entity/auth/auth.dart';
import '../../../repository/feature/auth/auth_repository.dart';

part 'auth.g.dart';

/// サインインしているかどうかを取得する。
@riverpod
Future<bool> isSignedIn(Ref ref) async {
  final auth = await ref.watch(authNotifierProvider.future);
  return auth != null;
}

/// 認証情報を管理する Notifier.
///
/// アプリの起動中はインスタンスを保持するために keepAlive: true を指定している。
@Riverpod(keepAlive: true)
class AuthNotifier extends _$AuthNotifier {
  @override
  Future<Auth?> build() async {
    final auth = await ref.read(authRepositoryProvider).fetchAuth();
    if (auth == null) {
      return null;
    }
    return auth;
  }

  /// ログインして、認証情報を更新する。
  ///
  /// ログインに失敗した場合は、[LoginException] がスローされる。
  Future<void> signIn() async {
    final result = await ref
        .read(authRepositoryProvider)
        .signInWithEmailAndPassword(
          email: 'test-1@example.com',
          password: '12345678',
        );
    switch (result) {
      case SuccessResult():
        ref.invalidateSelf();
        await future;
        return;
      case FailureResult():
        throw LoginException();
    }
  }

  /// ログアウトして、認証情報を更新する。
  Future<void> signOut() async {
    await ref.read(authRepositoryProvider).signOut();
    ref.invalidateSelf();
  }
}

/// ログインに失敗した際にスローされる例外。
class LoginException implements Exception {}
