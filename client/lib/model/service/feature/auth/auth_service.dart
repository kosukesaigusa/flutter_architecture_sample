import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../external/firebase_auth/firebase_auth_client.dart';
import '../../../../util/result.dart';
import 'auth_dto.dart';

part 'auth_service.g.dart';

/// [AuthService] クラスのインスタンスを提供する。
@riverpod
AuthService authService(Ref ref) => AuthService(ref);

/// 認証関係のサービスクラス。
class AuthService {
  /// [AuthService] を生成する。
  const AuthService(this._ref);

  final Ref _ref;

  /// IdToken を取得する。
  Future<String?> getIdToken() =>
      _ref.read(firebaseAuthClientProvider).getIdToken();

  /// 認証情報を取得する。
  Future<AuthDto?> fetchAuth() async {
    final result = await _ref
        .read(firebaseAuthClientProvider)
        .fetchCurrentUser();
    if (result == null) {
      return null;
    }
    return AuthDto(
      userId: result.userId,
      email: result.email,
      isEmailVerified: result.isEmailVerified,
    );
  }

  /// メールアドレスとパスワードでサインインする。
  Future<Result<AuthDto, void>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final result = await _ref
        .read(firebaseAuthClientProvider)
        .signInWithEmailAndPassword(email: email, password: password);
    switch (result) {
      case SuccessResult(:final data):
        return Result.success(
          data: AuthDto(
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
  Future<Result<AuthDto, void>> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final result = await _ref
        .read(firebaseAuthClientProvider)
        .signUpWithEmailAndPassword(email: email, password: password);
    switch (result) {
      case SuccessResult(:final data):
        return Result.success(
          data: AuthDto(
            userId: data.userId,
            email: data.email,
            isEmailVerified: data.isEmailVerified,
          ),
        );
      case FailureResult(:final e):
        return Result.failure(e: e, data: null);
    }
  }

  /// サインアウトする。
  Future<void> signOut() => _ref.read(firebaseAuthClientProvider).signOut();
}
