import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../model/logic/feature/auth/auth.dart';

part 'account_page_handler.g.dart';

/// [AccountPageHandler] クラスのインスタンスを提供する。
@riverpod
AccountPageHandler accountPageHandler(Ref ref) => AccountPageHandler(ref);

/// AccountPage の Handler.
class AccountPageHandler {
  /// [AccountPageHandler] を生成する。
  const AccountPageHandler(this._ref);

  final Ref _ref;

  /// ログインする。
  Future<void> login(BuildContext context) async {
    try {
      await _ref.read(authNotifierProvider.notifier).signIn();
      if (!context.mounted) {
        return;
      }
      await showDialog<void>(
        context: context,
        builder: (context) => const AlertDialog(content: Text('ログインしました')),
      );
    } on LoginException {
      if (!context.mounted) {
        return;
      }
      await showDialog<void>(
        context: context,
        builder: (context) => const AlertDialog(content: Text('ログインに失敗しました')),
      );
    }
  }

  /// ログアウトする。
  Future<void> logout(BuildContext context) async {
    await _ref.read(authNotifierProvider.notifier).signOut();
    if (!context.mounted) {
      return;
    }
    await showDialog<void>(
      context: context,
      builder: (context) => const AlertDialog(content: Text('ログアウトしました')),
    );
  }
}
