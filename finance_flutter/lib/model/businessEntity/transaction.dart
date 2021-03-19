import 'package:finance_flutter/model/businessEntity/category.dart';

class Transaction {
  int userId;
  int transactionId;
  DateTime date;
  Category category;
  String description;
  double amount;

  Transaction();

  Transaction.allArgs({this.userId, this.transactionId, this.date, this.category,
      this.description, this.amount});

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction.allArgs(
      userId: json['userId'],
      transactionId: json['transactionId'],
      date: DateTime.parse(json['date']),
      category: json['category'],
      description: json['description'],
      amount: json['amount']
    );
  }

  @override
  String toString() {
    return 'Transaction{userId: $userId, transactionId: $transactionId, date: $date, category: $category, description: $description, amount: $amount}';
  }
}
