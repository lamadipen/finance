import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:finance_flutter/mockData/mockBuilder.dart';
import 'package:finance_flutter/model/businessEntity/transaction.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc() : super(TransactionInitial());

  @override
  Stream<TransactionState> mapEventToState(TransactionEvent event) async* {
    if (event is TransactionsLoadedEvent) {
      yield* _mapTransactionsLoadedToState();
    }
  }

  Stream<TransactionState> _mapTransactionsLoadedToState() async* {
    try {
      final transactions = await MockBuilder.buildTransactions();
      yield TransactionsLoadSuccessState(transactions.map((e) => e).toList());
    } catch (_) {
      yield TransactionLoadFailureState();
    }
  }
}
