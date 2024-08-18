import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gap/gap.dart';
import 'package:movie_app/common/widgets/shimmer_loading.dart';
import 'package:movie_app/config/constants.dart';
import 'package:movie_app/features/bookmark/presentation/bloc/bookmark_bloc.dart';
import 'package:movie_app/features/main/presentation/screens/movie_screen.dart';
import 'package:movie_app/locator.dart';

class BookmarkScreen extends StatelessWidget {
  static const routeName = '/bookmark';
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BookmarkBloc bloc = BookmarkBloc(locator());
    bloc.add(ShowMovies());
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: BlocBuilder(
        bloc: bloc,
          builder: (context, state) {
            if(state is SaveMovieLoadingState){
              return const Center(child: CircularProgressIndicator(),);
            }
            if(state is ShowMovieSuccessState){
              return state.movies.isNotEmpty ? SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10,),
                      Text('فیلم های ذخیره شده',style: theme.textTheme.titleLarge!.copyWith(fontSize: 20),),
                      const SizedBox(height: 20,),
                      AnimationLimiter(
                          child: GridView.builder(
                            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                            shrinkWrap: true,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 1,
                              childAspectRatio: 0.6,
                            ),
                            /// 12
                            itemCount: state.movies.length,
                            itemBuilder: (context, index) {
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
                                                  Navigator.of(context).pushNamed(MovieScreen.routeName,arguments: state.movies[index]);
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(20),
                                                      border: Border.all(color: theme.dividerColor,width: 2)
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(20),
                                                    child: CachedNetworkImage(
                                                      imageUrl: Constants.imagePath + state.movies[index].posterPath!,
                                                      fit: BoxFit.cover,
                                                      progressIndicatorBuilder: (context, url, progress) => const ShimmerLoading(),
                                                      errorWidget: (context, url, error) => ErrorWidget(error),
                                                    ),
                                                  ),
                                                ),
                                              ),

                                            ),
                                            const Gap(5),
                                            Text(state.movies[index].title .toString(),overflow: TextOverflow.ellipsis,textDirection: TextDirection.rtl,style: theme.textTheme.bodyMedium!.copyWith(fontSize: 14),),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                            },
                          )
                      ),
                    ],
                  ),
                ),
              ):  Center(child: Text(' آرشیو شما خالی می باشد',style: theme.textTheme.titleMedium!.copyWith(fontSize: 15),),);
            }
            if(state is ShowMovieFailedState){
              return const Center(child: Text('error'),);
            }
            return const Center(child: Text('initial'),);
          },
      ),
    );
  }
}
