import 'package:finance_flutter/bloc_barrel.dart';
import 'package:finance_flutter/model/viewEntity/app_tab.dart';
import 'package:finance_flutter/view/transaction/listTransaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:finance_flutter/model/viewEntity/tabInfo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage();

  @override
  Widget build(BuildContext context) {
    List<TabInfo> _tabInfo = buildTabInfo();

    return BlocBuilder<TabBloc, AppTab>(builder: (context, activeTab) {
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
            switch (index) {
              case 0:
                return buildDashboardTab(index, _tabInfo);
                break;
              case 1:
                return buildTransactionTab(index, _tabInfo);
                break;
              default:
                return buildProfitLossTab(index, _tabInfo);
            }
          },
        ),
      );
    });
  }

  CupertinoTabView buildTransactionTab(int index, List<TabInfo> _tabInfo) {
    return CupertinoTabView(
      restorationScopeId: 'cupertino_tab_view_$index',
      builder: (context) => _CupertinoBaseTab(
          title: _tabInfo[index].title,
          icon: _tabInfo[index].icon,
          bodyWidget: ListTransaction()),
      defaultTitle: _tabInfo[index].title,
    );
  }

  CupertinoTabView buildDashboardTab(int index, List<TabInfo> _tabInfo) {
    return CupertinoTabView(
      restorationScopeId: 'cupertino_tab_view_$index',
      builder: (context) => _CupertinoBaseTab(
          title: _tabInfo[index].title,
          icon: _tabInfo[index].icon,
          bodyWidget: Center(
            child: Text("Welcome to dashboard"),
          )),
      defaultTitle: _tabInfo[index].title,
    );
  }

  CupertinoTabView buildProfitLossTab(int index, List<TabInfo> _tabInfo) {
    return CupertinoTabView(
      restorationScopeId: 'cupertino_tab_view_$index',
      builder: (context) => _CupertinoBaseTab(
          title: _tabInfo[index].title,
          icon: _tabInfo[index].icon,
          bodyWidget: Center(child: Text("Welcome to profit loss"))),
      defaultTitle: _tabInfo[index].title,
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

class _CupertinoBaseTab extends StatelessWidget {
  const _CupertinoBaseTab(
      {Key key,
      @required this.title,
      @required this.icon,
      @required this.bodyWidget})
      : super(key: key);

  final String title;
  final IconData icon;
  final Widget bodyWidget;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(),
        backgroundColor: CupertinoColors.systemBackground,
        child: bodyWidget);
  }
}
