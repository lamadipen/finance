import 'package:draggable_floating_button/draggable_floating_button.dart';
import 'package:finance_flutter/model/businessEntity/category.dart';
import 'package:finance_flutter/model/businessEntity/transaction.dart';
import 'package:finance_flutter/state_management/authentication_state/authentication_bloc.dart';
import 'package:finance_flutter/state_management/transaction_state/transaction_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'addTransaction.dart';

class ListTransaction extends StatefulWidget {
  @override
  _ListTransactionState createState() => _ListTransactionState();
}

class _ListTransactionState extends State<ListTransaction> {
  final _saved = Set<Transaction>();
  final _biggerFont = TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    var appBar2 = AppBar(
      actions: [
        IconButton(icon: Icon(Icons.add), onPressed: _pushSaved),
        IconButton(
          key: const Key('homePage_logout_iconButton'),
          icon: const Icon(Icons.exit_to_app),
          onPressed: () => context
              .read<AuthenticationBloc>()
              .add(AuthenticationLogoutRequestedEvent()),
        ),
      ],
    );
    return BlocBuilder<TransactionBloc, TransactionState>(
        builder: (context, state) {
      if (state is TransactionLoadInProgressState) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is TransactionLoadFailureState) {
        return Center(
          child: Text('failed to fetch posts'),
        );
      }
      final _transactions =
          state is TransactionsLoadSuccessState ? state.transactions : [];
      return Scaffold(
        appBar: appBar2,
        body: _buildSuggestions(_transactions),
        floatingActionButton: Stack(children: <Widget>[
          DraggableFloatingActionButton(
              tooltip: 'Add Transactions',
              offset: new Offset(
                  MediaQuery.of(context).size.width -
                      (MediaQuery.of(context).size.width * 0.2),
                  MediaQuery.of(context).size.height -
                      (MediaQuery.of(context).size.height * 0.2)),
              child: new Icon(
                Icons.add,
              ),
              onPressed: () => _pushSaved(),
              appContext: context,
              appBar: appBar2),
        ]),
      );
    });
  }

  Widget _buildSuggestions(transactions) {
    return Container(
        margin: EdgeInsets.only(bottom: 35),
        child: ListView.builder(
            itemCount: transactions.length,
            padding: EdgeInsets.all(16.0),
            itemBuilder: /*1*/ (context, i) {
              //if (i.isOdd) return Divider();
              return _buildRow(transactions[i]);
            }));
  }

  Widget _buildRow(Transaction transaction) {
    final alreadySaved = _saved.contains(transaction);
    return ListTile(
      title: Text(
        transaction.description,
        style: _biggerFont,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Date : " + transaction.date.toString()),
          Text("Category : " + transaction.category.name),
          Text("Amount : " + transaction.amount.toString())
        ],
      ),
      trailing: Icon(
        // NEW from here...
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        // NEW lines from here...
        setState(() {
          if (alreadySaved) {
            _saved.remove(transaction);
          } else {
            _saved.add(transaction);
          }
        });
      },
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Add New Transaction'),
          ),
          body: AddTransaction(),
        );
      }),
    );
  }
}
