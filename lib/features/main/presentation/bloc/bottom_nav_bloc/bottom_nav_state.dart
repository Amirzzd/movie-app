part of 'bottom_nav_bloc.dart';

@immutable
sealed class BottomNavState {
  final int index;
  const BottomNavState({required this.index});
}

final class BottomNavInitial extends BottomNavState {
  const BottomNavInitial({required super.index});
}
