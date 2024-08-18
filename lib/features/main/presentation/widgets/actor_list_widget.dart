import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:movie_app/common/widgets/shimmer_loading.dart';
import 'package:movie_app/config/constants.dart';
import 'package:movie_app/features/main/data/models/actors_list_model.dart';
import 'package:movie_app/features/main/presentation/screens/actors_profile_screen.dart';
import 'package:movie_app/locator.dart';
import '../bloc/home_bloc/home_bloc.dart';

class ActorsListWidget extends StatelessWidget {
  const ActorsListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    HomeBloc bloc = HomeBloc(locator());
    bloc.add(ActorsListEvent());

    return BlocBuilder(
        bloc: bloc,
        builder: (context, state) {
          if(state is ActorsListLoading){
            return Container();
          }
          if(state is ActorsListSuccess){
            ActorsListModel model = state.model;
            return Padding(
              padding:  const EdgeInsets.only(top: 15.0,),
              child: SizedBox(
                width: double.infinity,
                height: 120,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 30.0),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: (){
                                  Navigator.pushNamed(context, ActorsProfileScreen.routeName,arguments: model.actorResults![index]);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Container(
                                      height: 80,
                                      width: 80,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(color: theme.dividerColor,width: 2),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          imageUrl: Constants.imagePath + model.actorResults![index].profilePath!,
                                          progressIndicatorBuilder: (context, url, progress) => const ShimmerLoading(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const Gap(5),
                              Text(model.actorResults![index].originalName!,style: theme.textTheme.titleSmall,)
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            );
          }
          if(state is ActorsListError){
            const Text('error');
          }
          return Container();
        }
    );
  }
}

