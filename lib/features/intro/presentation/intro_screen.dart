import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/common/utills/shared_operator.dart';
import 'package:movie_app/common/widgets/smooth_page.dart';
import 'package:movie_app/features/intro/presentation/bloc/intro_bloc.dart';
import 'package:movie_app/features/intro/utils/intro_model.dart';
import 'package:movie_app/features/intro/widgets/intro_widget.dart';
import 'package:movie_app/generated/assets.dart';
import 'package:movie_app/locator.dart';

import '../../main/presentation/screens/main_wrapper.dart';

class IntroScreen extends StatefulWidget {
  static const routeName = '/intro_screen';
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {


  late final PageController pageController;

  IntroBloc bloc = IntroBloc();

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    bloc.add(GetStartEvent(value: false));
    final size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    final List<IntroPage> introPages = [
      IntroPage(model: IntroModel(
        backGroundImage: Assets.assetsIntroSceen1,
        description: ' آرشیو فلیکس فیلم با بیش از 50 هزار قسمت فیلم و\n سریال آمریکایی،چینی،ژاپنی،کره ای شما را از هر منبع \n دیگری بی نیاز می کنه' ,
        firstTitle: '        بزرگ ترین',
        firstTitleColor: theme.primaryColor,
        lastTitle: '   فیلم و سریال های دنیا',
        secondTitle: ' آرشیو\n',
        secondTitleColor: Colors.white,
      ),),
      IntroPage(model: IntroModel(
        backGroundImage: Assets.assetsIntroScreen2,
        description: ' شما میتونید فیلم و سریال های مورد علاقه خودتون رو \n با کیفیت های متنوع مثل 720p 540p 480p 360p به \n راحتی تماشا کنید.' ,
        firstTitle: 'تنوع',
        firstTitleColor: Colors.white,
        lastTitle: '       بالا',
        secondTitle: ' کیفیت\n',
        secondTitleColor: theme.primaryColor,
      ),),
      IntroPage(model: IntroModel(
        backGroundImage: Assets.assetsIntroScreen3,
        description: ' دیگه نیازی نیست دنبال زیرنویس بگردین تو فلیکس \n فیلم همه ی فیم و سریال همراه با زیرنویس فارسی \n هستند.' ,
        firstTitle: '       زیرنویس\n',
        firstTitleColor: theme.primaryColor,
        lastTitle: 'فارسی و چسبیده',
        secondTitle: '',
        secondTitleColor: theme.primaryColor,
      ),),

    ];


    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            width: size.width,
            height: size.height,
            child: PageView(
              controller: pageController,
              children: introPages,
            ),
          ),
          Positioned(
            left: 20,
              bottom: 20,
              child: Row(
                children: [
                  BlocBuilder<IntroBloc, IntroState>(
                    bloc: bloc,
                    builder: (context, state) {
                      if(state is ChangeGetStarted){
                        return Text('بعدی',style : theme.textTheme.bodyMedium!.copyWith(color : Colors.white,fontSize: 30,letterSpacing: 0));
                      }
                      return Text('تمام',style : theme.textTheme.bodyMedium!.copyWith(color : Colors.white,fontSize: 30,letterSpacing: 0));
                    },
                ),
                  const SizedBox(width: 20,),
                  FloatingActionButton(
                        backgroundColor: Colors.white,
                        hoverColor: Colors.purpleAccent,
                        child: const Icon(Icons.keyboard_arrow_left),
                        onPressed: () {
                          if(pageController.page!.toInt() < 2){
                            pageController.animateToPage(pageController.page!.toInt() + 1, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                          } if(pageController.page!.toInt() == 1){
                            bloc.add(GetStartEvent(value: true));
                          } if (pageController.page!.toInt() == 2){
                            locator<SharedPrefOperator>().saveIntroState();
                            Navigator.pushNamedAndRemoveUntil(context, MainWrapper.routeName,ModalRoute.withName(MainWrapper.routeName),);
                          }
                        }
                      ),
                ],
              )
          ),
          Positioned(
            bottom: 36,
              right: 20,
              child: SmoothPage(
                height: 15,
                width: 15,
                pageController: pageController,
              )
          )
        ],
      ),
    );
  }
}
