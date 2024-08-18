import 'package:bloc/bloc.dart';
import 'package:movie_app/common/resources/data_state.dart';
import 'package:movie_app/features/main/data/models/actors_list_model.dart';
import 'package:movie_app/features/main/data/models/movie_list_model.dart';
import 'package:movie_app/features/main/repository/main_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  bool hasReachMax = false;
  MainRepository mainRepository;

  HomeBloc(this.mainRepository) : super(SearchMovieListLoading()) {
    ///---top movie
    on<TopMovieEvent>((event, emit) async{
        emit(TopMovieLoading());
        DataState dataState = await mainRepository.topMovieRop();
        dataState is DataSuccess 
        ? emit(TopMovieSuccess(model: dataState.data))
        : emit(TopMovieError(message: dataState.message!));
      },);

    ///---actor list
    on<ActorsListEvent>((event, emit) async{
        emit(ActorsListLoading());
        DataState dataState = await mainRepository.actorsListRop();
        dataState is DataSuccess

        ? emit(ActorsListSuccess(model: dataState.data))
        : emit(ActorsListError(message: dataState.message!));
      },);

    ///---popular movie list
    on<PopularMovieListEvent>((event, emit) async{
        emit(MovieListLoading());
        DataState dataState = await mainRepository.popularMovieListRop(1);
        dataState is DataSuccess
        ? emit(MovieListSuccess(model: dataState.data))
        : emit(MovieListError(message: dataState.message!));
      },);
    on<LoadPopularMovieListEvent>((event, emit) async{
      if(event.page == 0){
        emit(PopularMovieListLoading());
      }

      DataState dataState = await mainRepository.popularMovieListRop(event.page);

      if(dataState is DataSuccess){
        MovieListModel movieListModel = dataState.data;
        movieListModel.results!.isEmpty ? hasReachMax = true : hasReachMax = false;
        emit(PopularMovieListSuccess(model: dataState.data,page: event.page,));
      }
      if(dataState is DataFailed) {
        emit(PopularMovieListError(message: dataState.message!));
      }
      },
    );

    ///---topRated movie list
    on<TopRatedMovieListEvent>((event, emit) async{
      emit(MovieListLoading());
      DataState dataState = await mainRepository.topRatedMovieListRop(1);
      dataState is DataSuccess
          ? emit(MovieListSuccess(model: dataState.data))
          : emit(MovieListError(message: dataState.message!));
    },);
    on<LoadTopRatedMovieListEvent>((event, emit) async{
      if(event.page == 1){
        emit(TopRatedMovieListLoading());
      }
      DataState dataState = await mainRepository.topRatedMovieListRop(event.page);
      if(dataState is DataSuccess){
        MovieListModel movieListModel = dataState.data;
        movieListModel.results!.isEmpty ? hasReachMax = true : hasReachMax = false;
        emit(TopRatedMovieListSuccess(model: dataState.data,page: event.page,));
      }
      if(dataState is DataFailed) {
        emit(TopRatedMovieListError(message: dataState.message!));
      }
     },
    );

    ///---upcoming movie list
    on<UpcomingMovieListEvent>((event, emit) async{
      emit(MovieListLoading());
      DataState dataState = await mainRepository.upcomingMovieListRop(1);
      dataState is DataSuccess
          ? emit(MovieListSuccess(model: dataState.data))
          : emit(MovieListError(message: dataState.message!));
    },);
    on<LoadUpcomingMovieListEvent>((event, emit) async{
      if(event.page == 1){
        emit(UpComingMovieListLoading());
      }

      DataState dataState = await mainRepository.upcomingMovieListRop(event.page);

      if(dataState is DataSuccess){
        MovieListModel movieListModel = dataState.data;
        movieListModel.results!.isEmpty ? hasReachMax = true : hasReachMax = false;
        emit(UpComingMovieListSuccess(model: dataState.data,page: event.page,));
      }
      if(dataState is DataFailed) {
          emit(UpComingMovieListError(message: dataState.message!));
        }
    },);

    ///---search  movie list
    on<SearchMovieEvent>((event, emit) async{
      if(event.page == 0){
        emit(SearchMovieListLoading());
      }

      DataState dataState = await mainRepository.searchMovieRop(page: event.page,name: event.name);

      if(dataState is DataSuccess) {

        MovieListModel movieListModel = dataState.data;
        movieListModel.results!.isEmpty ? hasReachMax = true : hasReachMax = false;
        emit(SearchMovieListSuccess(model: movieListModel,page: event.page));
      }
      if(dataState is DataFailed) {
            emit(SearchMovieListError(message: dataState.message!));
      }
    },);
  }
}
