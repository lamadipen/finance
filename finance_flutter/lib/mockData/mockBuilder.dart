import 'package:finance_flutter/model/businessEntity/category.dart';
import 'package:finance_flutter/model/businessEntity/transaction.dart';

class MockBuilder {
  static List<Transaction> transactions;

  static List<Transaction> buildTransactions() {
    transactions = [];
    Category expenses = new Category(1, "Travel", "expenses");
    Category revenue = new Category(2, "Sales", "revenue");

    transactions.add(Transaction.allArgs(200,1,DateTime.now(), expenses, "Purchased Some goods", 1000.0));
    transactions.add(Transaction.allArgs(300,1,DateTime.now(), revenue, "Sold Some goods", 1000.0));
    transactions.add(Transaction.allArgs(500,1,DateTime.now(), expenses, "Travle ", 1000.0));
    transactions.add(Transaction.allArgs(1000,1,DateTime.now(), revenue, "Sold Property", 1000.0));
    transactions.add(Transaction.allArgs(3000,1,DateTime.now(), expenses, "Purchased Car", 1000.0));
    return transactions;
  }

  static List<Category> buildCategories() {
    List<Category> categories = [];
    Category expenses = new Category(1, "Travel", "expenses");
    Category revenue = new Category(2, "Sales", "revenue");
    categories.add(expenses);
    categories.add(revenue);

    return categories;
  }

  Future saveTransactions(List<Transaction> transactions) {
      print(transactions);
  }
}
