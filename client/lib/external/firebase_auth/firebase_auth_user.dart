import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'firebase_auth_user.freezed.dart';

/// [FirebaseAuth] のユーザー情報を表すクラス。
@freezed
class FirebaseAuthUser with _$FirebaseAuthUser {
  /// [FirebaseAuthUser] を生成する。
  const factory FirebaseAuthUser({
    required String userId,
    required String email,
    required bool isEmailVerified,
  }) = _FirebaseAuthUser;
}
