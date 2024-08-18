part of 'intro_bloc.dart';

@immutable
abstract class IntroEvent {}

class GetStartEvent extends IntroEvent {
  final bool value;
  GetStartEvent({required this.value});
}
