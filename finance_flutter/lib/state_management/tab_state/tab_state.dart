part of 'tab_bloc.dart';

@immutable
abstract class TabState extends Equatable {
  const TabState();

  @override
  List<Object> get props => [];
}

class TabInitialState extends TabState {
  final tabInfo = [
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

  @override
  List<Object> get props => [tabInfo];

  @override
  String toString() {
    return 'TabInitialState{tabInfo: $tabInfo}';
  }
}

class TabUpdatedState extends TabState {
  final TabInfo tabInfo;

  TabUpdatedState(this.tabInfo);

  @override
  List<Object> get props => [tabInfo];

  @override
  String toString() {
    return 'TabUpdatedState{tabInfo: $tabInfo}';
  }
}


