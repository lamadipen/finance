import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:finance_flutter/model/businessEntity/user.dart';
import 'package:finance_flutter/service/authentication_service.dart';
import 'package:meta/meta.dart';
import 'package:pedantic/pedantic.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationService _authenticationService;
  StreamSubscription<FlutterFinanceUser> _userSubscription;

  AuthenticationBloc(AuthenticationService authenticationService)
      : assert(authenticationService != null),
        _authenticationService = authenticationService,
        super(const AuthenticationState.unknown()) {
    _userSubscription = _authenticationService.user.listen(
      (user) => add(AuthenticationUserChangedEvent(user)),
    );
  }

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if(event is AuthenticationUserChangedEvent) {
      yield _mapAuthenticationUserChangedToState(event);
    }else if(event is AuthenticationLogoutRequestedEvent) {
      unawaited(_authenticationService.logOut());
    }
  }

  AuthenticationState _mapAuthenticationUserChangedToState(AuthenticationUserChangedEvent event) {
      return event.user != FlutterFinanceUser.empty ?
          AuthenticationState.authenticated(event.user):
          const AuthenticationState.unauthenticated();
  }
}
