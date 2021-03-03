import 'package:equatable/equatable.dart';
import 'package:finance_flutter/model/businessEntity/category.dart';

class Transaction  extends Equatable{
  int userId;
  int transactionId;
  DateTime date;
  Category category;
  String description;
  double amount;

  Transaction();

  Transaction.allArgs(this.userId, this.transactionId, this.date, this.category,
      this.description, this.amount);

  @override
  String toString() {
    return 'Transaction{userId: $userId, transactionId: $transactionId, date: $date, category: $category, description: $description, amount: $amount}';
  }

  @override
  List<Object> get props {
    return [transactionId];
  }
}