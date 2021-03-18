part of 'login_cubit.dart';

class LoginState extends Equatable {
  final FormzStatus status;

  const LoginState({
    this.status = FormzStatus.pure,
  });

  @override
  List<Object> get props => [status];

  LoginState copyWith({
    FormzStatus status,
  }) {
    return LoginState(
      status: status ?? this.status,
    );
  }
}