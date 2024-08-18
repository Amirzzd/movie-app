import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_app/common/utills/shared_operator.dart';
import 'package:movie_app/config/constants.dart';
import 'package:movie_app/features/auth/data/data_source/remote/auth_api_provider.dart';
import 'package:movie_app/features/auth/repository/auth_repository.dart';
import 'package:movie_app/features/bookmark/data/data_source/local/bookmark_provider.dart';
import 'package:movie_app/features/bookmark/repository/bookmark_repository.dart';
import 'package:movie_app/features/main/data/data_source/remote/main_api_provider.dart';
import 'package:movie_app/features/main/repository/main_repository.dart';
import 'package:movie_app/features/profile/data/data_source/remote/profile_api_provider.dart';
import 'package:movie_app/features/profile/presentation/bloc/theme_bloc/theme_bloc.dart';
import 'package:movie_app/features/profile/repository/profile_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'common/utills/dio_interceptor.dart';

final locator = GetIt.instance;

 Future<void> setupLocator () async{
   Dio dio = Dio(
     BaseOptions(
       connectTimeout: const Duration(seconds: 20),
       receiveTimeout: const Duration(seconds: 20),
       sendTimeout: const Duration(seconds: 20),
       baseUrl: Constants.baseUrl + Constants.midBaseUrl,
     ),
   );
   dio.interceptors.add(DioInterceptor(dio));
   locator.registerSingleton<Dio>(dio);

   ///shared operator (sharedPreference)
  locator.registerSingleton<SharedPrefOperator>(SharedPrefOperator(await SharedPreferences.getInstance(),locator<Dio>()));


  ///apiProvider
  locator.registerSingleton<MainApiProvider>(MainApiProvider(locator()));
  locator.registerSingleton<AuthApiProvider>(AuthApiProvider(locator()));
  locator.registerSingleton<ProfileApiProvider>(ProfileApiProvider(locator()));
  //db
  locator.registerSingleton<BookmarkProvider>(BookmarkProvider());


  ///repository
  locator.registerSingleton<MainRepository>(MainRepository(locator()));
  locator.registerSingleton<AuthRepository>(AuthRepository(locator()));
  locator.registerSingleton<ProfileRepository>((ProfileRepository(locator())));
  //db
  locator.registerSingleton<BookmarkRepository>((BookmarkRepository(locator())));


  ///theme Bloc
  locator.registerSingleton<ThemeBloc>(ThemeBloc(locator()));
 }