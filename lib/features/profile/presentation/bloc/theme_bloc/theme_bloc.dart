import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_app/common/utills/shared_operator.dart';

part 'theme_event.dart';

class ThemeBloc extends Bloc<ThemeEvent, bool> {
  SharedPrefOperator sharedPrefOperator;
  ThemeBloc(this.sharedPrefOperator) : super(sharedPrefOperator.getThemeMode()) {
    on<ChangeThemeEvent>((event, emit) {
      emit(event.currentThemeModel);
    });
  }
}
