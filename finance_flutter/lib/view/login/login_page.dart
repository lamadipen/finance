import 'package:finance_flutter/service/authentication_service.dart';
import 'package:finance_flutter/state_management/login_state/login_cubit.dart';
import 'package:finance_flutter/view/login/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    print("Inside Loging page");
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocProvider(
            create: (_) => LoginCubit(context.read<AuthenticationService>()),
            child: LoginForm(),
          )),
    );
  }
}
