import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_dto.freezed.dart';

/// 認証関係のデータを表す DTO.
@freezed
class AuthDto with _$AuthDto {
  /// 認証関係のデータを表す DTO を生成する。
  const factory AuthDto({
    required String userId,
    required String email,
    required bool isEmailVerified,
  }) = _AuthDto;
}
