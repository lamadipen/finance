part of 'tab_bloc.dart';

@immutable
abstract class TabState extends Equatable {
  const TabState();

  @override
  List<Object> get props => [];
}

class TabInitial extends TabState {}

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


