part of 'theme_bloc.dart';

@immutable
sealed class ThemeEvent {}

class ChangeThemeEvent extends ThemeEvent {
  final bool currentThemeModel;

  ChangeThemeEvent({required this.currentThemeModel});
}
