
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/api_config.dart';

class SharedPrefOperator {
  final SharedPreferences sharedPreferences;
  final Dio dio;
  SharedPrefOperator(this.sharedPreferences,this.dio);

  /// auth
  setUserToken(token) {
    ApiConfig.setHeader(dio: dio, token: token);
    sharedPreferences.setString("token", token);
    sharedPreferences.setBool("loggedIn", true);
  }

  String getUserToken() {
    return sharedPreferences.getString("token") ?? "";
  }

  getUserRefreshToken() {
    return sharedPreferences.getString("refreshToken") ?? "";
  }
  /// ========

  /// intro
  bool getIntroState() {
    return sharedPreferences.getBool("shouldShowIntro") ?? true;
  }
  saveIntroState() {
    sharedPreferences.setBool("shouldShowIntro", false);
  }
  /// ========

  changeChooseState() {
    sharedPreferences.setBool("shouldShowChooseLang", false);
  }

  bool getChooseState() {
    return sharedPreferences.getBool("shouldShowChooseLang") ?? true;
  }

  bool getLoggedIn() {
    return sharedPreferences.getBool("loggedIn") ?? false;
  }

  /// logout
  logoutDelete() {
    sharedPreferences.clear();
    sharedPreferences.setBool("shouldShowIntro", false);
  }

  changeTokenTemp() {
    var token = sharedPreferences.getString("token") ?? "";
    sharedPreferences.setString("token", token.replaceFirst("A", "f"));
  }

  saveUserRefreshToken(String token, String refreshToken) {
    sharedPreferences.setString("token", token);
    sharedPreferences.setString("refreshToken", refreshToken);
  }

  /// theme mode
  saveThemeMode(bool isLight){
    sharedPreferences.setBool("isLight", isLight);
  }
  bool getThemeMode(){
    return sharedPreferences.getBool("isLight")??true;
  }

}
