import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => SplashPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.network(
          'https://picsum.photos/250?image=9',
          key: const Key('splash_bloc_image'),
          width: 150,
        ),
      ),
    );
  }
}