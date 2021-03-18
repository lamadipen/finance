import 'package:finance_flutter/model/viewEntity/tabInfo.dart';
import 'package:finance_flutter/state_management/tab_state/tab_bloc.dart';
import 'package:finance_flutter/view/home/datum_legend_with_measures.dart';
import 'package:finance_flutter/view/home/pie_char_page.dart';
import 'package:finance_flutter/view/home/points_line_chart.dart';
import 'package:finance_flutter/view/home/simple_series_legend.dart';
import 'package:finance_flutter/view/transaction/listTransaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabBloc, TabState>(builder: (context, state) {
      print(AppLocalizations.of(context).helloWorld);
      if (state is TabInitialState) {
        List<TabInfo> _tabInfo = state.tabInfo;
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
                  // return buildDashboardTab(index, _tabInfo);
                  return buildDashboardTabPoc(index, _tabInfo);
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
      } else {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
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
      builder: (context) {
        var dashBoardContainer = PieCharPage();
        return _CupertinoBaseTab(
            title: _tabInfo[index].title,
            icon: _tabInfo[index].icon,
            bodyWidget: dashBoardContainer);
      },
      defaultTitle: _tabInfo[index].title,
    );
  }

  CupertinoTabView buildDashboardTabPoc(int index, List<TabInfo> _tabInfo) {
    return CupertinoTabView(
      restorationScopeId: 'cupertino_tab_view_$index',
      builder: (context) {
        var dashboardSummaryRow = Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    'Sales YTD',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    '20000',
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    'Total Profit (Loss) YTD',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    '100000',
                  ),
                ),
              ],
            )
          ],
        );

        var dashBoardContainer = Container(
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.all(20),
          child: ListView(
            children: [
              Container(child: Expanded(child: dashboardSummaryRow)),
              const Divider(
                height: 20,
                thickness: 5,
                indent: 20,
                endIndent: 20,
              ),
              Container(height: 20),
              Container(child: PointsLineChart()),
              const Divider(
                height: 20,
                thickness: 5,
                indent: 20,
                endIndent: 20,
              ),
              Container(height: 20),
              Container(child: SimpleSeriesLegend()),
              const Divider(
                height: 20,
                thickness: 5,
                indent: 20,
                endIndent: 20,
              ),
              Container(height: 20),
              Container(child: DatumLegendWithMeasures()),
            ],
          ),
        );
        return _CupertinoBaseTab(
            title: _tabInfo[index].title,
            icon: _tabInfo[index].icon,
            bodyWidget: dashBoardContainer);
      },
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