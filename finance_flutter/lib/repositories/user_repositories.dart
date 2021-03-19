import 'package:finance_flutter/model/businessEntity/user.dart';

abstract class UserRepository {
  Future<void> addNewFlutterFinanceUser(FlutterFinanceUser user);

  Future<void> deleteFlutterFinanceUser(FlutterFinanceUser user);

  Stream<List<FlutterFinanceUser>> flutterFinanceUsers();

  Future<void> updateFlutterFinanceUser(FlutterFinanceUser user);
}


class FirebaseTodosRepository implements UserRepository {

  @override
  Future<void> addNewFlutterFinanceUser(FlutterFinanceUser user) {
    // TODO: implement addNewFlutterFinanceUser
    throw UnimplementedError();
  }

  @override
  Future<void> deleteFlutterFinanceUser(FlutterFinanceUser user) {
    // TODO: implement deleteFlutterFinanceUser
    throw UnimplementedError();
  }

  @override
  Stream<List<FlutterFinanceUser>> flutterFinanceUsers() {
    // TODO: implement flutterFinanceUsers
    throw UnimplementedError();
  }

  @override
  Future<void> updateFlutterFinanceUser(FlutterFinanceUser user) {
    // TODO: implement updateFlutterFinanceUser
    throw UnimplementedError();
  }

}