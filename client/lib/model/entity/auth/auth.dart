import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth.freezed.dart';

/// 認証エンティティ。
@freezed
class Auth with _$Auth {
  /// 認証関係のデータを表すエンティティを生成する。
  const factory Auth({
    required String userId,
    required String email,
    required bool isEmailVerified,
  }) = _Auth;
}
