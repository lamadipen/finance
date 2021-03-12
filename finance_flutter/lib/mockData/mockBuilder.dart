import 'package:finance_flutter/model/businessEntity/category.dart';
import 'package:finance_flutter/model/businessEntity/transaction.dart';

class MockBuilder {
  static List<Transaction> buildTransactions() {
    Category expenses =
        new Category(id: 1, name: "Travel", categoryType: "expenses");
    Category revenue =
        new Category(id: 2, name: "Sales", categoryType: "revenue");
    List<Transaction> transactions = [];
    transactions.add(Transaction.allArgs(
        userId: 200,
        transactionId: 2,
        date: DateTime(2020, 2, 4),
        category: expenses,
        description: "Purchased Some goods",
        amount: 100.0));
    transactions.add(Transaction.allArgs(
        userId: 300,
        transactionId: 1,
        date: DateTime(2020, 2, 10),
        category: revenue,
        description: "Sold Some goods",
        amount: 500.0));
    transactions.add(Transaction.allArgs(
        userId: 500,
        transactionId: 3,
        date: DateTime(2021, 1, 10),
        category: expenses,
        description: "Travle ",
        amount: 800.0));
    transactions.add(Transaction.allArgs(
        userId: 1000,
        transactionId: 4,
        date: DateTime(2021, 2, 150),
        category: revenue,
        description: "Sold Property",
        amount: 200.0));
    transactions.add(Transaction.allArgs(
        userId: 3000,
        transactionId: 5,
        date: DateTime(2021, 5, 150),
        category: expenses,
        description: "Purchased Car",
        amount: 6000.0));
    transactions.add(Transaction.allArgs(
        userId: 3600,
        transactionId: 6,
        date: DateTime(2021, 2, 100),
        category: expenses,
        description: "Purchased Car",
        amount: 6000.0));
    transactions.add(Transaction.allArgs(
        userId: 3200,
        transactionId: 7,
        date: DateTime(2021, 4, 69),
        category: expenses,
        description: "Purchased Car",
        amount: 1788.0));
    transactions.add(Transaction.allArgs(
        userId: 100,
        transactionId: 8,
        date: DateTime(2021, 3, 150),
        category: expenses,
        description: "Purchased Car",
        amount: 10.0));
    transactions.add(Transaction.allArgs(
        userId: 349,
        transactionId: 9,
        date: DateTime(2021, 8, 10),
        category: expenses,
        description: "Purchased Car",
        amount: 300.0));
    return transactions;
  }

  static List<Category> buildCategories() {
    List<Category> categories = [];
    Category expenses =
        new Category(id: 1, name: "Travel", categoryType: "expenses");
    Category revenue =
        new Category(id: 2, name: "Sales", categoryType: "revenue");
    categories.add(expenses);
    categories.add(revenue);

    return categories;
  }
}
