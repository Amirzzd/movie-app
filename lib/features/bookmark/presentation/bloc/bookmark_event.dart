part of 'bookmark_bloc.dart';

@immutable
sealed class BookmarkEvent {}

class SaveMovie extends BookmarkEvent {
  final BookmarkMoviesModel movie;
  final String name;
  SaveMovie ({required this.movie,required this.name});
}

class DeleteMovie extends BookmarkEvent {
  final String name;

  DeleteMovie({required this.name});
}

class ShowMovies extends BookmarkEvent {}

class FindMovie extends BookmarkEvent{
  final String name;

  FindMovie({required this.name});
}