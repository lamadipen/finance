import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class FlutterFinanceUser extends Equatable {
  final String email;
  final String id;
  final String name;
  final String photo;

  const FlutterFinanceUser({
    @required this.email,
    @required this.id,
    @required this.name,
    @required this.photo,
  }):assert(email != null), assert(id != null);

  @override
  List<Object> get props => [email, id, name, photo];

  /// Empty user which represents an unauthenticated user.
  static const empty = FlutterFinanceUser(email: '', id: '', name: null, photo: null);
}