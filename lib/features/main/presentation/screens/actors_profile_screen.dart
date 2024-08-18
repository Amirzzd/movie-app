import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/config/constants.dart';
import 'package:movie_app/features/main/presentation/widgets/gridview_actors_widget.dart';
import '../../data/models/actors_list_model.dart';

class ActorsProfileScreen extends StatelessWidget {
  static const routeName = '/actors_profile_screen';

  const ActorsProfileScreen({super.key});


  @override
  Widget build(BuildContext context) {
    ActorResults result = ModalRoute.of(context)!.settings.arguments as ActorResults;
    var theme = Theme.of(context);
    var size = MediaQuery.of(context).size;
    return  Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              left: 0,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(bottomRight: Radius.circular(30)),
                  child: Container(
                    height: size.height/ 3.6,
                    width: size.width / 1.6,
                    color: theme.primaryColor,
                  ),
                ),
            ),
            Positioned(
              right: 0,
                child: Padding(
                  padding: const EdgeInsets.only(top: 60.0,right: 35,),
                  child: Container(
                    width: size.width / 3.8,
                    height: size.height/ 5,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      image: DecorationImage(
                          image: NetworkImage((Constants.imagePath + result.profilePath!),),
                          fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )),
            Positioned(
              top: 15,
              right: 25,
                child: GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(width: 1.5)
                      ),
                      child: const Icon(CupertinoIcons.arrow_right,size: 15,),),
                ),
            ),
            Positioned(
              left: 40,
              top: 50,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: size.width/ 2,
                    height: size.height / 5,
                    color: Colors.white ,
                  ),
                )),
            Positioned(
              left: size.width / 2,
              top: size.height / 11.5,
                child: Text('نام: ',style: theme.textTheme.bodyMedium!.copyWith(fontSize: 15),)),
            Positioned(
              left: size.width / 15,
              top: 0,
                child: Text('بیوگرافی ',style: theme.textTheme.bodyMedium!.copyWith(fontSize: 30,color: Colors.white),)),
            Positioned(
              left: size.width / 8,
              top: size.height / 11.1,
                child: Text(result.originalName.toString(),style: theme.textTheme.bodyMedium!.copyWith(fontSize: 12),)),
            Positioned(
              bottom: 0,
                child:  SizedBox(
                  width: size.width,
                  height: size.height / 1.5,
                  child: gridViewActorsWidget(context: context, model: result),
                ),
            ),
            
          ],
        ),
      ),
    );
  }
}
