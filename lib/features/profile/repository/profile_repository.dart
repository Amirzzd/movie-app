import 'package:dio/dio.dart';
import 'package:movie_app/common/error_handling/check_exceptions.dart';
import 'package:movie_app/common/resources/data_state.dart';
import 'package:movie_app/features/profile/data/data_source/remote/profile_api_provider.dart';
import 'package:movie_app/features/profile/data/model/user_model.dart';

class ProfileRepository {
  ProfileApiProvider apiProvider;
  ProfileRepository(this.apiProvider);

  Future<DataState<dynamic>> profileRop ()async{
    try{
      Response response = await apiProvider.profile();
      return DataSuccess(ProfileModel.fromJson(response.data));
    }catch(e){
      return CheckExceptions.getError(e);
    }
  }

  Future<DataState<dynamic>> editProfileRop (String name ,String imagePath)async{
    try{
      Response response = await apiProvider.editProfile(name,imagePath);
      return DataSuccess(ProfileModel.fromJson(response.data));
    }catch(e){
      return CheckExceptions.getError(e);
    }
  }

}