import 'package:dio/dio.dart';
import 'package:movie_app/common/param/login_param.dart';
import 'package:movie_app/common/param/register_param.dart';
import 'package:movie_app/config/constants.dart';


class AuthApiProvider {
  Dio dio;
  AuthApiProvider(this.dio);

  final apiKey = Constants.apiKey;

  loginApi (LoginParam loginParam) async{
    Response response = await dio.post(
        'auth/login',
        data: {
          'email' :loginParam.email,
          'password':loginParam.password,
          'panel' : '0',
        }
    );
    return response;
  }

  dynamic register(RegisterParam registerParam) async {
    var response = await dio.post("auth/register", data: {
      "name": registerParam.name,
      "email": registerParam.email,
      "password": registerParam.password,
      "isAdmin": "0"
     },
    );
    return response;
  }

  dynamic forgetPassword(String email) async {
    var response = await dio.post("auth/forget-password", data: {
      "email" : email
     },
    );
    return response;
  }


}
