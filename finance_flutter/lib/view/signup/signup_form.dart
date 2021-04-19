import 'package:finance_flutter/model/businessEntity/role.dart';
import 'package:finance_flutter/model/businessEntity/user.dart';
import 'package:finance_flutter/repositories/user_repositories.dart';
import 'package:finance_flutter/state_management/authentication_state/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AddCompanyState();

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => SignUpForm());
  }
}

class AddCompanyState extends State<SignUpForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController dateController = TextEditingController();
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;
  FocusNode _company;
  String company;

  @override
  Widget build(BuildContext context) {
    const sizedBoxSpace = SizedBox(height: 24);

    return Scaffold(
      body: Align(
        alignment: const Alignment(0, -1 / 3),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Form(
                key: _formKey,
                autovalidateMode: _autoValidateMode,
                child: Scrollbar(
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    children: [
                      sizedBoxSpace,
                      TextFormField(
                        focusNode: _company,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          icon: const Icon(Icons.text_snippet_outlined),
                          border: const OutlineInputBorder(),
                          labelText: "Company",
                        ),
                        maxLines: 1,
                        validator: _validateInputString,
                        onSaved: (value) {
                          company = value;
                        },
                      ),
                      sizedBoxSpace,
                      ElevatedButton(
                        child: Text("Submit"),
                        onPressed: _handleSubmitted,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _handleSubmitted() {
    final form = _formKey.currentState;
    if (!form.validate()) {
      _autoValidateMode =
          AutovalidateMode.always; // Start validating on every change.
      showInSnackBar(
        "Invalid Input, Please Enter Correct Value",
      );
    } else {
      form.save();
      print(company);

      var user2 = BlocProvider.of<AuthenticationBloc>(context).state.user;
       print("Save Button clicked $user2");
      //ToDO Call the API to save the data
      showInSnackBar("Saving Please Wait...");
      UserRepositoryImpl userRepository = UserRepositoryImpl();
      List<String> companies = [];
      companies.add(company);
      print("companies ${companies}");
      var freshUser = FlutterFinanceUser(email: user2.email, id: user2.id, name: user2.name, role: Role.ADMIN, companies: companies);

      print("fresh user ${freshUser}");
      userRepository.addNewFlutterFinanceUser(freshUser);

      BlocProvider.of<AuthenticationBloc>(context).add(AuthenticationUserChangedEvent(freshUser));
    }
  }

  String _validateInputString(String value) {
    if (value.isEmpty) {
      return "Please enter value in this filed.";
    }
    return null;
  }

  void showInSnackBar(String value) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(value),
    ));
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextButton(
      key: const Key('signUpForm_createAccount_flatButton'),
      child: Text(
        'Add Company Name',
        style: TextStyle(color: theme.primaryColor),
      ),
      // onPressed: () => Navigator.of(context).push<void>(SignUpPage.route()),
    );
  }
}
