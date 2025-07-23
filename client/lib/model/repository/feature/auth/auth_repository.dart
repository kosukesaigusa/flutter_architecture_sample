import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../util/result.dart';
import '../../../entity/auth/auth.dart';
import '../../../service/feature/auth/auth_service.dart';

part 'auth_repository.g.dart';

/// [AuthRepository] クラスのインスタンスを提供する。
@riverpod
AuthRepository authRepository(Ref ref) => AuthRepository(ref);

/// 認証関係の通信を行うリポジトリクラス。
class AuthRepository {
  /// [AuthRepository] を生成する。
  const AuthRepository(this._ref);

  final Ref _ref;

  /// IdToken を取得する。
  Future<String?> fetchIdToken() => _ref.read(authServiceProvider).getIdToken();

  /// 認証情報を取得する。
  Future<Auth?> fetchAuth() async {
    final auth = await _ref.read(authServiceProvider).fetchAuth();
    if (auth == null) {
      return null;
    }
    return Auth(
      userId: auth.userId,
      email: auth.email,
      isEmailVerified: auth.isEmailVerified,
    );
  }

  /// メールアドレスとパスワードでサインインする。
  Future<Result<Auth, void>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final result = await _ref
        .read(authServiceProvider)
        .signInWithEmailAndPassword(email: email, password: password);
    switch (result) {
      case SuccessResult(:final data):
        return Result.success(
          data: Auth(
            userId: data.userId,
            email: data.email,
            isEmailVerified: data.isEmailVerified,
          ),
        );
      case FailureResult(:final e):
        return Result.failure(e: e, data: null);
    }
  }

  /// メールアドレスとパスワードでサインアップする。
  Future<Result<Auth, void>> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final result = await _ref
        .read(authServiceProvider)
        .signUpWithEmailAndPassword(email: email, password: password);
    switch (result) {
      case SuccessResult(:final data):
        return Result.success(
          data: Auth(
            userId: data.userId,
            email: data.email,
            isEmailVerified: data.isEmailVerified,
          ),
        );
      case FailureResult(:final e):
        return Result.failure(e: e, data: null);
    }
  }

  /// ログアウトする。
  Future<void> signOut() => _ref.read(authServiceProvider).signOut();
}
