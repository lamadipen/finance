import 'package:finance_flutter/state_management/finance_bloc_observer.dart';
import 'package:finance_flutter/state_management/tab_state/tab_bloc.dart';
import 'package:finance_flutter/state_management/transaction_state/transaction_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return CircularProgressIndicator();
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return mainPage;
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return loadingScreen;
      },
    );
  }

  var mainPage = MaterialApp(
      title: "Hey",
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
        // child: WelcomePage(),
        child: MyHomePage(title: "POC"),
      ));

  var loadingScreen = MaterialApp(
      title: "Loading Screen",
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
        child: CircularProgressIndicator(),
      ));
}

// Future<UserCredential> signInWithFacebook() async {
//   // Trigger the sign-in flow
//   final accessToken = await FacebookAuth.instance.login();
//
//   // Create a credential from the access token
//   final FacebookAuthCredential facebookAuthCredential =
//   FacebookAuthProvider.credential(accessToken.token);
//
//   // Once signed in, return the UserCredential
//   return await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
// }

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FacebookAuth _fbAuth = FacebookAuth.instance;
  User user;
//4
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          Builder(builder: (BuildContext context) {
//5
            return FlatButton(
              child: const Text('Sign out'),
              textColor: Theme.of(context).buttonColor,
              onPressed: () async {
                final User user = await _auth.currentUser;
                if (user == null) {
//6
                  Scaffold.of(context).showSnackBar(const SnackBar(
                    content: Text('No one has signed in.'),
                  ));
                  return;
                }
                await _auth.signOut();
                final String uid = user.uid;
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(uid + ' has successfully signed out.'),
                ));
              },
            );
          })
        ],
      ),
      body: Center(
          child: Column(
        children: [
          FlatButton(
              onPressed: () {
                signInWithFacebook();
              },
              child: Text("Sign In With GitHub")),
          Text((user != null) ? user.displayName : "Not logged in"),
        ],
      )),
    );
  }

  void signOut() async {
    await _auth.signOut().then((value) => {
      setState(() {
        user = null;
      })
    });
  }

  void signInWithGitHub() async {

  }


  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final AccessToken accessToken = await _fbAuth.login();

    // Create a credential from the access token
    final FacebookAuthCredential facebookAuthCredential =
    FacebookAuthProvider.credential(accessToken.token);

    // Once signed in, return the UserCredential
    return await _auth.signInWithCredential(facebookAuthCredential);
  }
}
