import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:movie_app/features/intro/utils/intro_model.dart';


class IntroPage extends StatelessWidget {
  IntroModel? model;
  IntroPage({super.key, this.model});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    return Stack(
      children: [

        ///---backGroundImage
        Positioned(
          child: Container(
            height: size.height  ,
            width: size.width ,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(model!.backGroundImage!),
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                    colorFilter: const ColorFilter.mode(Colors.black54, BlendMode.color)
                )
            ),
          ),
        ),
        ///---Glasses Container
        Positioned(
          bottom: 0,
          child: DelayedDisplay(
            delay: const Duration(milliseconds: 50),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(topRight: Radius.circular(30) , topLeft: Radius.circular(30)),
              child: GlassmorphicContainer(
                height: size.height/ 1.8,
                width: size.width,
                linearGradient: const LinearGradient(
                  colors: [
                    Colors.white10,
                    Colors.transparent,
                  ],
                ),
                blur: 10,
                border: 0,
                borderRadius: 10,
                borderGradient: const LinearGradient(colors: [
                  Colors.white30,
                  Colors.transparent
                ],),
              ),
            ),
          ),
        ),
        ///---title
        Positioned(
            child: Align(
              child: DelayedDisplay(
                delay: const Duration(seconds: 1),
                child: RichText(
                  text: TextSpan(
                      text: '',
                      style: theme.textTheme.bodyMedium!.copyWith(color: Colors.purpleAccent,fontSize: 30,letterSpacing: 0),
                      children: [
                        TextSpan(text: model!.firstTitle ,style : theme.textTheme.bodyMedium!.copyWith(color: model!.firstTitleColor,fontSize: 30,letterSpacing: 0),),
                        TextSpan(text: model!.secondTitle ,style : theme.textTheme.bodyMedium!.copyWith(color: model!.secondTitleColor,fontSize: 30,letterSpacing: 0),),
                        TextSpan(text: model!.lastTitle ,style : theme.textTheme.bodyMedium!.copyWith(color: Colors.white,fontSize: 30,letterSpacing: 0),),
                      ]
                  ),
                ),
              ),
            ),
          ),
        ///---description
        Positioned(
          bottom: 220,
          child: Align(
            child: DelayedDisplay(
                delay: const Duration(seconds: 1),
                child: Text(model!.description! ,style: theme.textTheme.bodyMedium!.copyWith(color: Colors.white,fontSize: 16))),
          ),
        ),
      ],
    );
  }
}
