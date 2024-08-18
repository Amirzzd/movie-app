import 'package:flutter/material.dart';

class DownloadScreen extends StatelessWidget {
  const DownloadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      body: Center(child: Text('بزودی', style: theme.textTheme.titleMedium!.copyWith(fontSize: 40),)),
    );
  }
}
