import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(new MediaQuery(
      data: new MediaQueryData(),
      child: new MaterialApp(home: CupertinoTabBarDemo())
  ));
}

class _TabInfo {
  const _TabInfo(this.title, this.icon);

  final String title;
  final IconData icon;
}

class CupertinoTabBarDemo extends StatelessWidget {
  const CupertinoTabBarDemo();

  @override
  Widget build(BuildContext context) {
    List<_TabInfo> _tabInfo = buildTabInfo();

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

  List<_TabInfo> buildTabInfo() {
     final _tabInfo = [
      _TabInfo(
        "Dashboard",
        CupertinoIcons.home,
      ),
      _TabInfo(
        "Transactions",
        CupertinoIcons.list_bullet,
      ),
      _TabInfo(
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
      child: Center(
        child: Icon(
          icon,
          semanticLabel: title,
          size: 100,
        ),
      ),
    );
  }
}


