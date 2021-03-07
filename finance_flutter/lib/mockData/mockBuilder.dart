import 'package:finance_flutter/model/businessEntity/category.dart';
import 'package:finance_flutter/model/businessEntity/transaction.dart';
import 'package:finance_flutter/service/transaction_service.dart';

class MockBuilder {
  static List<Transaction> buildTransactions() {
    Category expenses = new Category(id:1,name: "Travel",categoryType: "expenses");
    Category revenue = new Category(id:2, name: "Sales", categoryType: "revenue");
    List<Transaction> transactions = [];
    transactions.add(Transaction.allArgs(userId:200,transactionId:2,date:DateTime.now(), category:expenses,description: "Purchased Some goods", amount:1000.0));
    transactions.add(Transaction.allArgs(userId:300,transactionId:1,date:DateTime.now(), category:revenue, description:"Sold Some goods", amount:1000.0));
    transactions.add(Transaction.allArgs(userId:500,transactionId:3,date:DateTime.now(), category:expenses,description: "Travle ", amount:1000.0));
    transactions.add(Transaction.allArgs(userId:1000,transactionId:4,date:DateTime.now(), category:revenue, description:"Sold Property", amount:1000.0));
    transactions.add(Transaction.allArgs(userId:3000,transactionId:5,date:DateTime.now(), category:expenses,description: "Purchased Car", amount:1000.0));
    transactions.add(Transaction.allArgs(userId:3600,transactionId:6,date:DateTime.now(), category:expenses,description: "Purchased Car", amount:1000.0));
    transactions.add(Transaction.allArgs(userId:3200,transactionId:7,date:DateTime.now(), category:expenses,description: "Purchased Car", amount:1000.0));
    transactions.add(Transaction.allArgs(userId:100,transactionId:8,date:DateTime.now(), category:expenses,description: "Purchased Car", amount:1000.0));
    transactions.add(Transaction.allArgs(userId:349,transactionId:9,date:DateTime.now(), category:expenses,description: "Purchased Car", amount:1000.0));
    return transactions;
  }

  static List<Category> buildCategories() {
    List<Category> categories = [];
    Category expenses = new Category(id:1, name: "Travel", categoryType:"expenses");
    Category revenue = new Category(id:2,name: "Sales",categoryType: "revenue");
    categories.add(expenses);
    categories.add(revenue);

    return categories;
  }
}
