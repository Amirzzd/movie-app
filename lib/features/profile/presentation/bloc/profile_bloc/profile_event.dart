
part of 'profile_bloc.dart';

sealed class ProfileEvent {}



 class GetPickImageEvent extends ProfileEvent {}


class GetUserLocation extends ProfileEvent {
  double lat;
  double lon;
  GetUserLocation({required this.lat,required this.lon});
}

class UserProfileEvent extends ProfileEvent {}

class EditUserProfileEvent extends ProfileEvent {
  String name;
  String imagePath;

  EditUserProfileEvent({required this.name,required this.imagePath});
}

class PickImage extends ProfileEvent {}

