import 'package:flutter/material.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';

class CustomSnackBar {
  static showSnack({context,String? message,bool? success,}) {
    IconSnackBar.show(
        context,
        snackBarType: SnackBarType.fail,
        snackBarStyle: SnackBarStyle(backgroundColor: success == true ? Colors.green : Colors.red),
        label: message!,

    );
  }
}

