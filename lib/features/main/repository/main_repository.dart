import 'package:dio/dio.dart';
import 'package:movie_app/common/error_handling/check_exceptions.dart';
import 'package:movie_app/common/resources/data_state.dart';
import 'package:movie_app/features/main/data/data_source/remote/main_api_provider.dart';
import 'package:movie_app/features/main/data/models/actors_list_model.dart';
import 'package:movie_app/features/main/data/models/movie_list_model.dart';

class MainRepository {
  MainApiProvider apiProvider;

  MainRepository(this.apiProvider);

  Future<DataState<dynamic>> topMovieRop() async {
    try {
      final Response response = await apiProvider.topMovies();
      return DataSuccess(MovieListModel.fromJson(response.data));
    } catch (e) {
      return CheckExceptions.getError(e);
    }
  }

  Future<DataState<dynamic>> actorsListRop() async {
    try {
      final Response response = await apiProvider.actorsList();
      return DataSuccess(ActorsListModel.fromJson(response.data));
    } catch (e) {
      return CheckExceptions.getError(e);
    }
  }

  Future<DataState<dynamic>> popularMovieListRop(int page) async {
    try {
      final Response response = await apiProvider.popularMoviesList(page);
      return DataSuccess(MovieListModel.fromJson(response.data));
    } catch (e) {
      return CheckExceptions.getError(e);
    }
  }

  Future<DataState<dynamic>> topRatedMovieListRop(int page) async {
    try {
      final Response response = await apiProvider.topRatedMoviesList(page);
      return DataSuccess(MovieListModel.fromJson(response.data));
    } catch (e) {
      return CheckExceptions.getError(e);
    }
  }

  Future<DataState<dynamic>> upcomingMovieListRop(int page) async {
    try {
      final Response response = await apiProvider.upcomingMoviesList(page);
      return DataSuccess(MovieListModel.fromJson(response.data));
    } catch (e) {
      return CheckExceptions.getError(e);
    }
  }

  Future<DataState<dynamic>> searchMovieRop({required String name,required int page}) async {
    try {
      final Response response = await apiProvider.searchMovie(page: page,name: name);
      return DataSuccess(MovieListModel.fromJson(response.data));
    } catch (e) {
      return CheckExceptions.getError(e);
    }
  }

}
