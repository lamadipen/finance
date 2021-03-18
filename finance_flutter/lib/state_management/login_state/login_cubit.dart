import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:finance_flutter/service/authentication_service.dart';
import 'package:formz/formz.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthenticationService _authenticationService;

  LoginCubit(this._authenticationService)
      : assert(_authenticationService != null),
        super(const LoginState());

  Future<void> logInWithGoogle() async{
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try{
      await _authenticationService.logInWithGoogle();
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    }on Exception{
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    } on NoSuchMethodError{
      emit(state.copyWith(status: FormzStatus.pure));
    }
  }

  Future<void> logInWithFacebook() async{
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try{
      await _authenticationService.signInWithFacebook();
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    }on Exception{
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    } on NoSuchMethodError{
      emit(state.copyWith(status: FormzStatus.pure));
    }
  }
}
