import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../repository/feature/auth/auth_repository.dart';

part 'fetch_id_token.g.dart';

/// [FetchIdTokenUseCase] クラスのインスタンスを提供する。
@riverpod
FetchIdTokenUseCase fetchIdTokenUseCase(Ref ref) => FetchIdTokenUseCase(ref);

/// IdToken を取得するユースケース。
class FetchIdTokenUseCase {
  /// [FetchIdTokenUseCase] を生成する。
  FetchIdTokenUseCase(this._ref);

  final Ref _ref;

  /// IdToken を取得する。
  Future<String?> invoke() => _ref.read(authRepositoryProvider).fetchIdToken();
}
