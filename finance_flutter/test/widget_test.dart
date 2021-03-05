// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:finance_flutter/mockData/mockBuilder.dart';
import 'package:finance_flutter/service/transaction_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // var buildTransactions = MockBuilder.buildTransactions();
    //
    // var buildTransaction = buildTransactions[0];
    // print(buildTransaction.toString());
    //
    // var transactionService = TransactionService();
    // var fetchPosts = transactionService.fetchPosts(0, 10);
    // print(fetchPosts);

    // Build our app and trigger a frame.
    // await tester.pumpWidget(MyApp());
    //
    // // Verify that our counter starts at 0.
    // expect(find.text('0'), findsOneWidget);
    // expect(find.text('1'), findsNothing);
    //
    // // Tap the '+' icon and trigger a frame.
    // await tester.tap(find.byIcon(Icons.add));
    // await tester.pump();
    //
    // // Verify that our counter has incremented.
    // expect(find.text('0'), findsNothing);
    // expect(find.text('1'), findsOneWidget);

/* Json object
        {
      "userId": 200,
    "transactionId": 1,
    "date": "2021-03-04 19:03:34.611197",
    "category": {
    "id": 1,
    "name": "Travel",
    "categoryType": "expenses"
    },
    "description": "Purchased Some goods",
    "amount": 1000
  }*/

    /*json array
  [
  {
    "userId": 100,
    "transactionId": 1,
    "date": "2021-03-04 19:03:34.611197",
    "category": {
      "id": 1,
      "name": "Travel",
      "categoryType": "expenses"
    },
    "description": "Purchased Some goods",
    "amount": 1000
  },
  {
    "userId": 200,
    "transactionId": 1,
    "date": "2021-03-04 19:03:34.611197",
    "category": {
      "id": 1,
      "name": "Travel",
      "categoryType": "expenses"
    },
    "description": "Purchased Some goods",
    "amount": 1000
  },
  {
    "userId": 300,
    "transactionId": 1,
    "date": "2021-03-04 19:03:34.611197",
    "category": {
      "id": 1,
      "name": "Travel",
      "categoryType": "expenses"
    },
    "description": "Purchased Some goods",
    "amount": 1000
  }
]

https://designer.mocky.io/design/confirmation


  * */
  });
}
