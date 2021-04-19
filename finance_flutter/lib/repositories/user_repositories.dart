import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_flutter/model/businessEntity/user.dart';

abstract class UserRepository {
  Future<void> addNewFlutterFinanceUser(FlutterFinanceUser user);

  Future<void> deleteFlutterFinanceUser(FlutterFinanceUser user);

  Stream<List<FlutterFinanceUser>> flutterFinanceUsers();

  Future<FlutterFinanceUser> flutterFinanceUser(String documentId);

  Future<void> updateFlutterFinanceUser(FlutterFinanceUser user);
}

class UserRepositoryImpl implements UserRepository {
  final _userCollection = FirebaseFirestore.instance.collection('users');

  @override
  Future<void> addNewFlutterFinanceUser(FlutterFinanceUser user) {
    print("Printing user ${user}");
    _userCollection
        .doc(user.id)
        .set(user.toJsonDocument())
        .then((value) => print("user add"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  @override
  Future<void> deleteFlutterFinanceUser(FlutterFinanceUser user) {
    // TODO: implement deleteFlutterFinanceUser
    throw UnimplementedError();
  }

  @override
  Stream<List<FlutterFinanceUser>> flutterFinanceUsers() {
    _userCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => FlutterFinanceUser.fromJson(doc.data()))
          .toList();
    });
  }

  @override
  Future<void> flutterTest() {
    _userCollection.doc('1234').get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document exists on the database');
        print(documentSnapshot.data());
      }else{
        print('Document not exists');
      }
    });
  }

  @override
  Future<FlutterFinanceUser> flutterFinanceUser(String documentId) async {
    FlutterFinanceUser user = FlutterFinanceUser.empty;
    await _userCollection.doc(documentId).get().then((documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document exists on the database');
        user = FlutterFinanceUser.fromJson(documentSnapshot.data());
      } else {
        print('Document doesn exists on the database');
        return FlutterFinanceUser.empty;
      }
    }).onError((error, stackTrace) => user = FlutterFinanceUser.empty);
    return user;
  }

  @override
  Future<void> updateFlutterFinanceUser(FlutterFinanceUser user) {
    // TODO: implement updateFlutterFinanceUser
    throw UnimplementedError();
  }
}
