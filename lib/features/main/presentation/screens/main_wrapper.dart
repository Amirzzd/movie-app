import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:movie_app/common/utills/shared_operator.dart';
import 'package:movie_app/common/widgets/bottom_sheet.dart';
import 'package:movie_app/features/bookmark/presentation/bloc/bookmark_bloc.dart';
import 'package:movie_app/features/bookmark/presentation/bookmark_screen.dart';
import 'package:movie_app/features/download/presentation/screens/download_screen.dart';
import 'package:movie_app/features/main/presentation/bloc/home_bloc/home_bloc.dart';
import 'package:movie_app/features/main/presentation/screens/home_screen.dart';
import 'package:movie_app/features/profile/presentation/screens/profile_screen.dart';
import 'package:movie_app/locator.dart';

import '../bloc/bottom_nav_bloc/bottom_nav_bloc.dart';


class MainWrapper extends StatefulWidget {
  static const routeName = '/main_wrapper';

  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  late PageController pageController;
  late BottomNavBloc bloc;
  @override
  void initState() {
    super.initState();
    pageController = PageController();
    bloc = BottomNavBloc();

  }

  @override
  Widget build(BuildContext context) {

    var theme = Theme.of(context);
    List<Widget> bottomNavScreens = [
      const HomeScreen(),
      const BookmarkScreen(),
      const DownloadScreen(),
      const ProfileScreen(),
    ];

    return  MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => HomeBloc(locator()),),
          BlocProvider(create: (context) => BookmarkBloc(locator()),)
        ],

        child: PopScope(
          canPop: false,
          onPopInvoked: (didPop) {
            if(didPop == true){
              bloc.add(ChangeIndex(index: 0));
            }
          },
          child: Scaffold(
            body: SafeArea(
              child: PageView(
               physics: const NeverScrollableScrollPhysics(),
                controller: pageController,
                children: bottomNavScreens,
              ),
            ),
            bottomNavigationBar: GNav(
                  selectedIndex: bloc.state.index,
                  tabMargin: const EdgeInsets.all(10),
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  tabBorderRadius: 15,
                  color: Colors.white,
                  activeColor: Colors.white,
                  backgroundColor: theme.bottomAppBarTheme.color!,
                  tabBackgroundColor: theme.hoverColor,
                  gap: 8,
                  onTabChange: (index){
                    ///check user login
                    bloc.add(ChangeIndex(index: index));
                    if(index == 3 && !locator<SharedPrefOperator>().getLoggedIn()) {
                      BottomSheets.userCheckProfileCheckBottomSheet(context);
                      bloc.add(ChangeIndex(index: 0));
                    }else {
                      pageController.animateToPage(
                          index, duration: const Duration(seconds: 1),
                          curve: Curves.easeInOut,
                      );
                    }
                  },
                  padding: const EdgeInsets.all(10),
                  tabs: [
                    GButton(
                      curve: Curves.easeInOut,
                      padding: const EdgeInsets.all(6),
                      margin: const EdgeInsets.all(15),
                      icon: CupertinoIcons.house_alt,
                      text: 'خانه',
                      textStyle: theme.textTheme.titleMedium!.copyWith(color: Colors.white,fontSize: 14),
                    ),
                    GButton(
                      icon: CupertinoIcons.archivebox,
                      text: 'آرشیو',
                      textStyle: theme.textTheme.titleMedium!.copyWith(color: Colors.white,fontSize: 14),
                    ),
                    GButton(
                      icon:  CupertinoIcons.tray_arrow_down_fill,
                      text: 'دانلودها',
                      textStyle: theme.textTheme.titleMedium!.copyWith(color: Colors.white,fontSize: 14),
                    ),
                    GButton(
                      icon: CupertinoIcons.person,
                      text: 'پروفایل',
                      onPressed: (){},
                      textStyle: theme.textTheme.titleMedium!.copyWith(color: Colors.white,fontSize: 14),
                    ),
                  ]
              ),
          ),
        ),
    );
  }
  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
    bloc.close();
  }
}
