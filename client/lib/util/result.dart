import 'package:freezed_annotation/freezed_annotation.dart';

part 'result.freezed.dart';

/// 成功失敗を freezed の sealed class でまとめて表現するクラス。
@freezed
sealed class Result<S, E> with _$Result<S, E> {
  /// 成功時の結果。
  ///
  /// - [data] は成功時のデータ。
  const factory Result.success({required S data}) = SuccessResult<S, E>;

  /// 失敗時の結果。
  ///
  /// - [e] は発生した例外やエラー。
  /// - [data] は失敗時のデータや、失敗理由を表す値。
  /// - [stackTrace] は発生した例外やエラーのスタックトレース。
  const factory Result.failure({
    required Object? e,
    required E? data,
    StackTrace? stackTrace,
  }) = FailureResult<S, E>;
}
