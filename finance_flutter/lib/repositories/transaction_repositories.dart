import 'package:finance_flutter/model/businessEntity/transaction.dart';

abstract class TransactionRepository {
  Future<void> addNewTransaction(Transaction todo);

  Future<void> deleteTransaction(Transaction todo);

  Stream<List<Transaction>> transactions();

  Future<void> updateTransaction(Transaction todo);
}
