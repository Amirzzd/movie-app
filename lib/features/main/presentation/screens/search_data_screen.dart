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

class SearchDataScreen extends StatefulWidget {
  static const routeName = '/search';

  const SearchDataScreen({super.key});

  @override
  State<SearchDataScreen> createState() => _SearchDataScreen();
}

class _SearchDataScreen extends State<SearchDataScreen> {
  late ScrollController scrollController;
  List<Results> movies = [];
  int page = 1;
  late HomeBloc bloc;


  @override
  void initState() {
    super.initState();
    bloc = HomeBloc(locator());
    scrollController = ScrollController();
  }
  @override
  void dispose() {
    super.dispose();
    bloc.close();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // List<Results> movies = [];

    String name = ModalRoute.of(context)!.settings.arguments as String;
    bloc.add(SearchMovieEvent(name: name,page: page,));

    var theme = Theme.of(context);
    paginate(context,name);

    return Scaffold(
        body: SafeArea(
          child: BlocBuilder(
            bloc: bloc,
            builder: (context, state) {
              if(state is SearchMovieListLoading){
                return Container();
              }if(state is SearchMovieListSuccess){
                // movies.addAll(state.model.results!);
                movies.addAll(state.model.results!);
              return Scaffold(
                  body: Column(
                    children: [
                      Expanded(
                        child: AnimationLimiter(
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
                              /// 20
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
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 18.0),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: const ShimmerLoading(),
                                    ),
                                  );
                                }
                              },
                            )
                        ),
                      ),
                    ],
                  ),
                );
              }if(state is SearchMovieListError){
                return Text(state.message);
              }
              return Container();
            },
          ),
        )
    );
  }

  void paginate(BuildContext context,String name,){
    scrollController.addListener((){
      if(scrollController.position.atEdge && scrollController.position.pixels != 0 && bloc.hasReachMax == false ){
        bloc.add(SearchMovieEvent( page: ++page, name: name,));
        }
      }
    );
  }
}
