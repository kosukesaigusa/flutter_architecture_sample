import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../account/account_page/account_page.dart';
import '../todo/todos_page/todos_page.dart';
import 'top_page_handler.dart';

/// アプリのトップページ。
class TopPage extends ConsumerStatefulWidget {
  /// [TopPage] を生成する。
  const TopPage({super.key});

  @override
  ConsumerState<TopPage> createState() => _TopPageState();
}

class _TopPageState extends ConsumerState<TopPage> {
  var _selectedIndex = 0;

  static const _pages = <Widget>[TodosPage(), AccountPage()];

  void _onIndexChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Todo'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) => ref
            .read(topPageHandlerProvider)
            .chooseTab(index: index, onTabChanged: _onIndexChanged),
      ),
    );
  }
}
