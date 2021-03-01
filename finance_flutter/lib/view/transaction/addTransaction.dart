import 'package:finance_flutter/model/businessEntity/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({Key key}) : super(key: key);

  @override
  AddTransactionState createState() => AddTransactionState();
}

class AddTransactionState extends State<AddTransaction> {
  String dropdownValue = 'One';
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
                  filled: true,
                  icon: const Icon(Icons.calendar_today),
                  hintText: "",
                  labelText: "Date"),
              onTap: () async {
                // Below line stops keyboard from appearing
                FocusScope.of(context).requestFocus(new FocusNode());
                _selectDate(context);
              },
              onSaved: (value) {
                transaction.date = DateTime.parse(value);
                _phoneNumber.requestFocus();
              },
              validator: _validateName,
            ),
            sizedBoxSpace,
            DropdownButtonFormField<String>(
              value: dropdownValue,
              onChanged: (String newValue) {
                setState(() {
                  dropdownValue = newValue;
                });
              },
              items: <String>['One', 'Two', 'Free', 'Four']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            sizedBoxSpace,
            TextFormField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: "Description",
              ),
              maxLines: 1,
            ),
            sizedBoxSpace,
            TextFormField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: "Amount",
                suffixText: "Rs",
              ),
              maxLines: 1,
            ),
            sizedBoxSpace,
            Center(
              child: ElevatedButton(
                child: Text("Submit"),
                onPressed: _handleSubmitted,
              ),
            ),
            sizedBoxSpace,
            Text(
              "",
              style: Theme.of(context).textTheme.caption,
            ),
            sizedBoxSpace,
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
        "",
      );
    } else {
      form.save();
      showInSnackBar("");
    }
    print(transaction);
  }

  String _validateName(String value) {
    if (value.isEmpty) {
      return "";
    }
    final nameExp = RegExp(r'^[A-Za-z ]+$');
    if (!nameExp.hasMatch(value)) {
      return "";
    }
    return null;
  }
}
