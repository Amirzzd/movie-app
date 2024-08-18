import 'package:flutter/material.dart';
import 'package:movie_app/common/widgets/search_bar_widget.dart';
import 'package:movie_app/features/main/presentation/bloc/home_bloc/home_bloc.dart';
import 'package:movie_app/features/main/presentation/widgets/actor_list_widget.dart';
import 'package:movie_app/features/main/presentation/widgets/popular_movie_widget.dart';
import 'package:movie_app/features/main/presentation/widgets/top_movie_widgets.dart';
import 'package:movie_app/features/main/presentation/widgets/top_rated_movie._widget.dart';
import 'package:movie_app/features/main/presentation/widgets/upcoming_movie_widget.dart';
import 'package:movie_app/generated/assets.dart';
import 'package:movie_app/locator.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home_screen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    super.build(context);
    var theme = Theme.of(context);
    HomeBloc bloc = HomeBloc(locator());
    bloc.add(TopMovieEvent());
    return GestureDetector(
      onTap: (){
        FocusScopeNode currentFocus = FocusScope.of(context);
        if(!currentFocus.hasPrimaryFocus){
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ///---appBar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0,vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('خانه',style: theme.textTheme.titleLarge!.copyWith(fontSize: 25,fontWeight: FontWeight.w900) ,),
                        Text('خوش آمدی :)',style: theme.textTheme.bodyMedium!.copyWith(fontSize: 10,color: Colors.grey) ),
                      ],
                    ),
                    Image.asset(Assets.assetsLogo,height: 50,),
                  ],
                ),
              ),
              ///---searchBar
              const SearchBarWidget(),
              ///---Top movie Widgets
              const TopMovieWidgets(),
              ///---Actors List Widget
              const ActorsListWidget(),
              ///---popular Movie Widget
              const PopularMovieList(),
              ///---TopRated Movie Widget
              const TopRatedMovieWidget(),
              ///---upcoming Movie Widget
              const UpComingMovieWidget(),

            ],
          ),
        )
      ),
    );

  }

  @override
  bool get wantKeepAlive => true;
}
