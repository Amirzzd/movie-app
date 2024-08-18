import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/common/utills/shared_operator.dart';
import 'package:movie_app/features/main/presentation/screens/main_wrapper.dart';
import 'package:movie_app/generated/assets.dart';
import 'package:movie_app/locator.dart';

import 'intro_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    goToNextScreen(context);
  }
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [

            Image.asset(Assets.assetsLogo,height: 300,),

            DelayedDisplay(
              delay: const Duration(milliseconds: 700),
              child: Text(
                'فلیکس فیلم',
                style: theme.textTheme.titleLarge!.copyWith(fontSize: 25),
              ),),

            const SizedBox(height: 180,),

            DelayedDisplay(
              delay: const Duration(milliseconds: 700),
              child: Text(
                'نسخه ۳.۹',
                style: theme.textTheme.titleSmall!.copyWith(fontSize: 15),
              ),
            ),
            const SizedBox(height: 20,
            )
          ],
        ),
      ),
    );
  }
}

 Future goToNextScreen (context) async {
  await Future.delayed(const Duration(seconds: 2));
  if(locator<SharedPrefOperator>().getIntroState()){
    Navigator.pushReplacementNamed(context, IntroScreen.routeName);
  } else {
    Navigator.pushReplacementNamed(context, MainWrapper.routeName);
  }
 }