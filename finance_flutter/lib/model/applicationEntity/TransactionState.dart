import 'package:equatable/equatable.dart';
import 'package:finance_flutter/model/businessEntity/transaction.dart';

abstract class TransactionState extends Equatable {
  const TransactionState();

  @override
  List<Object> get props => [];
}

class TransactionLoadInProgressState extends TransactionState {}


class TransactionLoadSuccessState extends TransactionState {
  final List<Transaction> transactions;

  const TransactionLoadSuccessState([this.transactions = const []]);

  @override
  List<Object> get props => [transactions];

  @override
  String toString() => 'TransactionsLoadSuccess { transactions: $transactions }';
}

class TransactionLoadFailureState extends TransactionState {}
