import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:movie_app/common/param/login_param.dart';
import 'package:movie_app/common/utills/shared_operator.dart';
import 'package:movie_app/common/widgets/custom_snackbar.dart';
import 'package:movie_app/common/widgets/custom_text_field.dart';
import 'package:movie_app/features/auth/data/models/auth_model.dart';
import 'package:movie_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:movie_app/features/auth/presentation/forget_password_widget.dart';
import 'package:movie_app/locator.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController? email;
  TextEditingController? password;
  ValueNotifier<bool> restarterNotifier = ValueNotifier(false);
  late AuthBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = AuthBloc(locator());
    email = TextEditingController();
    password = TextEditingController();
    BlocProvider.of<AuthBloc>(context).add(ShowPasswordEvent(visibility: false));
  }

  @override
  void dispose() {
    super.dispose();
    email?.dispose();
    password?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FocusNode emailFocusNode = FocusScope.of(context);
    FocusNode passwordFocusNode = FocusScope.of(context);

    var theme = Theme.of(context);
    var size = MediaQuery.of(context).size;

    return Form(
      key: _formKey,
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: ValueListenableBuilder(
              valueListenable: restarterNotifier,
              builder: (context, value, child) {
                return PopScope(
                  canPop: false,
                  onPopInvoked: (didPop) {
                    if(didPop){
                      return;
                    }if(value == true){
                      restarterNotifier.value = !restarterNotifier.value;
                    }else {
                      Navigator.of(context).pop();
                    }
                  },

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                      Text('ایمیل',style: theme.textTheme.titleMedium!,),
                      const Gap(10),
                      CustomTextField(
                        onSubmit: (value){},
                        contentPadding: const EdgeInsets.all(15),
                        textEditingController: email!,
                        hintStyle: theme.textTheme.titleMedium!.copyWith(fontSize:16),
                        style: theme.textTheme.titleMedium!.copyWith(fontSize:16),
                        focusNode: emailFocusNode,
                        onEditingComplete: ()=> emailFocusNode.nextFocus(),
                        hintText: 'ایمیل خود را وارد کنید',
                        validator: (value) {
                          if (value == null) return "can't be empty";
                          if (value.isEmpty) return "can't be empty";

                          if (!value.endsWith(".com") || !value.contains("@")) {
                            return "Email is Invalid";
                          }
                          return null;
                        },
                      ),
                      const Gap(20),
                      ///condition for visibility
                      value == false ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('رمز عبور',style: theme.textTheme.titleMedium!,),
                            const Gap(10),
                            BlocBuilder<AuthBloc, AuthState>(
                              buildWhen: (previous, current) => current is PassWordVisibiltyState,
                              builder: (context, state) {
                                if(state is PassWordVisibiltyState){
                                  return CustomTextField(
                                    onSubmit: (value){
                                      BlocProvider.of<AuthBloc>(context).add(
                                          LoginEvent(loginParam: LoginParam(email: email!.text, password: password!.text),)
                                      );
                                    },
                                    obscureText: state.visibility,
                                    style: theme.textTheme.titleMedium!.copyWith(fontSize:16),
                                    hintStyle: theme.textTheme.titleMedium!.copyWith(fontSize:16),
                                    contentPadding: const EdgeInsets.all(15),
                                    textEditingController: password!,
                                    focusNode: passwordFocusNode,
                                    hintText: 'رمز عبور خود را وارد کنید',
                                    validator: (value) {
                                      if (value == null) return "can't be empty";
                                      if (value.isEmpty) return "can't be empty";

                                      if (value.length < 8) return "password is short";
                                      if (value.length > 12) return "password is long";
                                      return null;
                                    },
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        // showPassword.value = !showPassword.value;
                                        BlocProvider.of<AuthBloc>(context).add(ShowPasswordEvent(visibility: !state.visibility));
                                      },
                                      icon: state.visibility ?
                                      const Icon(Icons.visibility_off):
                                      const Icon(Icons.visibility),
                                    ),
                                  );
                                }
                                return Container();
                              },
                            ),
                            const Gap(40),
                            BlocConsumer<AuthBloc,AuthState>(
                              buildWhen: (previous, current) => current is LoginLoading || current is LoginSuccess || current is LoginError,
                              listenWhen: (previous, current) => current is LoginLoading || current is LoginSuccess || current is LoginError,
                              listener: (context, state) {
                                if(state is LoginSuccess){
                                  AuthModel authModel = state.authModel;
                                  ///save token
                                  locator<SharedPrefOperator>().setUserToken(authModel.token);
                                  Navigator.pop(context);
                                  CustomSnackBar.showSnack(context: context,message : 'خوش آمدی',success: true);
                                }
                                if(state is LoginError){
                                  CustomSnackBar.showSnack(context: context,message : state.message,success: false);
                                }
                              },
                              builder: (context, state) {
                                if(state is LoginLoading){
                                  return const Center(child: CircularProgressIndicator());
                                }
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Container(
                                    color: theme.primaryColor,
                                    height: size.height / 14,
                                    width: size.width / 1.10,
                                    child: TextButton(
                                      onPressed: (){
                                        if(_formKey.currentState!.validate() ){
                                          BlocProvider.of<AuthBloc>(context).add(
                                              LoginEvent(loginParam: LoginParam(email: email!.text, password: password!.text),)
                                          );
                                        }
                                      },
                                      child: Center(
                                        child: Text(
                                          'ورود به حساب کاربری',style: theme.textTheme.bodyMedium!.copyWith(fontSize: 15,color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            const Gap(20),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Container(
                                color: theme.secondaryHeaderColor ,
                                height: size.height / 14,
                                width: size.width / 1.10,
                                child: TextButton(
                                  onPressed: (){
                                    restarterNotifier.value = !restarterNotifier.value;
                                  },
                                  child: Center(
                                    child: Text(
                                      'فراموشی رمز عبور',style: theme.textTheme.bodyMedium!.copyWith(fontSize: 15),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ]
                      ):    GestureDetector(
                          child: forgetPasswordWidget( context,email!.text,)),
                    ],
                  ),
                );
              },
          )
      ),
    );
  }
}
