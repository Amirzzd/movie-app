part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

///--- Login State

class LoginLoading extends AuthState{}

class LoginSuccess extends AuthState{
  final AuthModel authModel;
  LoginSuccess({required this.authModel});
}

class LoginError extends AuthState{
  final String message;

  LoginError({required this.message});
}

///--- Register State

class RegisterLoading extends AuthState{}

class RegisterSuccess extends AuthState{
  final AuthModel authModel;
  RegisterSuccess({required this.authModel});
}

class RegisterError extends AuthState{
  final String message;

  RegisterError({required this.message});
}

///--- Forget Password State

class ForgetPasswordLoading extends AuthState{}

class ForgetPasswordSuccess extends AuthState{
  final AuthModel authModel;
  ForgetPasswordSuccess({required this.authModel});
}

class ForgetPasswordError extends AuthState{
  final String message;

  ForgetPasswordError({required this.message});
}

class PassWordVisibiltyState extends AuthState{
  final bool visibility;
  PassWordVisibiltyState({required this.visibility});
}

