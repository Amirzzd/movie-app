import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SmoothPage extends StatelessWidget {
  final PageController? pageController;
  final double? width;
  final double? height;
  const SmoothPage({super.key,this.pageController,this.width,this.height});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return SmoothPageIndicator(
      controller: pageController!,
      count: 3,
      axisDirection: Axis.horizontal,
      effect: ExpandingDotsEffect(
          spacing: 4,
          activeDotColor: theme.primaryColor,
          dotWidth: width!,
          dotHeight: height!,
          dotColor: theme.secondaryHeaderColor
      ),
    );
  }
}
