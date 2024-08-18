part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

///google map state
class PermissionSuccess extends ProfileState{
  final LocationData locationData;
  final double lon;
  final double lat;

  PermissionSuccess({required this.locationData,required this.lat,required this.lon});
}

///Profile State

class UserProfileLoading extends ProfileState {}
class UserProfileSuccess extends ProfileState {
  final ProfileModel model;

  UserProfileSuccess({required this.model});
}
class UserProfileError extends ProfileState {
  final String message;

  UserProfileError({required this.message});
}

///edit Profile State

class EditUserProfileLoading extends ProfileState {}
class EditUserProfileSuccess extends ProfileState {
  final ProfileModel model;
  EditUserProfileSuccess({required this.model});
}
class EditUserProfileError extends ProfileState {
  final String message;

  EditUserProfileError({required this.message});
}

/// pick image
class PickImageLoading extends ProfileState {}
class PickImageSuccess extends ProfileState {
final String imgPath;

  PickImageSuccess({required this.imgPath});
}
class PickImageError extends ProfileState {}

