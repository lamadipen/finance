import 'dart:async';

import 'package:flutter/material.dart';

class FlutterBlocLocalizations {
  static FlutterBlocLocalizations of(BuildContext context) {
    return Localizations.of<FlutterBlocLocalizations>(
      context,
      FlutterBlocLocalizations,
    );
  }

  String get appTitle => "Flutter Finance";
}

class FlutterBlocLocalizationsDelegate extends LocalizationsDelegate<FlutterBlocLocalizations> {

  @override
  bool isSupported(Locale locale) {
      locale.languageCode.toLowerCase().contains("en");
  }

  @override
  bool shouldReload(LocalizationsDelegate old) {
    return false;
  }

  @override
  Future<FlutterBlocLocalizations> load(Locale locale) {
    return Future(() => FlutterBlocLocalizations());
  }
}
