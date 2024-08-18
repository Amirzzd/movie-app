import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:movie_app/common/widgets/shimmer_loading.dart';
import 'package:movie_app/config/constants.dart';
import 'package:movie_app/features/main/data/models/movie_list_model.dart';
import 'package:movie_app/features/main/presentation/bloc/home_bloc/home_bloc.dart';
import 'package:movie_app/locator.dart';

import '../screens/movie_screen.dart';
import '../screens/popular_movie_list_screen.dart';

class PopularMovieList extends StatelessWidget {
  const PopularMovieList({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    HomeBloc bloc = HomeBloc(locator());
    bloc.add(PopularMovieListEvent());

    return BlocBuilder(
      bloc: bloc,
        builder: (context, state) {
          if(state is MovieListLoading){
            return Container();
          }
          if(state is MovieListSuccess){
            MovieListModel model = state.model;
            // return movieListWidget(
            //     movieListModel: model,
            //     context: context, text: 'مشهورترین فیلم ها',
            //     routeName: MovieScreen.routeName);
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15.0,right: 15.0,top: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('مشهورترین فیلم ها',style: theme.textTheme.titleLarge,),
                      GestureDetector(
                        onTap: (){
                          Navigator.of(context).pushNamed(PopularMovieListScreen.routeName,);
                        },
                        child: Text('مشاهده همه',style: theme.textTheme.titleSmall,),
                      )
                    ],
                  ),

                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0,right: 5),
                  child: SizedBox(
                    width: double.infinity,
                    height: 170,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: 7,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 13.0),
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.pushNamed(context, MovieScreen.routeName,arguments: model.results![index]);
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Container(
                                        height: 140,
                                        width: 90,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          border: Border.all(color: theme.dividerColor,width: 2),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(20),
                                          child: CachedNetworkImage(
                                            fit: BoxFit.cover,
                                            imageUrl: Constants.imagePath + model.results![index].posterPath!,
                                            progressIndicatorBuilder: (context, url, progress) => const ShimmerLoading(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Gap(5),
                                  SizedBox(
                                      width: 80,
                                      child: Text(model.results![index].title!,overflow: TextOverflow.ellipsis,textDirection: TextDirection.rtl,style: theme.textTheme.titleSmall,))
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                )
              ],
            );
          }
          if(state is MovieListError){
            return Text(state.message);
          }
          return Container();
        },
    );
  }
}
