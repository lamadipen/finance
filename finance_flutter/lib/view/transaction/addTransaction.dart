import 'package:finance_flutter/mockData/mockBuilder.dart';
import 'package:finance_flutter/model/businessEntity/category.dart';
import 'package:finance_flutter/model/businessEntity/transaction.dart';
import 'package:finance_flutter/state_management/transaction_state/transaction_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({Key key}) : super(key: key);

  @override
  AddTransactionState createState() => AddTransactionState();
}

class AddTransactionState extends State<AddTransaction> {
  List<Category> categories = MockBuilder.buildCategories();
  Category selectedCategory = MockBuilder.buildCategories().first;
  DateTime selectedDate = DateTime.now();
  Transaction transaction = Transaction();
  TextEditingController dateController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;

  FocusNode _date;
  FocusNode _description;
  FocusNode _amount;
  FocusNode _category;
  FocusNode _phoneNumber;

  @override
  void initState() {
    super.initState();
    _date = FocusNode();
    _description = FocusNode();
    _amount = FocusNode();
    _category = FocusNode();
    _phoneNumber = FocusNode();
  }

  @override
  void dispose() {
    _date.dispose();
    _description.dispose();
    _amount.dispose();
    _category.dispose();
    _phoneNumber.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const sizedBoxSpace = SizedBox(height: 24);

    return Form(
      key: _formKey,
      autovalidateMode: _autoValidateMode,
      child: Scrollbar(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            sizedBoxSpace,
            TextFormField(
              controller: dateController,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                  icon: const Icon(Icons.calendar_today),
                  border: const OutlineInputBorder(),
                  labelText: "Date"),
              onTap: () async {
                // Below line stops keyboard from appearing
                FocusScope.of(context).requestFocus(new FocusNode());
                _selectDate(context);
              },
              onSaved: (value) {
                transaction.date = DateTime.parse(value);
                _category.requestFocus();
              },
            ),
            sizedBoxSpace,
            DropdownButtonFormField<Category>(
              focusNode: _category,
              decoration: InputDecoration(
                  icon: const Icon(Icons.category),
                  border: const OutlineInputBorder(),
                  labelText: 'Category'),
              onChanged: (Category newValue) {
                setState(() {
                  selectedCategory = newValue;
                });
              },
              onSaved: (value) {
                transaction.category = value;
                _description.requestFocus();
              },
              items:
                  categories.map<DropdownMenuItem<Category>>((Category value) {
                return DropdownMenuItem<Category>(
                  value: value,
                  child: Text(value.name),
                );
              }).toList(),
            ),
            sizedBoxSpace,
            TextFormField(
              focusNode: _description,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                icon: const Icon(Icons.text_snippet_outlined),
                border: const OutlineInputBorder(),
                labelText: "Description",
              ),
              maxLines: 1,
              validator: _validateInputString,
              onSaved: (value) {
                transaction.description = value;
                _amount.requestFocus();
              },
            ),
            sizedBoxSpace,
            TextFormField(
              focusNode: _amount,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                icon: const Icon(Icons.money_off),
                border: const OutlineInputBorder(),
                labelText: "Amount",
              ),
              maxLines: 1,
              validator: _validateInputAmount,
              onSaved: (value) {
                transaction.amount = double.parse(value);
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
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
    dateController.text = "${selectedDate.toLocal()}".split(' ')[0];
  }

  void showInSnackBar(String value) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(value),
    ));
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
      transaction.companyId = "2344";
      transaction.transactionId = "98765";
      BlocProvider.of<TransactionBloc>(context)
          .add(TransactionAddedEvent(transaction));
      print("Save Button clicked $transaction");
      //ToDO Call the API to save the data
      showInSnackBar("Saving Please Wait...");
      Navigator.of(context).pop();
    }
  }

  String _validateInputString(String value) {
    if (value.isEmpty) {
      return "Please enter value in this filed.";
    }
    return null;
  }

  String _validateInputAmount(String value) {
    if (value.isEmpty) {
      return "Please enter value in this filed.";
    }
    final nameExp = RegExp(r'^(-?)(0|([1-9][0-9]*))(\\.[0-9]+)?$');
    if (!nameExp.hasMatch(value)) {
      return "Please enter valid number.";
    }
    return null;
  }
}
