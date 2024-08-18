import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/common/utills/shared_operator.dart';
import 'package:movie_app/common/widgets/custom_snackbar.dart';
import 'package:movie_app/features/auth/data/models/auth_model.dart';
import 'package:movie_app/locator.dart';

import 'bloc/auth_bloc.dart';

Widget forgetPasswordWidget (BuildContext context ,String email){
    var theme = Theme.of(context);
    var size = MediaQuery.of(context).size;
    AuthBloc authBloc = AuthBloc(locator());

  return BlocProvider.value(
  value: authBloc,
  child: BlocConsumer(
    bloc: authBloc,
    listener: (context, state) {
        if(state is ForgetPasswordSuccess){
          AuthModel authModel = state.authModel;
          ///save token
          locator<SharedPrefOperator>().setUserToken(authModel.token);
          Navigator.pop(context);
          CustomSnackBar.showSnack(context: context,message : 'خوش آمدی',success: true);
        }
        if(state is ForgetPasswordError){
          CustomSnackBar.showSnack(context: context,message : state.message,success: false);
        }
    },
    builder: (context, state) {
      if(state is ForgetPasswordLoading){
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      return ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
            color: Colors.purple ,
            height: size.height / 14,
            width: size.width / 1.10,
            child: TextButton(
              onPressed: (){
              },
              child: Center(
                child: Text(
                  'ارسال کد تایید به ایمیل',style: theme.textTheme.bodyMedium!.copyWith(fontSize: 15,color: Colors.white),
                ),
              ),
            )
        ),
      );
    },
   ),
  );
}