import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:finance_flutter/model/viewEntity/tabInfo.dart';
import 'package:meta/meta.dart';

part 'tab_event.dart';

part 'tab_state.dart';

class TabBloc extends Bloc<TabEvent, TabState> {
  TabBloc() : super(TabInitial());

  @override
  Stream<TabState> mapEventToState(TabEvent event) async* {
    if(event is TabInitilizedEvent){

    }
  }

}
