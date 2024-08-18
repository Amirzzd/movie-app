import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:movie_app/common/utills/http_override.dart';
import 'package:movie_app/config/my_theme.dart';
import 'package:movie_app/config/router_config.dart';
import 'package:movie_app/locator.dart';
import 'features/bookmark/data/data_source/model/bookmark_movies_model.dart';
import 'features/intro/presentation/bloc/intro_bloc.dart';
import 'features/intro/presentation/splash_screen.dart';
import 'features/main/presentation/bloc/bottom_nav_bloc/bottom_nav_bloc.dart';
import 'features/profile/presentation/bloc/theme_bloc/theme_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  // Hive.registerAdapter(BookmarkMoviesModelAdapter());
  // await Hive.openBox('bookmark_movies');
  await setupLocator();

  HttpOverrides.global = MyHttpOverrides();

  /// force portrait
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => IntroBloc(),),
          BlocProvider(create: (context) => BottomNavBloc(),),
          BlocProvider(create: (context) => ThemeBloc(locator()),)
        ],
        child: const MyApp(),
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, bool>(
      builder: (context, state) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Movies App',
            theme: state ? MyTheme.lightTheme : MyTheme.darkTheme,
            themeMode: ThemeMode.dark,
            onGenerateRoute: MyRouter.routes,
            localizationsDelegates: const [
              GlobalCupertinoLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            locale: const Locale("fa", ""),
            supportedLocales: const [
              Locale("fa", ""),
              Locale('en', ''), // English, no country code
            ],
            home: const SplashScreen()
        );
      },
    );
  }
}
