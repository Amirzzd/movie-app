part of 'bottom_nav_bloc.dart';

@immutable
sealed class BottomNavEvent {}

class ChangeIndex extends BottomNavEvent {
  final int index;
  ChangeIndex({required this.index});
}