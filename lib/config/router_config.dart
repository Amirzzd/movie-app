import 'package:flutter/cupertino.dart';
import 'package:movie_app/features/bookmark/presentation/bookmark_screen.dart';
import 'package:movie_app/features/intro/presentation/intro_screen.dart';
import 'package:movie_app/features/main/presentation/screens/actors_profile_screen.dart';
import 'package:movie_app/features/profile/presentation/screens/profile_screen.dart';
import '../features/main/presentation/screens/main_wrapper.dart';
import '../features/main/presentation/screens/movie_screen.dart';
import '../features/main/presentation/screens/popular_movie_list_screen.dart';
import '../features/main/presentation/screens/search_data_screen.dart';
import '../features/main/presentation/screens/top_rated_movie_list_screen.dart';
import '../features/main/presentation/screens/upcoming_movie_list_screen.dart';

class MyRouter {
  static get routes {
    return (RouteSettings setting) {
      switch (setting.name) {
        case IntroScreen.routeName:
          return PageRouteBuilder(
            settings: setting,
            pageBuilder: (context, animation,
                secondaryAnimation) =>  const IntroScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child,),
          );
        case MainWrapper.routeName:
          return PageRouteBuilder(
            settings: setting,
            pageBuilder: (context, animation,
                secondaryAnimation) =>  const MainWrapper(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child,),
          );
        case BookmarkScreen.routeName:
          return PageRouteBuilder(
            settings: setting,
            pageBuilder: (context, animation,
                secondaryAnimation) =>  const BookmarkScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child,),
          );
        case ActorsProfileScreen.routeName:
          return PageRouteBuilder(
            settings: setting,
            pageBuilder: (context, animation,
                secondaryAnimation) =>  const ActorsProfileScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child,),
          );

        case PopularMovieListScreen.routeName:
          return PageRouteBuilder(
            settings: setting,
            pageBuilder: (context, animation,
                secondaryAnimation) =>  const PopularMovieListScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child,),
          );

        case UpcomingMovieListScreen.routeName:
          return PageRouteBuilder(
            settings: setting,
            pageBuilder: (context, animation,
                secondaryAnimation) =>  const UpcomingMovieListScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child,),
          );


        case TopRatedMovieListScreen.routeName:
          return PageRouteBuilder(
            settings: setting,
            pageBuilder: (context, animation,
                secondaryAnimation) =>  const TopRatedMovieListScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child,),
          );

        case SearchDataScreen.routeName:
          return PageRouteBuilder(
            settings: setting,
            pageBuilder: (context, animation,
                secondaryAnimation) =>  const SearchDataScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child,),
          );

        case MovieScreen.routeName:
          return PageRouteBuilder(
            settings: setting,
            pageBuilder: (context, animation,
                secondaryAnimation) =>  const MovieScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child,),
          );


        case ProfileScreen.routeName:
          return PageRouteBuilder(
            settings: setting,
            pageBuilder: (context, animation,
                secondaryAnimation) =>  const ProfileScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child,),
          );
      }
    };
  }
}