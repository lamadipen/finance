import 'package:finance_flutter/model/businessEntity/category.dart';

class Transaction {
  int userId;
  int transactionId;
  DateTime date;
  Category category;
  String description;
  double amount;

  Transaction();

  Transaction.allArgs(this.userId, this.transactionId, this.date, this.category,
      this.description, this.amount);
}
