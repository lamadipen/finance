import 'package:finance_flutter/view/home/welcomePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(new MediaQuery(
      data: new MediaQueryData(),
      child: new MaterialApp(
          theme: ThemeData(
            // Add the 3 lines from here...
            primaryColor: Colors.blueAccent,
          ),
          home: WelcomePage())));
}
