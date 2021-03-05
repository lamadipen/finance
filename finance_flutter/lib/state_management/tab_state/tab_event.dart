part of 'tab_bloc.dart';

@immutable
abstract class TabEvent extends Equatable{
  const TabEvent();

  @override
  List<Object> get props => [];
}

class TabPreInitializeEvent extends TabEvent{}

class TabInitializedEvent extends TabEvent{}

class TabUpdatedEvent extends TabEvent{
  final TabState tabState;

  const TabUpdatedEvent(this.tabState);

  @override
  List<Object> get props => [tabState];

  @override
  String toString() {
    return 'TabUpdatedEvent{tabState: $tabState}';
  }
}

