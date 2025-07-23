import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'top_page_handler.g.dart';

/// [TopPageHandler] クラスのインスタンスを提供する。
@riverpod
TopPageHandler topPageHandler(Ref ref) => const TopPageHandler();

/// TopPage の Handler.
class TopPageHandler {
  /// [TopPageHandler] を生成する。
  const TopPageHandler();

  /// タブを選択する。
  void chooseTab({
    required int index,
    required void Function(int) onTabChanged,
  }) => onTabChanged(index);
}
