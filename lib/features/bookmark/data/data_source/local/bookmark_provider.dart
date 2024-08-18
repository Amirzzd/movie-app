import 'package:hive/hive.dart';
import 'package:movie_app/features/bookmark/data/data_source/model/bookmark_movies_model.dart';

class BookmarkProvider {
  String key = 'bookmark_movies';

  late final Box<BookmarkMoviesModel> bookMarkBox;

  List<BookmarkMoviesModel> movies = [];

  ///init db
  dynamic initDataBase () async {
    try {
      Hive.registerAdapter(BookmarkMoviesModelAdapter());
      bookMarkBox = await Hive.openBox(key);
      return 'success';
    }catch (e) {
      return 'failed';
    }
  }

  ///save
  dynamic saveMovie (BookmarkMoviesModel movie,String name)async{
    await bookMarkBox.put(name, movie);
  }

  ///delete
  dynamic deleteMovie (String name)async{
    for(var movie in movies){
      if(movie.title == name){
        await bookMarkBox.delete(movie.title);
      }
    }
  }

  ///show all movies
  dynamic showMovies ()async{
    await initDataBase();
    movies = [];
    if(bookMarkBox.isNotEmpty) {
      for(var movie in bookMarkBox.values){
        movies.add(movie);
      }
    }
    return movies;
   }

   ///find specific movie
  dynamic findMovie (String name){
    for(var movie in movies) {
      if(movie.title == name){
        return true;
      }
    }
   }
  }

