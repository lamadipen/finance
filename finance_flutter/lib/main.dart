import 'package:finance_flutter/bloc_barrel.dart';
import 'package:finance_flutter/mockData/mockBuilder.dart';
import 'package:finance_flutter/model/applicationEntity/TransactionBarrel.dart';
import 'package:finance_flutter/simple_bloc_observer.dart';
import 'package:finance_flutter/view/home/welcomePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(
      BlocProvider(
        create: (context){
          return TransactionBloc(
              transactionRepository: MockBuilder(),

          )..add(TransactionLoadSuccess());
        },
          child : new MediaQuery(
              data: new MediaQueryData(),
              child: new MaterialApp(
                  theme: ThemeData(
                    // Add the 3 lines from here...
                    primaryColor: Colors.blueAccent,
                  ),
                  home: WelcomePage()))
      ),
  );
}
