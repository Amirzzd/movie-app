import 'package:dio/dio.dart';

class ProfileApiProvider {
  Dio dio;
  ProfileApiProvider(this.dio);
  
  dynamic profile () async{
    Response response = await dio.get('users/me');
    return response;
  }

  dynamic editProfile (String name , String imagePath ) async {
    FormData data = FormData.fromMap({
      'name' : name,
      'image': await MultipartFile.fromFile(imagePath),
    });
     Response response = await dio.post( 'users/me',
        data: data
    );
     return response;
  }
}