import 'package:movie_app/common/error_handling/check_exceptions.dart';
import 'package:movie_app/common/resources/data_state.dart';
import 'package:movie_app/features/bookmark/data/data_source/local/bookmark_provider.dart';
import 'package:movie_app/features/bookmark/data/data_source/model/bookmark_movies_model.dart';

class BookmarkRepository {
  BookmarkProvider bookmarkProvider;

  BookmarkRepository(this.bookmarkProvider);


  Future <DataState<dynamic>> saveMovieRop (BookmarkMoviesModel movie,String name) async {
    try{
      await bookmarkProvider.saveMovie(movie,name);
      return const DataSuccess('success');
    } catch (e){
      return CheckExceptions.getError(e);
    }
  }

  Future <DataState<dynamic>> deleteMovieRop (String name) async {
    try{
      await bookmarkProvider.deleteMovie(name);
      return const DataSuccess('success');
    }catch (e){
      return CheckExceptions.getError(e);
    }
  }

  Future <DataState<dynamic>> showMovieRop () async {
    try{
      var response = await bookmarkProvider.showMovies();
      return DataSuccess(response);
    }catch (e){
      return CheckExceptions.getError(e);
    }
  }

  Future <DataState<dynamic>> findMovie (String name) async {
    try{
      var response = await bookmarkProvider.findMovie(name);
      return DataSuccess(response);
    }catch (e){
      return CheckExceptions.getError(e);
    }
  }
}