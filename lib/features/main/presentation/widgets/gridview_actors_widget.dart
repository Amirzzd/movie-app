import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gap/gap.dart';
import 'package:movie_app/config/constants.dart';
import 'package:movie_app/features/main/data/models/actors_list_model.dart';
import 'package:movie_app/features/main/presentation/screens/movie_screen.dart';

Widget gridViewActorsWidget ({required BuildContext context,required ActorResults model}) {
  var theme = Theme.of(context);
  return AnimationLimiter(
    child: GridView.builder(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      padding: const EdgeInsets.all(10),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.6,
      ),
      itemCount: model.knownFor!.length,
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
                        onTap: () => Navigator.pushNamed(context,MovieScreen.routeName,arguments: model),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: theme.dividerColor,width: 2)
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: CachedNetworkImage(
                              imageUrl: Constants.imagePath + model.knownFor![index].posterPath!,fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Gap(5),
                    Text(model.knownFor![index].title ?? model.knownFor![index].name .toString(),overflow: TextOverflow.ellipsis,textDirection: TextDirection.ltr,style: theme.textTheme.bodyMedium!.copyWith(fontSize: 14),),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    ),
  );
}