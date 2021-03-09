import 'package:finance_flutter/state_management/finance_bloc_observer.dart';
import 'package:finance_flutter/state_management/tab_state/tab_bloc.dart';
import 'package:finance_flutter/state_management/transaction_state/transaction_bloc.dart';
import 'package:finance_flutter/view/home/welcomePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  Bloc.observer = FinanceBlocObserver();
  runApp(
    BlocProvider(
        create: (context) {
          return TabBloc()..add(TabPreInitializeEvent());
        },
        child: MediaQuery(data: MediaQueryData(), child: FinanceApp())),
  );
}

class FinanceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        locale: Locale("ne", "np"),
        theme: ThemeData(
          // Add the 3 lines from here...
          primaryColor: Colors.blueAccent,
        ),
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en', ''),
          const Locale('ar', ''),
          const Locale('ne', ''),
          const Locale('es', ''),
        ],
        home: MultiBlocProvider(
          providers: [
            BlocProvider<TransactionBloc>(
              create: (BuildContext context) =>
                  TransactionBloc()..add(TransactionsLoadedEvent()),
            ),
          ],
          child: WelcomePage(),
        ));
  }
}
