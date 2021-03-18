import 'package:finance_flutter/service/authentication_service.dart';
import 'package:finance_flutter/state_management/authentication_state/authentication_bloc.dart';
import 'package:finance_flutter/state_management/finance_bloc_observer.dart';
import 'package:finance_flutter/view/home/splash_page.dart';
import 'package:finance_flutter/view/home_page.dart';
import 'package:finance_flutter/view/login/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  Bloc.observer = FinanceBlocObserver();

  // runApp(
  //   BlocProvider(
  //       create: (context) {
  //         return TabBloc()..add(TabPreInitializeEvent());
  //       },
  //       child: MediaQuery(data: MediaQueryData(), child: FinanceApp())),
  // );
  runApp(MediaQuery(
      data: MediaQueryData(),
      child: FinanceApp(
          authenticationService: AuthenticationService(),
          firebaseInitialization: _initialization)));
}

class FinanceApp extends StatelessWidget {
  final AuthenticationService authenticationService;
  final Future<FirebaseApp> firebaseInitialization;

  FinanceApp({
    Key key,
    @required this.authenticationService,
    @required this.firebaseInitialization,
  })  : assert(authenticationService != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: firebaseInitialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return CircularProgressIndicator();
        }
        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return RepositoryProvider.value(
            value: authenticationService,
            child: BlocProvider(
              create: (_) => AuthenticationBloc(authenticationService),
              // child: mainPage,
              child: AppView(),
            ),
          );
        }
        // Otherwise, show something whilst waiting for initialization to complete
        return SplashPage();
      },
    );
  }
}

class AppView extends StatefulWidget {
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Finance",
      theme: ThemeData(
        // Add the 3 lines from here...
        primaryColor: Colors.blueAccent,
      ),
      navigatorKey: _navigatorKey,
      locale: Locale("ne", "np"),
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
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                _navigator.pushAndRemoveUntil<void>(
                  HomePage.route(),
                  (route) => false,
                );
                break;
              case AuthenticationStatus.unauthenticated:
                _navigator.pushAndRemoveUntil<void>(
                  LoginPage.route(),
                  (route) => false,
                );
                break;
              default:
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}
