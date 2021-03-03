import 'package:equatable/equatable.dart';
import 'package:finance_flutter/model/businessEntity/transaction.dart';

abstract class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object> get props => [];
}

class TransactionLoadSuccess extends TransactionEvent {}

class TransactionAdded extends TransactionEvent {
  final Transaction transaction;

  const TransactionAdded(this.transaction);

  @override
  List<Object> get props => [transaction];

  @override
  String toString() => 'TransactionAdded { todo: $transaction }';
}

class TransactionUpdated extends TransactionEvent {
  final Transaction transaction;

  const TransactionUpdated(this.transaction);

  @override
  List<Object> get props => [transaction];

  @override
  String toString() => 'TransactionUpdated { transaction: $transaction }';
}

class TransactionDeleted extends TransactionEvent {
  final Transaction transaction;

  const TransactionDeleted(this.transaction);

  @override
  List<Object> get props => [transaction];

  @override
  String toString() => 'TransactionDeleted { transaction: $transaction }';
}

class ClearCompleted extends TransactionEvent {}

class ToggleAll extends TransactionEvent {}