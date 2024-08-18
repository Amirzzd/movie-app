import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:movie_app/common/widgets/shimmer_loading.dart';
import 'package:movie_app/common/widgets/smooth_page.dart';
import 'package:movie_app/config/constants.dart';
import 'package:movie_app/features/main/data/models/movie_list_model.dart';
import 'package:movie_app/locator.dart';

import '../bloc/home_bloc/home_bloc.dart';
import '../screens/movie_screen.dart';

class TopMovieWidgets extends StatefulWidget {
  const TopMovieWidgets({super.key});

  @override
  State<TopMovieWidgets> createState() => _TopMovieWidgetsState();
}

class _TopMovieWidgetsState extends State<TopMovieWidgets> {
  PageController? pageController;
  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }
  @override
  Widget build(BuildContext context) {
    HomeBloc bloc = HomeBloc(locator());
    var theme = Theme.of(context);
    bloc.add(TopMovieEvent());

    return BlocBuilder(
        bloc: bloc,
        builder: (context, state) {
          if(state is TopMovieLoading){
            return Container();
          }
          if(state is TopMovieSuccess){
            MovieListModel model = state.model;
            return Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: SizedBox(
                height: 160,
                width: 340,
                child: PageView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  controller: pageController,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.of(context).pushNamed(MovieScreen.routeName,arguments: model.results![index]);
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              height: 140,
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: theme.dividerColor,width: 2),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: CachedNetworkImage(
                                  imageUrl: Constants.imagePath + model.results![index].backdropPath!,
                                  fit: BoxFit.cover,
                                  progressIndicatorBuilder: (context, url, progress) => const ShimmerLoading(),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Gap(10),
                        SmoothPage(
                          height: 6,
                          width: 6,
                          pageController: pageController,
                        ),
                      ],
                    );
                  },
                ),
              ),
            );
          }
          if(state is TopMovieError){
            const Text('error');
          }
          return Container();
        }
    );

  }
  @override
  void dispose() {
    super.dispose();
    pageController!.dispose();
  }
}
