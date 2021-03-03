import 'package:finance_flutter/mockData/mockBuilder.dart';
import 'package:finance_flutter/model/businessEntity/transaction.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'TransactionEvent.dart';
import 'TransactionState.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final MockBuilder transactionRepository;

  TransactionBloc({@required this.transactionRepository})
      : super(TransactionLoadInProgressState());

  @override
  Stream<TransactionState> mapEventToState(TransactionEvent event) async* {
    if (event is TransactionLoadSuccess) {
      yield* _mapTodosLoadedToState();
    } else if (event is TransactionAdded) {
      yield* _mapTransactionAddedToState(event);
    } else if (event is TransactionUpdated) {
      yield* _mapTransactionUpdatedToState(event);
    } else if (event is TransactionDeleted) {
      yield* _mapTransationDeletedToState(event);
    } else if (event is ToggleAll) {
      yield* _mapToggleAllToState();
    } else if (event is ClearCompleted) {
      yield* _mapClearCompletedToState();
    }
  }

  Stream<TransactionState> _mapTodosLoadedToState() async* {
    try {
      final transactions = await MockBuilder.buildTransactions();
      yield TransactionLoadSuccessState(
        transactions
      );
    } catch (_) {
      yield TransactionLoadFailureState();
    }
  }

  Stream<TransactionState> _mapTransactionAddedToState(TransactionAdded event) async* {
    if (state is TransactionLoadSuccess) {
      final List<Transaction> updatedTransaction = List.from((state as TransactionLoadSuccessState).transactions)
        ..add(event.transaction);
      yield TransactionLoadSuccessState(updatedTransaction);
      _saveTransactions(updatedTransaction);
    }
  }

  Stream<TransactionState> _mapTransactionUpdatedToState(TransactionUpdated event) async* {
    if (state is TransactionLoadSuccessState) {
      final List<Transaction> updatedTodos = (state as TransactionLoadSuccessState).transactions.map((t) {
        return t.transactionId == event.transaction.transactionId ? event.transaction : t;
      }).toList();
      yield TransactionLoadSuccessState(updatedTodos);
      _saveTransactions(updatedTodos);
    }
  }

  Stream<TransactionState> _mapTransationDeletedToState(TransactionDeleted event) async* {
    if (state is TransactionLoadSuccessState) {
      final updatedTransaction = (state as TransactionLoadSuccessState)
          .transactions
          .where((transaction) => transaction.transactionId != event.transaction.transactionId)
          .toList();
      yield TransactionLoadSuccessState(updatedTransaction);
      _saveTransactions(updatedTransaction);
    }
  }

  Stream<TransactionState> _mapToggleAllToState() async* {
    if (state is TransactionLoadSuccessState) {
      final allComplete =
      (state as TransactionLoadSuccessState).transactions.every((transaction) => transaction.transactionId > 0);
      final List<Transaction> updatedTodos = (state as TransactionLoadSuccessState)
          .transactions
          .toList();
      yield TransactionLoadSuccessState(updatedTodos);
      _saveTransactions(updatedTodos);
    }
  }

  Stream<TransactionState> _mapClearCompletedToState() async* {
    if (state is TransactionLoadSuccessState) {
      final List<Transaction> updatedTransaction =  (state as TransactionLoadSuccessState).transactions.where((transaction) => transaction.transactionId > 0).toList();
      yield TransactionLoadSuccessState(updatedTransaction);
      _saveTransactions(updatedTransaction);
    }
  }

  Future _saveTransactions(List<Transaction> transactions) {
    return transactionRepository.saveTransactions(
          transactions
        );
  }
}
