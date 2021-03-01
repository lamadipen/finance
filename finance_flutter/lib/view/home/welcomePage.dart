import 'package:finance_flutter/view/transaction/listTransaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:finance_flutter/model/viewEntity/tabInfo.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage();

  @override
  Widget build(BuildContext context) {
    List<TabInfo> _tabInfo = buildTabInfo();

    return DefaultTextStyle(
      style: CupertinoTheme.of(context).textTheme.textStyle,
      child: CupertinoTabScaffold(
        restorationId: 'cupertino_tab_scaffold',
        tabBar: CupertinoTabBar(
          items: [
            for (final tabInfo in _tabInfo)
              BottomNavigationBarItem(
                label: tabInfo.title,
                icon: Icon(tabInfo.icon),
              ),
          ],
        ),
        tabBuilder: (context, index) {
          return CupertinoTabView(
            restorationScopeId: 'cupertino_tab_view_$index',
            builder: (context) => _CupertinoDemoTab(
              title: _tabInfo[index].title,
              icon: _tabInfo[index].icon,
            ),
            defaultTitle: _tabInfo[index].title,
          );
        },
      ),
    );
  }

  List<TabInfo> buildTabInfo() {
    final _tabInfo = [
      TabInfo(
        "Dashboard",
        CupertinoIcons.home,
      ),
      TabInfo(
        "Transactions",
        CupertinoIcons.list_bullet,
      ),
      TabInfo(
        "Profit & Loss",
        CupertinoIcons.book,
      ),
    ];
    return _tabInfo;
  }
}

class _CupertinoDemoTab extends StatelessWidget {
  const _CupertinoDemoTab({
    Key key,
    @required this.title,
    @required this.icon,
  }) : super(key: key);

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(),
      backgroundColor: CupertinoColors.systemBackground,
      child: new ListTransaction()
      // child: Center(
      //   child: Icon(
      //     icon,
      //     semanticLabel: title,
      //     size: 100,
      //   ),
      // ),
    );
  }
}

