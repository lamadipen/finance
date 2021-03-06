part of 'transaction_bloc.dart';

abstract class TransactionEvent {}

class TransactionsLoadedEvent extends TransactionEvent {}

class TransactionAddedEvent extends TransactionEvent {}
class TransactionUpdatedEvent extends TransactionEvent {}
class TransactionDeletedEvent extends TransactionEvent {}
