part of 'home_bloc.dart';

sealed class HomeEvent {}

class TopMovieEvent extends HomeEvent{}

class ActorsListEvent extends HomeEvent{}

///popular
class PopularMovieListEvent  extends HomeEvent{}
class LoadPopularMovieListEvent  extends HomeEvent{
  int page;

  LoadPopularMovieListEvent({required this.page,});
}

///topRated
class TopRatedMovieListEvent  extends HomeEvent{}
class LoadTopRatedMovieListEvent  extends HomeEvent{
  int page;

  LoadTopRatedMovieListEvent({required this.page,});
}

/// upComing
class UpcomingMovieListEvent  extends HomeEvent{}
class LoadUpcomingMovieListEvent  extends HomeEvent{
  int page;
  LoadUpcomingMovieListEvent({required this.page});
}

///search
class SearchMovieEvent  extends HomeEvent{
  final String name;
  int page;

  SearchMovieEvent({required this.name,required this.page,});
}
