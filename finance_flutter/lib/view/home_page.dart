import 'package:finance_flutter/state_management/authentication_state/authentication_bloc.dart';
import 'package:finance_flutter/state_management/tab_state/tab_bloc.dart';
import 'package:finance_flutter/state_management/transaction_state/transaction_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home/welcomePage.dart';

class HomePage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomePage());
  }

  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);
    return Scaffold(
        body: MultiBlocProvider(
          providers: [
            BlocProvider<TabBloc>(
                create: (BuildContext context) =>
                    TabBloc()..add(TabPreInitializeEvent())),
            BlocProvider<TransactionBloc>(
              create: (BuildContext context) =>
                  TransactionBloc()..add(TransactionsLoadedEvent()),
            ),
          ],
          child: WelcomePage(),
        ));
  }
}