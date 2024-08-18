part of 'bookmark_bloc.dart';

@immutable
sealed class BookmarkState {}

final class BookmarkInitial extends BookmarkState {}


///I didn't use loading and fail state but i made them for when i need them
class ShowMovieLoadingState extends BookmarkState {}
class ShowMovieSuccessState extends BookmarkState {
  final List<BookmarkMoviesModel> movies;
  ShowMovieSuccessState(this.movies);
}
class ShowMovieFailedState extends BookmarkState {
  final String message;
  ShowMovieFailedState(this.message);
}


class SaveMovieLoadingState extends BookmarkState {}
class SaveMovieSuccessState extends BookmarkState {
  final String message;


  SaveMovieSuccessState({required this.message,});
}
class SaveMovieFailedState extends BookmarkState {
  final String message;
  SaveMovieFailedState(this.message);
}

class DeleteMovieLoadingState extends BookmarkState {}
class DeleteMovieSuccessState extends BookmarkState {
  final String message;
  DeleteMovieSuccessState(this.message);
}
class DeleteMovieFailedState extends BookmarkState {
  final String name;
  DeleteMovieFailedState(this.name);
}

class FindMovieLoadingState extends BookmarkState {}
class FindMovieSuccessState extends BookmarkState {
  final bool value;
  FindMovieSuccessState(this.value);
}
class FindMovieFailedState extends BookmarkState {
  final String message;
  FindMovieFailedState(this.message);
}



