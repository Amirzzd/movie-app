import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

part 'intro_event.dart';
part 'intro_state.dart';

class IntroBloc extends Bloc<IntroEvent, IntroState> {
  IntroBloc() : super(ChangeGetStarted(
    value: false
  )) {
    on<GetStartEvent>((event, emit) {
      emit(ChangeGetStarted(value: event.value));

      if(event.value == true){
        emit (ChangeCompleted(value: event.value));
      }
    });
  }
}
