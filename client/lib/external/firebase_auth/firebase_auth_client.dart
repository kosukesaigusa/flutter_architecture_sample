import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../util/logger.dart';
import '../../util/result.dart';
import 'firebase_auth_user.dart';

part 'firebase_auth_client.g.dart';

/// [FirebaseAuthClient] クラスのインスタンスを提供する。
@riverpod
FirebaseAuthClient firebaseAuthClient(Ref ref) =>
    FirebaseAuthClient(FirebaseAuth.instance);

/// [FirebaseAuth] の機能を提供するクライアントクラス。
class FirebaseAuthClient {
  /// [FirebaseAuthClient] を生成する。
  FirebaseAuthClient(this._firebaseAuth);

  final FirebaseAuth _firebaseAuth;

  /// 現在のユーザー情報を取得する。
  ///
  /// サインイン済みの場合に、非 null な値を返す。
  Future<FirebaseAuthUser?> fetchCurrentUser() async {
    final user = await FirebaseAuth.instance.authStateChanges().first;
    if (user == null) {
      return null;
    }
    return FirebaseAuthUser(
      userId: user.uid,
      email: user.email!,
      isEmailVerified: user.emailVerified,
    );
  }

  /// IdToken を取得する。
  Future<String?> getIdToken() async {
    final user = await FirebaseAuth.instance.authStateChanges().first;
    if (user == null) {
      return null;
    }
    return user.getIdToken();
  }

  /// メールアドレスとパスワードを用いてサインインする。
  ///
  /// - [email] には、メールアドレスを与える。
  /// - [password] には、パスワードを与える。
  Future<Result<FirebaseAuthUser, SignInOrSignUpWithEmailAndPasswordFailure>>
  signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredential.user;
      if (user == null) {
        logger.d('User is null after sign in');
        return Result.failure(
          e: null,
          data: SignInOrSignUpWithEmailAndPasswordFailure.unknown,
          stackTrace: StackTrace.current,
        );
      }
      return Result.success(
        data: FirebaseAuthUser(
          userId: user.uid,
          email: user.email!,
          isEmailVerified: user.emailVerified,
        ),
      );
    } on FirebaseAuthException catch (e) {
      logger.e(e);
      return _handleSignInOrSignUpWithEmailAndPasswordFailure(e);
    } on Exception catch (e) {
      logger.e(e);
      return Result.failure(
        data: SignInOrSignUpWithEmailAndPasswordFailure.unknown,
        e: e,
        stackTrace: StackTrace.current,
      );
    }
  }

  /// メールアドレスとパスワードサインアップする。
  Future<Result<FirebaseAuthUser, SignInOrSignUpWithEmailAndPasswordFailure>>
  signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredential.user;
      if (user == null) {
        logger.d('User is null after sign up');
        return Result.failure(
          e: null,
          data: SignInOrSignUpWithEmailAndPasswordFailure.unknown,
          stackTrace: StackTrace.current,
        );
      }
      return Result.success(
        data: FirebaseAuthUser(
          userId: user.uid,
          email: user.email!,
          isEmailVerified: user.emailVerified,
        ),
      );
    } on FirebaseAuthException catch (e) {
      logger.e(e);
      return _handleSignInOrSignUpWithEmailAndPasswordFailure(e);
    } on Exception catch (e) {
      logger.e(e);
      return Result.failure(
        data: SignInOrSignUpWithEmailAndPasswordFailure.unknown,
        e: e,
        stackTrace: StackTrace.current,
      );
    }
  }

  /// メールアドレスとパスワードでサインインまたはサインアップする際の失敗を処理する。
  FailureResult<FirebaseAuthUser, SignInOrSignUpWithEmailAndPasswordFailure>
  _handleSignInOrSignUpWithEmailAndPasswordFailure(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return FailureResult(
          data: SignInOrSignUpWithEmailAndPasswordFailure.invalidEmail,
          e: e,
          stackTrace: StackTrace.current,
        );
      case 'too-many-requests':
        return FailureResult(
          data: SignInOrSignUpWithEmailAndPasswordFailure.tooManyRequests,
          e: e,
          stackTrace: StackTrace.current,
        );
      case 'network-request-failed':
        return FailureResult(
          data: SignInOrSignUpWithEmailAndPasswordFailure.networkRequestFailed,
          e: e,
          stackTrace: StackTrace.current,
        );
      default:
        return FailureResult(
          data: SignInOrSignUpWithEmailAndPasswordFailure.unknown,
          e: e,
          stackTrace: StackTrace.current,
        );
    }
  }

  /// サインアウトする。
  Future<void> signOut() => _firebaseAuth.signOut();
}

/// メールアドレスとパスワードを用いてサインインまたはサインアップする際の失敗。
enum SignInOrSignUpWithEmailAndPasswordFailure {
  /// メールアドレスが無効である場合の失敗。
  invalidEmail,

  /// リクエストが多すぎる場合の失敗。
  tooManyRequests,

  /// ネットワークリクエストが失敗した場合の失敗。
  networkRequestFailed,

  /// その他の失敗。
  unknown,
}
