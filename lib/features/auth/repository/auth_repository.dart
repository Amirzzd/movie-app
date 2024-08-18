import 'package:dio/dio.dart';
import 'package:movie_app/common/error_handling/check_exceptions.dart';
import 'package:movie_app/common/param/login_param.dart';
import 'package:movie_app/common/param/register_param.dart';
import 'package:movie_app/common/resources/data_state.dart';
import 'package:movie_app/features/auth/data/data_source/remote/auth_api_provider.dart';
import 'package:movie_app/features/auth/data/models/auth_model.dart';

class AuthRepository {
  AuthApiProvider authApiProvider;
  AuthRepository(this.authApiProvider);

  Future <DataState<dynamic>> login (LoginParam param) async {
    try{
      final Response response = await authApiProvider.loginApi(param);
      return DataSuccess(AuthModel.fromJson(response.data));
    }catch(e){
      return CheckExceptions.getError(e);
    }
  }


  Future registerRop (RegisterParam param) async{
    try {
      final Response response = await authApiProvider.register(param);
      return DataSuccess(AuthModel.fromJson(response.data));
    }catch (e){
      return CheckExceptions.getError(e);
    }
  }

  Future forgetPasswordRop (String email) async{
    try {
      final Response response = await authApiProvider.forgetPassword(email);
      return DataSuccess(AuthModel.fromJson(response.data));
    }catch (e){
      return CheckExceptions.getError(e);
    }
  }
}