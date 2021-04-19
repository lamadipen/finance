part of 'authentication_bloc.dart';


enum AuthenticationStatus { authenticated, unauthenticated, unknown , authenticatedSignUp}

class AuthenticationState extends Equatable{
  final AuthenticationStatus status;
  final FlutterFinanceUser user;

  const AuthenticationState._({
    this.status = AuthenticationStatus.unknown,
    this.user = FlutterFinanceUser.empty,
  });

  @override
  List<Object> get props => [status, user];

  const AuthenticationState.unknown() : this._();

  const AuthenticationState.authenticated(FlutterFinanceUser user)
      : this._(status: AuthenticationStatus.authenticated, user: user);

  const AuthenticationState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);

  const AuthenticationState.authenticatedSignUp(FlutterFinanceUser user)
      : this._(status: AuthenticationStatus.authenticatedSignUp, user: user);
}