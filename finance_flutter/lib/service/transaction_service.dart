import 'dart:convert';

import 'package:finance_flutter/model/businessEntity/transaction.dart';
import 'package:http/http.dart' as http;

class TransactionService{
  final http.Client httpClient = http.Client();

  Future<List<Transaction>> fetchPosts(int startIndex, int limit) async {
    // final response = await httpClient.get(
    //     'https://jsonplaceholder.typicode.com/posts?_start=$startIndex&_limit=$limit');

    final response = await httpClient.get(
        'https://run.mocky.io/v3/9da89808-1365-49ed-be41-93f4f0e28107');
    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((post) => Transaction.fromJson(post))
          .toList();
    } else {
      throw Exception('error fetching posts');
    }
  }
}