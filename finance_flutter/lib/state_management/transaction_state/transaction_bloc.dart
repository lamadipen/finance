import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:finance_flutter/model/businessEntity/transaction.dart';
import 'package:finance_flutter/service/transaction_service.dart';

part 'transaction_event.dart';

part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc() : super(TransactionLoadInProgressState());
  var transactionService = TransactionService();
  @override
  Stream<TransactionState> mapEventToState(TransactionEvent event) async* {
    final currentState = state;
    if (currentState is TransactionLoadInProgressState) {
      yield* _mapTransactionsLoadedToState();
    } else if (event is TransactionsLoadedEvent) {
      yield* _mapTransactionsLoadedToState();
    } else if (event is TransactionAddedEvent) {
        final List<Transaction> transactions =
        List.from((state as TransactionsLoadSuccessState).transactions)..add(event.transaction);
        yield TransactionsLoadSuccessState(transactions);
        _saveTransaction(event.transaction);
        return;
    }
  }

  Stream<TransactionState> _mapTransactionsLoadedToState() async* {
    try {
      final transactions = await transactionService.fetchPosts(0, 10);
      yield TransactionsLoadSuccessState(transactions);
      return;
    } catch (_) {
      yield TransactionLoadFailureState();
    }
  }

  Future _saveTransaction(Transaction transaction) {
    return Future.wait<dynamic>(
        [transactionService.saveTransaction(transaction)]);
  }
}
