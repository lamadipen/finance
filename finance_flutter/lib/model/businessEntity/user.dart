import 'package:equatable/equatable.dart';
import 'package:finance_flutter/model/businessEntity/role.dart';
import 'package:meta/meta.dart';

class FlutterFinanceUser extends Equatable {
  final String email;
  final String id;
  final String name;
  final String photo;
  final Role role;
  final List<String> companies;

  const FlutterFinanceUser({
    @required this.email,
    @required this.id,
    @required this.name,
    @required this.photo,
    @required this.role,
    @required this.companies
  }):assert(email != null), assert(id != null);

  @override
  List<Object> get props => [email, id, name, photo, role, companies];

  /// Empty user which represents an unauthenticated user.
  static const empty = FlutterFinanceUser(email: '', id: '', name: null, photo: null);

  factory FlutterFinanceUser.fromJson(Map<String, dynamic> json) {
    return FlutterFinanceUser(email: json['email'], id: json['id'], name: json['name'], photo: json['photo'], role: StringToEnumConverter.toEnum(json['role'], Role.values), companies: json['companies'].cast<String>());
  }

  Map<String, Object> toJsonDocument() {
    return {
      "id": id,
      "email": email,
      "name": name,
      "role": role.name,
      "photo": photo,
      "companies": companies,
    };
  }
}