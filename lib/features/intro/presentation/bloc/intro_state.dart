part of 'intro_bloc.dart';

@immutable
sealed class IntroState {}

class ChangeGetStarted extends IntroState {
  final bool value;
  ChangeGetStarted ({required this.value});
}
class ChangeCompleted extends IntroState {
  final bool value;
  ChangeCompleted ({required this.value});
}