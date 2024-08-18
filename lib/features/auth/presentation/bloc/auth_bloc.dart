import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:movie_app/common/param/login_param.dart';
import 'package:movie_app/common/param/register_param.dart';
import 'package:movie_app/common/resources/data_state.dart';
import 'package:movie_app/features/auth/data/models/auth_model.dart';
import 'package:movie_app/features/auth/repository/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthRepository authRepository;
  AuthBloc(this.authRepository) : super(AuthInitial()){

    ///---Login
    on<LoginEvent>((event, emit) async{
      emit(LoginLoading());
      DataState dataState = await authRepository.login(event.loginParam);

      dataState is DataSuccess
      ? emit(LoginSuccess(authModel: dataState.data))
      : emit(LoginError(message: dataState.message!));
    });

    ///---Register
    on<RegisterEvent>((event, emit) async{
      emit(RegisterLoading());

      DataState dataState = await authRepository.registerRop(event.registerParam);

      dataState is DataSuccess
          ? emit(RegisterSuccess(authModel: dataState.data))
          : emit(RegisterError(message: dataState.message!));
    });

    ///---Forget Password
    on<ForgetPasswordEvent>((event, emit) async{
      emit(ForgetPasswordLoading());

      DataState dataState = await authRepository.forgetPasswordRop(event.email);

      dataState is DataSuccess
          ? emit(ForgetPasswordSuccess(authModel: dataState.data))
          : emit(ForgetPasswordError(message: dataState.message!));
    });

    ///toggle
    on<ShowPasswordEvent>((event, emit) async{
      emit(PassWordVisibiltyState(visibility: event.visibility));
    },);


  }
}
