import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gap/gap.dart';
import 'package:movie_app/common/widgets/shimmer_loading.dart';
import 'package:movie_app/config/constants.dart';
import 'package:movie_app/features/main/data/models/movie_list_model.dart';
import 'package:movie_app/features/main/presentation/bloc/home_bloc/home_bloc.dart';
import 'package:movie_app/locator.dart';
import 'movie_screen.dart';

class UpcomingMovieListScreen extends StatefulWidget {
  static const routeName = '/upcoming';

  const UpcomingMovieListScreen({super.key});

  @override
  State<UpcomingMovieListScreen> createState() => _UpcomingMovieListScreen();
}

class _UpcomingMovieListScreen extends State<UpcomingMovieListScreen> {
  late ScrollController scrollController;
  late HomeBloc bloc;
  List<Results> movies = [];
  int page = 1;


  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    bloc = HomeBloc(locator());
    bloc.add(LoadUpcomingMovieListEvent(page: page,));
  }
  @override
  void dispose() {
    super.dispose();
    bloc.close();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    paginate(context);

    return Scaffold(
        body: SafeArea(
          child: BlocBuilder(
            bloc: bloc,
            buildWhen: (previous, current) => previous != current,
            builder: (context, state) {
              if(state is UpComingMovieListLoading){
                return Container();
              }if(state is UpComingMovieListSuccess){
                movies.addAll(state.model.results!);
                return Scaffold(
                  body: AnimationLimiter(
                      child: GridView.builder(
                        controller: scrollController,
                        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                        padding: const EdgeInsets.all(10),
                        shrinkWrap: true,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 1,
                          childAspectRatio: 0.6,
                        ),
                        /// 12
                        itemCount: bloc.hasReachMax ? movies.length : (movies.length) + 2,
                        itemBuilder: (context, index) {
                          if( index < movies.length ) {
                            return GestureDetector(
                              onTap: (){
                              },
                              child: AnimationConfiguration.staggeredGrid(
                                position: index,
                                duration: const Duration(milliseconds: 300),
                                columnCount: 3,
                                child: SlideAnimation(
                                  child: FadeInAnimation(
                                    child: Column(
                                      children: [
                                        Flexible(
                                          child: GestureDetector(
                                            onTap: (){
                                              Navigator.of(context).pushNamed(MovieScreen.routeName,arguments: movies[index]);
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(20),
                                                  border: Border.all(color: theme.dividerColor,width: 2)
                                              ),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(20),
                                                child: CachedNetworkImage(
                                                  imageUrl: Constants.imagePath + movies[index].posterPath!,
                                                  fit: BoxFit.cover,
                                                  progressIndicatorBuilder: (context, url, progress) => const ShimmerLoading(),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Gap(5),
                                        Text(movies[index].title .toString(),overflow: TextOverflow.ellipsis,textDirection: TextDirection.rtl,style: theme.textTheme.bodyMedium!.copyWith(fontSize: 14),),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          } else{
                            return  Padding(
                              padding: const EdgeInsets.symmetric(vertical: 18.0),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: const CircularProgressIndicator()),
                            );
                          }
                        },
                      )
                  ),
                );
              }if(state is UpComingMovieListError){
                return Text(state.message);
              }
              return Container();
            },
          ),
        )
    );
  }

  void paginate(BuildContext context){
    scrollController.addListener((){
        if(scrollController.position.atEdge && scrollController.position.pixels != 0 && bloc.hasReachMax == false ){
          bloc.add(LoadUpcomingMovieListEvent(
            page: ++page,
          ));
        }
      }
    );
  }
}
