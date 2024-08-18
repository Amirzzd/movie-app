import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:movie_app/common/widgets/custom_snackbar.dart';
import 'package:movie_app/common/widgets/custom_text_field.dart';
import 'package:movie_app/config/constants.dart';
import 'package:movie_app/features/auth/presentation/login_widget.dart';
import 'package:movie_app/features/auth/presentation/register_widget.dart';
import 'package:movie_app/features/profile/data/model/user_model.dart';
import 'package:movie_app/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:movie_app/generated/assets.dart';
import 'package:movie_app/locator.dart';

import '../../features/auth/presentation/bloc/auth_bloc.dart';

class BottomSheets{


  static void userCheckProfileCheckBottomSheet (context){
    var size = MediaQuery.of(context).size;
    final ThemeData theme = Theme.of(context);

    showModalBottomSheet(
      isScrollControlled: false,
      elevation: 20,
      backgroundColor: theme.cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topRight: Radius.circular(50), topLeft: Radius.circular(50)),
      ),
      context: context,
      builder: (context) {
        return ClipRRect(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: BorderDirectional(top: BorderSide(width: 15,color: theme.primaryColor))
            ),
            child: Stack(
              children: [
                Positioned(
                    child: SizedBox(
                      height: size.height / 2,
                      width: size.width,
                    )
                ),
                Positioned(
                    right: size.width / 2.8,
                    top: 16,
                    child: Container(
                      color: Colors.grey.shade300,
                      height: 4,
                      width: 100,
                    )
                ),
                Positioned(
                    left: size.width / 2.5,
                    child: Lottie.asset(Assets.assetsAnimation),
                ),
                Positioned(
                    left: size.width / 11,
                    top: 180,
                    child:  Text(
                      'برای استفاده از این بخش باید وارد بشی',
                      style: theme.textTheme.titleLarge,
                    )
                ),
                Positioned(
                    left: size.width / 6,
                    top: 220,
                    child:  Text(
                      'نظرت چیه توی بزرگ ترین اپلیکیشن فیلم\n ثبت نام کنی تا بتونی از همه ی قابلیت ها \n                 استفاده کنی؟',
                      style: theme.textTheme.titleMedium,
                    )
                ),
                ///go
                Positioned(
                  left: size.width / 14,
                  bottom: 25,
                  child:  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      color: theme.primaryColor,
                      height: size.height / 18,
                      width: size.width / 2.8,
                      child: TextButton(
                        onPressed: (){
                          Navigator.of(context).pop();
                          BottomSheets.loginAndRegisterBottomSheet(context);

                        },
                        child: Center(
                          child: Text(
                            'بزن بریم',style: theme.textTheme.bodyMedium!.copyWith(fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                ///back
                Positioned(
                  left: size.width / 1.9,
                  bottom: 25,
                  child:  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      color: theme.secondaryHeaderColor,
                      height: size.height / 18,
                      width: size.width / 2.8,
                      child: TextButton(
                        onPressed: (){
                          Navigator.of(context).pop();
                        },
                        child: Center(
                          child: Text(
                            'بعدا میام',style: theme.textTheme.bodyMedium!.copyWith(fontSize: 15,),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void loginAndRegisterBottomSheet  (context){

    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    showModalBottomSheet(
      isScrollControlled: true,
      elevation: 20,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topRight: Radius.circular(80), topLeft: Radius.circular(80)),
      ),
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(topRight: Radius.circular(60) , topLeft: Radius.circular(60)),
            border: BorderDirectional(top: BorderSide(width: 15,color: theme.primaryColor)),),
            height: size.height / 1.4,
            width: size.width,
            child: DefaultTabController(
              length: 2,
              child: GestureDetector(
                onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(topRight: Radius.circular(50), topLeft: Radius.circular(50)),
                  child: Scaffold(
                    resizeToAvoidBottomInset: false,
                    body: Column(
                      children: [
                        Container(
                          color: Colors.blue,
                        ),
                        SizedBox(
                          height: size.height / 1.5,
                          width: size.width,
                          child: Stack(
                            children: [
                              Column(
                                children: <Widget>[
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    color: theme.secondaryHeaderColor,
                                    height: 4,
                                    width: 100,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 18),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Container(
                                        color: theme.secondaryHeaderColor,
                                        child: TabBar(
                                          indicatorColor: Colors.grey.shade400,
                                          indicator: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: theme.primaryColor
                                          ),
                                          overlayColor: const WidgetStatePropertyAll(Colors.transparent),
                                          labelStyle: theme.textTheme.bodyMedium!.copyWith(color: Colors.white),
                                          unselectedLabelStyle: theme.textTheme.bodyMedium!.copyWith(color: Colors.black),
                                          indicatorSize: TabBarIndicatorSize.tab,
                                          tabs: const [

                                          Tab(
                                            text: 'ورود',
                                          ),
                                          Tab(
                                            text: 'ثبت نام',
                                          ),
                                        ],
                                        ),
                                      ),
                                    ),
                                  ),
                                    BlocProvider(
                                      create: (context) => AuthBloc(locator()),
                                      child: const Flexible(
                                      child: TabBarView(
                                        children: [
                                          LoginWidget(),
                                          RegisterWidget(),
                                        ],
                                      ),
                                      ),),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static editProfileBottomSheet  (context,ProfileModel profileModel,ProfileBloc bloc) async {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    String image = '';
    final formKey = GlobalKey<FormState>();
    TextEditingController userNameController = TextEditingController();

    bool value = await showModalBottomSheet(
      isScrollControlled: true,
      elevation: 20,
      backgroundColor: Colors.black,
      context: context,
      builder: (context) {
      return Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
            child: Container(
              height: size.height / 2.5,
              width: size.width,
              color: Colors.white,
              child: Column(
                children: [
                  const Gap(20),
                  GestureDetector(
                    onTap: () {
                        bloc.add(GetPickImageEvent());
                    },
                    child: BlocBuilder(
                      bloc: bloc,
                        builder: (context, state) {
                          if(state is PickImageSuccess){
                            return Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                  border: Border.all(color: theme.dividerColor,width: 2),
                                  image: DecorationImage(
                                    image: FileImage(File(state.imgPath)),),
                                    shape: BoxShape.circle,
                              ),
                              child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                          color: theme.primaryColor,
                                          shape: BoxShape.circle
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.all(3.0),
                                        child: Icon(Icons.edit,size: 20,color:  Colors.black,),
                                      ))
                              ),
                            );
                          }

                          return Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                border: Border.all(color: theme.dividerColor,width: 2),
                                image: DecorationImage(
                                  image: NetworkImage(Constants.baseUrl + (profileModel.user!.image ?? "")),
                                ),
                                shape: BoxShape.circle
                            ),
                            child: Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                        color: theme.primaryColor,
                                        shape: BoxShape.circle
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(3.0),
                                      child: Icon(Icons.edit,size: 20,color:  Colors.black,),
                                    ))
                            ),
                          );
                        },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('نام کاربری',style: theme.textTheme.titleMedium!.copyWith(color: Colors.black,fontSize: 20),),
                        const Gap(10),
                        CustomTextField(
                          contentPadding: const EdgeInsets.all(15),
                          textEditingController: userNameController,
                          maxLength: 20,
                          style: theme.textTheme.titleMedium!.copyWith(fontSize:16,color: Colors.black),
                          hintStyle: theme.textTheme.titleMedium!.copyWith(fontSize:16,color: Colors.grey.shade400),
                          hintText: profileModel.user!.name!,
                          validator: (value) {
                            if (value == null) return "cant be empty";
                            if (value.isEmpty) return "cant be empty";
                            if(value == profileModel.user!.name!) return 'نام کاربری را تغییر دهید';
                            return null;
                          },
                          onSubmit: (value) {},
                        ),
                        const Gap(15),
                        BlocConsumer(
                          buildWhen: (previous, current) =>
                          current is EditUserProfileError || current is EditUserProfileSuccess || current is EditUserProfileLoading,
                          bloc: bloc,
                          listener: (context, state) {
                            if (state is PickImageSuccess){
                              image = state.imgPath;
                            }
                            if(state is EditUserProfileError){
                              CustomSnackBar.showSnack(context: context,message : state.message,success: false,);
                              Navigator.pop(context,false);

                            }
                            if(state is EditUserProfileSuccess){
                              CustomSnackBar.showSnack(context: context,message : 'موفقیت آمیز',success: true);
                              Navigator.pop(context,true);
                            }
                          },
                          builder: (context, state) {
                            if(state is EditUserProfileLoading){
                              return const Center(child: CircularProgressIndicator());
                            }
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Container(
                                color: theme.primaryColor ,
                                height: size.height / 14,
                                width: size.width / 1.10,
                                child: TextButton(
                                  onPressed: (){
                                      if (formKey.currentState!.validate() && image.isNotEmpty) {
                                        bloc.add(EditUserProfileEvent(
                                          name: userNameController.text,
                                          imagePath: image,));
                                      }
                                  },
                                  child: Center(
                                    child: Text(
                                      'ذخیره',style: theme.textTheme.bodyMedium!.copyWith(fontSize: 15),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),

                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
      },
    );
    return value;
   }
  }