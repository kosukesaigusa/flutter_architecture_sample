import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../model/logic/feature/auth/auth.dart';
import 'account_page_handler.dart';

/// アカウントページ。
class AccountPage extends ConsumerWidget {
  /// [AccountPage] を生成する。
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSignedInAsyncValue = ref.watch(isSignedInProvider);
    return Scaffold(
      appBar: AppBar(title: Text('アカウント ${isSignedInAsyncValue.valueOrNull}')),
      body: isSignedInAsyncValue.when(
        data: (isSignedIn) => Center(
          child: isSignedIn
              ? ElevatedButton(
                  onPressed: () =>
                      ref.read(accountPageHandlerProvider).logout(context),
                  child: const Text('ログアウト'),
                )
              : ElevatedButton(
                  onPressed: () =>
                      ref.read(accountPageHandlerProvider).login(context),
                  child: const Text('ログイン'),
                ),
        ),
        error: (_, _) => const Center(child: Text('エラーが発生しました。')),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
