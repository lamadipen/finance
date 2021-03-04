import 'package:finance_flutter/utils/state_management/finance_bloc_observer.dart';
import 'package:finance_flutter/utils/state_management/transaction_state/transaction_bloc.dart';
import 'package:finance_flutter/view/home/welcomePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  Bloc.observer = FinanceBlocObserver();
  runApp(
    BlocProvider(
        create: (context) {
          return TransactionBloc()..add(TransactionsLoadedEvent());
        },
        child: MediaQuery(
            data: MediaQueryData(),
            child: FinanceApp())
    ),
  );
}

class FinanceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        theme: ThemeData(
          // Add the 3 lines from here...
          primaryColor: Colors.blueAccent,
        ),
        home: WelcomePage()
    );
  }
}
