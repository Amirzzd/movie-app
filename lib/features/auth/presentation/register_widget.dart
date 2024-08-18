import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:movie_app/common/param/register_param.dart';
import 'package:movie_app/common/utills/shared_operator.dart';
import 'package:movie_app/common/widgets/custom_snackbar.dart';
import 'package:movie_app/common/widgets/custom_text_field.dart';
import 'package:movie_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:movie_app/locator.dart';
import '../data/models/auth_model.dart';

class RegisterWidget extends StatefulWidget {
  const RegisterWidget({super.key});

  @override
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  final formKey = GlobalKey<FormState>();
  TextEditingController? userName;
  TextEditingController? email;
  TextEditingController? password;

  @override
  void initState() {
    super.initState();
    userName = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();

  }

  @override
  void dispose() {
    super.dispose();
    userName?.dispose();
    email?.dispose();
    password?.dispose();

  }
  @override
  Widget build(BuildContext context) {
    FocusNode emailFocusNode = FocusScope.of(context);
    FocusNode passwordFocusNode = FocusScope.of(context);
    FocusNode userNameFocusNode = FocusScope.of(context);

    var theme = Theme.of(context);
    var size = MediaQuery.of(context).size;

    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('نام کاربری',style: theme.textTheme.titleMedium!,),
            CustomTextField(
              textEditingController: userName!,
              hintText: 'نام کاربری را وارد کنید',
              hintStyle: theme.textTheme.titleMedium!.copyWith(fontSize:16 ),
              onSubmit: (value){},
              style: theme.textTheme.titleMedium!.copyWith(fontSize:16),
              focusNode: userNameFocusNode,
              onEditingComplete:()=> emailFocusNode.nextFocus(),
              contentPadding: const EdgeInsets.all( 15),
              validator: (value) {
                if (value == null) return "cant be empty";
                if (value.isEmpty) return "cant be empty";

                if (value.length > 40) {
                  return "Name is too long";
                }
                return null;
              },
            ),

            const Gap(10),

            Text('ایمیل',style: theme.textTheme.titleMedium!,),
            CustomTextField(
              onSubmit: (value){},
              contentPadding: const EdgeInsets.all(15),
              textEditingController: email!,
              focusNode: emailFocusNode,
              style: theme.textTheme.titleMedium!.copyWith(fontSize:16),
              hintStyle: theme.textTheme.titleMedium!.copyWith(fontSize:16 ),
              onEditingComplete: () => passwordFocusNode.nextFocus(),
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

            const Gap(10),

            Text('رمز عبور',style: theme.textTheme.titleMedium!,),

            BlocBuilder<AuthBloc, AuthState>(
              buildWhen: (previous, current) => current is PassWordVisibiltyState,
              builder: (context, state) {
                if(state is PassWordVisibiltyState){
                  return CustomTextField(
                    onSubmit: (value){
                      BlocProvider.of<AuthBloc>(context).add(
                          RegisterEvent(
                            registerParam: RegisterParam(email:email!.text ,name: userName!.text ,password: password!.text ),)
                      );
                    },
                    obscureText: state.visibility,
                    style: theme.textTheme.titleMedium!.copyWith(fontSize:16),
                    contentPadding: const EdgeInsets.all(15),
                    textEditingController: password!,
                    hintStyle: theme.textTheme.titleMedium!.copyWith(fontSize:16 ),
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
            const Gap(10),

            BlocConsumer<AuthBloc,AuthState>(
            buildWhen: (previous, current) => previous != current,
            listenWhen: (previous, current) => previous != current,
              listener: (context, state) {
                if(state is RegisterSuccess){
                  AuthModel authModel = state.authModel;
                  ///save token
                  locator<SharedPrefOperator>().setUserToken(authModel.token);
                  Navigator.pop(context);
                  CustomSnackBar.showSnack(context: context,message : 'خوش آمدی',success: true);
                }
                if(state is RegisterError){
                  CustomSnackBar.showSnack(context: context,message : state.message,success: false);
                }
              },
              builder: (context, state) {
                if(state is RegisterLoading){
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
                        if(formKey.currentState!.validate() ){
                          BlocProvider.of<AuthBloc>(context).add(
                              RegisterEvent(
                                registerParam: RegisterParam(email:email!.text ,name: userName!.text ,password: password!.text ),)
                          );
                        }
                      },
                      child: Center(
                        child: Text(
                          'ایحاد حساب کاربری',style: theme.textTheme.bodyMedium!.copyWith(fontSize: 15,color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                );            },
            ),            const Gap(20),
          ],
        ),
      ),
    );
  }
}
