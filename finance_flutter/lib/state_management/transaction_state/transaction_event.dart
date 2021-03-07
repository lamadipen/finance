part of 'transaction_bloc.dart';

abstract class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object> get props => [];
}

class TransactionsLoadedEvent extends TransactionEvent {}

class TransactionAddedEvent extends TransactionEvent {
  final Transaction transaction;

  const TransactionAddedEvent(this.transaction);

  @override
  List<Object> get props => [transaction];

  @override
  String toString() => 'TransactionAddedEvent { transaction: $transaction }';
}

class TransactionUpdatedEvent extends TransactionEvent {}

class TransactionDeletedEvent extends TransactionEvent {}
