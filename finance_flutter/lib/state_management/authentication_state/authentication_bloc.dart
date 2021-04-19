import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:finance_flutter/model/businessEntity/user.dart';
import 'package:finance_flutter/repositories/user_repositories.dart';
import 'package:finance_flutter/service/authentication_service.dart';
import 'package:meta/meta.dart';
import 'package:pedantic/pedantic.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationService _authenticationService;
  final UserRepository _userRepository;
  StreamSubscription<FlutterFinanceUser> _firebaseUserSubscription;
  StreamSubscription<FlutterFinanceUser> _fireStoneUserSubscription;

  AuthenticationBloc(AuthenticationService authenticationService,
      UserRepository userRepository)
      : assert(authenticationService != null),
        _authenticationService = authenticationService,
        assert(userRepository != null),
        _userRepository = userRepository,
        super(const AuthenticationState.unknown()) {
    _firebaseUserSubscription = _authenticationService.user.listen(
      (user) => add(AuthenticationUserChangedEvent(user)),
    );
  }

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AuthenticationUserChangedEvent) {
      var userFromAuthentication = event.user;

      if (userFromAuthentication != FlutterFinanceUser.empty) {
        print(" user from authentivation ${userFromAuthentication}");
        var userdb =
        await _userRepository.flutterFinanceUser(userFromAuthentication.id);
        print(" user from db ${userFromAuthentication}");
        if (userdb != null &&
            userdb.companies != null &&
            userdb.companies.length > 0) {
          print("Authenticated");
          yield AuthenticationState.authenticated(userdb);
        } else if (event.user != FlutterFinanceUser.empty) {
          print("Signup");
          yield AuthenticationState.authenticatedSignUp(userFromAuthentication);
        } else {
          print("Unauthenticated");
          yield AuthenticationState.unauthenticated();
        }
      } else {
        yield AuthenticationState.unauthenticated();
      }
    } else if (event is AuthenticationLogoutRequestedEvent) {
      unawaited(_authenticationService.logOut());
    }
  }
}
