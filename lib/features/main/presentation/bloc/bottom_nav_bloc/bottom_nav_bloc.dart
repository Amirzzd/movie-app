import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'bottom_nav_event.dart';
part 'bottom_nav_state.dart';

class BottomNavBloc extends Bloc<BottomNavEvent, BottomNavState> {
  BottomNavBloc() : super(const BottomNavInitial(
    index: 0
  )) {
    on<ChangeIndex>((event, emit) {
      emit(BottomNavInitial(index: event.index));
      if(event.index == 3 ) {

      }
    });
  }
}
