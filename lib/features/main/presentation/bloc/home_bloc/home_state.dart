part of 'home_bloc.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

///--- top Movie States
class TopMovieLoading extends HomeState {}
class TopMovieSuccess extends HomeState {
  final MovieListModel model;

  TopMovieSuccess({required this.model});
}
class TopMovieError extends HomeState {
  final String message;

  TopMovieError({required this.message});
}

///--- actorsListMovie state
class ActorsListLoading extends HomeState {}
class ActorsListSuccess extends HomeState {
  final ActorsListModel model;

  ActorsListSuccess({required this.model});
}
class ActorsListError extends HomeState {
  final String message;

  ActorsListError({required this.message});
}

///--- ListMovie state
class MovieListLoading extends HomeState {}
class MovieListSuccess extends HomeState {
  final MovieListModel model;

  MovieListSuccess({required this.model});
}
class MovieListError extends HomeState {
  final String message;

  MovieListError({required this.message});
}

///--- LoadMovie State for Paginate

///popular
class PopularMovieListLoading extends HomeState {}
class PopularMovieListSuccess extends HomeState {
  final MovieListModel model;
  int page;
  PopularMovieListSuccess({required this.model,required this.page,});
}
class PopularMovieListError extends HomeState {
  final String message;
  PopularMovieListError({required this.message});
}

///topRate
class TopRatedMovieListLoading extends HomeState {}
class TopRatedMovieListSuccess extends HomeState {
  final MovieListModel model;
  int page;
  TopRatedMovieListSuccess({required this.model,required this.page,});
}
class TopRatedMovieListError extends HomeState {
  final String message;
  TopRatedMovieListError({required this.message});
}

///upcoming
class UpComingMovieListLoading extends HomeState {}
class UpComingMovieListSuccess extends HomeState {
  final MovieListModel model;
  int page;
  UpComingMovieListSuccess({required this.model,required this.page,});
}
class UpComingMovieListError extends HomeState {
  final String message;

  UpComingMovieListError({required this.message});
}

///search
class SearchMovieListLoading extends HomeState {}
class SearchMovieListSuccess extends HomeState {
  final MovieListModel model;
  int page;
  SearchMovieListSuccess({required this.model,required this.page});
}
class SearchMovieListError extends HomeState {
  final String message;

  SearchMovieListError({required this.message});
}

