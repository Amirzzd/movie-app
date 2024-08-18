import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:meta/meta.dart';
import 'package:movie_app/common/resources/data_state.dart';
import 'package:movie_app/features/profile/data/model/user_model.dart';
import 'package:movie_app/features/profile/repository/profile_repository.dart';
part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState>{
  ProfileRepository profileRepository;
  ProfileBloc(this.profileRepository) : super(
      ProfileInitial(),) {
    ///Map
    on<GetUserLocation>((event, emit) async {
      ///cast
      Location location = Location();
      bool serviceEnable = await location.serviceEnabled();
      PermissionStatus permissionStatus = await location.hasPermission();

      ///condition
      if (!serviceEnable){
        serviceEnable = await location.requestService();
      }
      if(permissionStatus == PermissionStatus.denied){
        permissionStatus = await location.requestPermission();
      }
      if(permissionStatus == PermissionStatus.granted){
        emit(PermissionSuccess(locationData: await location.getLocation(),lat: event.lat,lon: event.lon));
       }
      },);

    on<ProfileEvent>((event, emit) async {
      if (event is GetPickImageEvent) {
        emit (PickImageLoading());
        try {

          ImagePicker imagePicker = ImagePicker();
          XFile? xFile = await imagePicker.pickImage(source: ImageSource.gallery);
          if (xFile != null) {
            emit(PickImageSuccess(imgPath: xFile.path, ));
          }

        }catch(ex) {
          emit(PickImageError());
        }
      }
    },);

    ///Profile
    on<UserProfileEvent>((event, emit) async {
      emit(UserProfileLoading());
      DataState dataState = await profileRepository.profileRop();

      dataState is DataSuccess
      ? emit (UserProfileSuccess(model: dataState.data))
      : emit (UserProfileError(message: dataState.message!));
    },);

    ///Edit Profile
    on<EditUserProfileEvent>((event, emit) async {

      emit(EditUserProfileLoading());
      DataState dataState = await profileRepository.editProfileRop(event.name, event.imagePath);

      dataState is DataSuccess
          ? emit (EditUserProfileSuccess(model: dataState.data))
          : emit (EditUserProfileError(message: dataState.message!,));
    },);
  }
}
