part of 'auth_bloc.dart';

sealed class AuthEvent {}

class LoginEvent extends AuthEvent{
  LoginParam loginParam;

  LoginEvent({required this.loginParam});
}

class RegisterEvent extends AuthEvent{
  RegisterParam registerParam;

  RegisterEvent({required this.registerParam});
}

class ForgetPasswordEvent extends AuthEvent{
  final String email;

  ForgetPasswordEvent({required this.email});
}

class ShowPasswordEvent extends AuthEvent{
  bool visibility;

  ShowPasswordEvent({required this.visibility});
}


