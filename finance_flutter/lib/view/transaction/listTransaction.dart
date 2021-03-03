import 'package:finance_flutter/mockData/mockBuilder.dart';
import 'package:finance_flutter/model/businessEntity/transaction.dart';
import 'package:flutter/material.dart';
import 'package:draggable_floating_button/draggable_floating_button.dart';

import 'addTransaction.dart';

class ListTransaction extends StatefulWidget {
  @override
  _ListTransactionState createState() => _ListTransactionState();
}

class _ListTransactionState extends State<ListTransaction> {
  final _transactions = MockBuilder.buildTransactions();
  final _saved = Set<Transaction>();
  final _biggerFont = TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    var appBar2 = AppBar(
      actions: [
        IconButton(icon: Icon(Icons.add), onPressed: _pushSaved),
      ],
    );
    return Scaffold(
      appBar: appBar2,
      body: _buildSuggestions(),
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
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        itemCount: _transactions.length,
        padding: EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return Divider();
          return _buildRow(_transactions[i]);
        });
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
          Text("Type : " + transaction.category.categoryType),
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
