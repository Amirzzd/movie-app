import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/config/constants.dart';
import 'package:movie_app/features/bookmark/data/data_source/model/bookmark_movies_model.dart';
import 'package:movie_app/features/bookmark/presentation/bloc/bookmark_bloc.dart';
import 'package:movie_app/features/main/data/models/movie_list_model.dart';
import 'package:movie_app/locator.dart';

class MovieScreen extends StatefulWidget {
  static const routeName = '/movie_screen';
  const MovieScreen({super.key});

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    super.build(context);
    var model = ModalRoute.of(context)!.settings.arguments as Results;
    var theme = Theme.of(context);
    var size = MediaQuery.of(context).size;
    late Color changeColor = Colors.black;
    BookmarkBloc bloc = BookmarkBloc(locator());
    bloc.add(FindMovie(name: model.title!));

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              width: size.width,
              height: size.height/2,
                top: 0,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(bottomRight: Radius.circular(40),bottomLeft: Radius.circular(40)),

                  child: Container(
                      height: size.height / 2.5,
                      width: size.width,
                      decoration:  BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(Constants.imagePath + model.posterPath!),
                          fit: BoxFit.cover
                        )
                      ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaY: 4,
                        sigmaX: 4,
                      ),
                      child: Container(),
                    ),
                  ),
                ),
            ),
            Positioned(
              top: size.height / 12,
              right: size.width/ 3.5,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: CachedNetworkImage(
                    imageUrl: Constants.imagePath + model.posterPath!, width: size.width/2.5,height: size.height/3,
                    fit: BoxFit.cover,
                  ),
                ),
            ),
            Positioned(
              top: size.height / 2.26,
              right: size.width / 9,
                child:  ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: SizedBox(
                    height: size.height / 9,
                    width: size.width /1.3,
                    child:  Card(
                      elevation: 2,
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(model.originalTitle!,style: theme.textTheme.bodyMedium,),
                          Text(model.title!,style: theme.textTheme.titleMedium),
                        ],
                      ),
                    ),
                  ),
                ),
            ),
            Positioned(
              top: size.height / 3,
              left: 20,
                child:  ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: SizedBox(
                    height: size.height / 12,
                    width: size.width / 6,
                    child:  Card(
                      elevation: 2,
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(model.adult! ? '+18' : '-18' ,textDirection: TextDirection.ltr,style: theme.textTheme.bodyMedium,),
                          Text('رده سنی',style: theme.textTheme.titleMedium!.copyWith(fontSize: 10)),
                        ],
                      ),
                    ),
                  ),
                ),
            ),
            Positioned(
              top: size.height / 3,
              right: 20,
                child:  ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: SizedBox(
                    height: size.height / 12,
                    width: size.width / 6,
                    child:  Card(
                      elevation: 2,
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(model.releaseDate!.split('-').first,textDirection: TextDirection.ltr,style: theme.textTheme.bodyMedium,),
                          Text('سال انتشار',style: theme.textTheme.titleMedium!.copyWith(fontSize: 10)),
                        ],
                      ),
                    ),
                  ),
                ),
            ),
            Positioned(
              top: size.height / 4.2,
              right: 20,
                child:  ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: SizedBox(
                    height: size.height / 12,
                    width: size.width / 6,
                    child:  Card(
                      elevation: 2,
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(model.voteAverage!.toStringAsFixed(1),textDirection: TextDirection.ltr,style: theme.textTheme.bodyMedium,),
                          Text('امتیاز',style: theme.textTheme.titleMedium!.copyWith(fontSize: 10)),
                        ],
                      ),
                    ),
                  ),
                ),
            ),

            ///---overView
            Positioned(
              top: size.height / 1.75,
              left: 0,
              right: 0,
              bottom: 80,
              child:  Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      color: theme.secondaryHeaderColor,
                      width: size.width / 1,
                      child:  Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(model.overview!,textDirection: TextDirection.rtl,maxLines: 9,overflow: TextOverflow.ellipsis,style: theme.textTheme.titleMedium!.copyWith(fontSize: 15,color: Colors.black),),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
            ),
            Positioned(
              top: size.height / 1.14,
              left: 20,
              child:  ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: SizedBox(
                  height: size.height / 14,
                  width: size.width / 7,
                  child:  Card(
                    elevation: 5,
                    color: Colors.white,
                    child: BlocConsumer(
                      bloc: bloc,
                      listener: (context, state) {
                        if(state is SaveMovieSuccessState){
                          changeColor = Colors.green;
                        }
                        if(state is DeleteMovieSuccessState){
                          changeColor = Colors.black;
                        }
                        if(state is FindMovieSuccessState){
                          state.value ? changeColor = theme.primaryColor : changeColor = Colors.black ;
                        }
                      },
                      builder: (context, state) {
                        if (state is SaveMovieSuccessState){
                          return GestureDetector(
                            // onTap: () => bloc.add(DeleteMovie(index: 1)),
                            onTap: () async{
                              // bool changeColor = await locator<SharedPrefOperator>().getButtonColor();
                              },
                            child:  Icon(Icons.bookmark,size: 30, color: theme.primaryColor ,),
                          );
                        }
                        return GestureDetector(
                          onTap: () {
                            if(changeColor == Colors.black){
                              bloc.add(SaveMovie(
                                  name: model.title!,
                                  movie: BookmarkMoviesModel(
                                      originalTitle: model.originalTitle,
                                      title: model.title,
                                      adult: model.adult,
                                      overview: model.overview,
                                      posterPath: model.posterPath,
                                      releaseDate: model.releaseDate,
                                      voteAverage: model.voteAverage
                                  )));
                            } else {
                              bloc.add(DeleteMovie(name: model.title!));
                            }
                          },
                          child:  Icon(Icons.bookmark,size: 30,color: changeColor,),
                        );
                      },
                    )
                  ),
                ),
              ),
            ),
            Positioned(
              top: size.height / 1.14,
              left: 80,
              child:  ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: SizedBox(
                  height: size.height / 14,
                  width: size.width / 7,
                  child:  const Card(
                    elevation: 5,
                    color: Colors.white,
                    child: Icon(Icons.heart_broken_outlined,size: 30,color: Colors.black,),
                  ),
                ),
              ),
            ),
            Positioned(
              top: size.height / 1.14,
              left: 180,
              child:  ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  color: theme.hoverColor,
                  height: size.height / 15,
                  width: size.width / 2,
                  child: TextButton(
                    onPressed: (){},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Icon(CupertinoIcons.cloud_download,color: Colors.white,),
                        const SizedBox(width: 10,),
                        Text(
                            'لینک دانلود فیلم',style: theme.textTheme.bodyMedium!.copyWith(fontSize: 15,color: Colors.white),
                        ),
                        const SizedBox(width: 20,),

                      ],
                    ),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
