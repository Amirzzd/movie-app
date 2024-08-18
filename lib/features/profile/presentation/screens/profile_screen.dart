import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:movie_app/common/utills/shared_operator.dart';
import 'package:movie_app/common/widgets/bottom_sheet.dart';
import 'package:movie_app/common/widgets/shimmer_loading.dart';
import 'package:movie_app/config/constants.dart';
import 'package:movie_app/features/profile/data/model/user_model.dart';
import 'package:movie_app/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:movie_app/features/profile/presentation/bloc/theme_bloc/theme_bloc.dart';
import 'package:movie_app/features/profile/presentation/widgets/map_widget.dart';
import 'package:movie_app/locator.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = 'profile';
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with AutomaticKeepAliveClientMixin{
  late ProfileBloc bloc;
  Future getUserLo() async {
  }

  @override
  void initState() {
    super.initState();
    bloc = ProfileBloc(locator());
    bloc.add(GetUserLocation(lon: 0, lat: 0),);
    bloc.add(UserProfileEvent());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var theme = Theme.of(context);
    var size = MediaQuery.of(context).size;

    return BlocProvider(
    create: (context) => ProfileBloc(locator()),
    child: Builder(
      builder: (context) {
        return Scaffold(
          body: BlocBuilder(
            buildWhen: (previous, current) =>
            current is UserProfileLoading || current is UserProfileSuccess || current is UserProfileError,
            bloc: bloc,
              builder: (context, state) {
                if (state is UserProfileLoading) {
                  return Container();
                }
                if (state is UserProfileSuccess) {
                  ProfileModel profileModel = state.model;
                  return Stack(
                    children: [
                      Positioned(
                        child: Container(
                          height: size.height,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                theme.primaryColor,
                                theme.cardColor
                               ],
                              )
                          ),
                        ),
                      ),
                      Positioned(
                        top: size.height / 6,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: Container(
                            height: size.height,
                            width: size.width,
                            color: theme.cardColor,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: size.height / 9,
                                ),
                                Text(profileModel.user!.name!,
                                  style: theme.textTheme.titleLarge,),
                                Text(profileModel.user!.email!,
                                  style: theme.textTheme.labelMedium,)
                              ],
                            ),
                          ),
                        ),
                      ),
    
                      Positioned(
                        top: size.height / 9.2,
                        right: size.width / 2.88,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Container(
                            height: 140,
                            width: 120,
                            color: theme.cardColor,
                          ),
                        ),
                      ),
                      Positioned(
                        top: size.height / 8.4,
                        right: size.width / 2.7,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: SizedBox(
                            height: 100,
                            width: 100,
                            child: CachedNetworkImage(
                              imageUrl: Constants.baseUrl + (profileModel.user!.image ??  '') ,
                              progressIndicatorBuilder: (context, url, progress) => const ShimmerLoading(),
                              errorWidget: (context, url, error) => const Icon(Icons.error),
                            ),
                          )
                        ),
                      ),
                      Positioned(
                          top: size.height / 5,
                          left: size.width / 10,
                          child: BlocBuilder<ThemeBloc,bool>(
                            builder: (context, state) {
                              return GestureDetector(
                                onTap: () {
                                  locator<SharedPrefOperator>().saveThemeMode(!state);
                                  BlocProvider.of<ThemeBloc>(context).add(ChangeThemeEvent(currentThemeModel: !state));
                                },
                                child: state ? Container(
                                    width: 50,
                                    height: 50,
                                    decoration:  BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: theme.primaryColor
                                    ),
                                    child: Icon(Icons.light_mode,color: theme.cardColor,size: 20,)) :
                                    Container(
                                    width: 50,
                                    height: 50,
                                    decoration:  BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: theme.primaryColor
                                    ),
                                    child: Icon(Icons.light_mode,color: theme.cardColor,size: 20,))
                              );
                            },
                          )
                      ),
                      Positioned(
                        right: 20,
                        top: size.height / 2.8,
                        child: SizedBox(
                          height: 200,
                          width: size.width / 1.1,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: MapWidget(bloc: bloc,),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 20,
                          top: size.height / 1.6,
                          child: GestureDetector(
                            onTap: ()async{
                              var value = await BottomSheets.editProfileBottomSheet(context,profileModel,bloc);
                              if(value == true){
                                bloc.add(UserProfileEvent());
                              }
                            },
                            child: Container(
                              height: 60,
                              width: size.width/1.1,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: theme.primaryColor
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                child: Row(
                                  children: [
                                    Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: theme.secondaryHeaderColor,
                                          shape: BoxShape.circle,
                                        ),
                                        child:  Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: ShimmerLoading(child: Icon(Icons.person,color: theme.primaryColor,),
                                          ),
                                        ),
                                      ),
                                    const Gap(15),
                                    Expanded(child: Text('تغییر کاربری',style: theme.textTheme.titleMedium)),
    
                                    const Icon(Icons.arrow_forward_ios,color: Colors.white,),
                                  ],
                                ),
                              ),
                            ),
                          )
                      ),
                      Positioned(
                        right: 20,
                          top: size.height / 1.4,
                          child: GestureDetector(
                            onTap: (){
    
                            },
                            child: Container(
                              height: 60,
                              width: size.width/1.1,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: theme.primaryColor
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                child: Row(
                                  children: [
                                    Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: theme.secondaryHeaderColor,
                                          shape: BoxShape.circle,
                                        ),
                                        child:  Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: ShimmerLoading(child: Icon(Icons.person,color: theme.primaryColor,),
                                          ),
                                        ),
                                      ),
                                    const Gap(15),
                                    Expanded(child: Text(' درباره من ',style: theme.textTheme.titleMedium)),
    
                                    const Icon(Icons.arrow_forward_ios,color: Colors.white,),
                                  ],
                                ),
                              ),
                            ),
                          )
                      ),
                    ],
                  );
                }
                if (state is UserProfileError) {
                  return ErrorWidget(state.message);
                }
                return Container();
              },
              ),
        );
      }
    ),
);
  }
  @override
  bool get wantKeepAlive => true;
}
