import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:finance_flutter/model/businessEntity/transaction.dart';
import 'package:finance_flutter/service/transaction_service.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc() : super(TransactionLoadInProgressState());

  @override
  Stream<TransactionState> mapEventToState(TransactionEvent event) async* {
    final currentState = state;
    if (currentState is TransactionLoadInProgressState) {
      yield* _mapTransactionsLoadedToState();
    }else if(event is TransactionsLoadedEvent) {
      print("TransactionsInitialEvent");

    }
  }

  Stream<TransactionState> _mapTransactionsLoadedToState() async* {
    try {
      var transactionService = TransactionService();
      final transactions = await transactionService.fetchPosts(0, 10);

      yield TransactionsLoadSuccessState(transactions);
      return;
    } catch (_) {
      yield TransactionLoadFailureState();
    }
  }
}
