import 'package:finance_flutter/model/viewEntity/tab_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_tab.dart';

class TabBloc extends Bloc<TabEvent, AppTab> {
    TabBloc() : super(AppTab.transactions);

    @override
    Stream<AppTab> mapEventToState(TabEvent event) async* {
        if (event is TabUpdated) {
            yield event.tab;
        }
    }
}