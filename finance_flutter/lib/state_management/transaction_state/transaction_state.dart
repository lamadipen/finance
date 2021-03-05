part of 'transaction_bloc.dart';

abstract class TransactionState extends Equatable{
  const TransactionState();

  @override
  List<Object> get props => [];
}

class TransactionInitial extends TransactionState {}

class TransactionsLoadSuccessState extends TransactionState {
  final List<Transaction> transactions;

  const TransactionsLoadSuccessState([this.transactions = const []]);

  @override
  List<Object> get props => [transactions];

  @override
  String toString() => 'TransactionsLoadSuccess { todos: $transactions }';
}

class TransactionLoadFailureState extends TransactionState {}
