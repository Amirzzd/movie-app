import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_app/common/resources/data_state.dart';
import 'package:movie_app/features/bookmark/data/data_source/model/bookmark_movies_model.dart';
import 'package:movie_app/features/bookmark/repository/bookmark_repository.dart';

part 'bookmark_event.dart';
part 'bookmark_state.dart';

class BookmarkBloc extends Bloc<BookmarkEvent, BookmarkState> {
  BookmarkRepository bookMarkRepository;

  BookmarkBloc(this.bookMarkRepository) : super(BookmarkInitial()) {
    on<BookmarkEvent>((event, emit) async {
      if(event is ShowMovies){
        emit(ShowMovieLoadingState());
        DataState dataState = await bookMarkRepository.showMovieRop();

        dataState is DataSuccess
        ? emit(ShowMovieSuccessState(dataState.data))
        : emit(ShowMovieFailedState(dataState.message!));
      }



      if(event is SaveMovie){
        emit(SaveMovieLoadingState());
        DataState dataState = await bookMarkRepository.saveMovieRop(event.movie,event.name);

        dataState is DataSuccess
            ? emit(SaveMovieSuccessState(message: dataState.data ?? 'success',))
            : emit(SaveMovieFailedState(dataState.message!));
      }

      if(event is DeleteMovie){
        emit(DeleteMovieLoadingState());
        DataState dataState = await bookMarkRepository.deleteMovieRop(event.name);

        dataState is DataSuccess
            ? emit(DeleteMovieSuccessState(dataState.data ?? 'success'))
            : emit(DeleteMovieFailedState(dataState.message!));
      }

      if(event is FindMovie){
        emit(FindMovieLoadingState());
        DataState dataState = await bookMarkRepository.findMovie(event.name);

        dataState is DataSuccess
            ? emit(FindMovieSuccessState(dataState.data ?? false))
            : emit(FindMovieFailedState(dataState.message!));
      }
     },
    );

  }
}
