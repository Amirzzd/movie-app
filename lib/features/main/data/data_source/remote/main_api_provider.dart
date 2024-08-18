import 'package:dio/dio.dart';
import 'package:movie_app/config/api_config.dart';
import 'package:movie_app/config/constants.dart';


class MainApiProvider {
  Dio dio;
  MainApiProvider(this.dio) {
    ApiConfig.setHeader(dio: dio,
    );
  }
  var headers = {
    'Authorization': Constants.apiReadAccessToken
  };
  final apiKey = Constants.apiKey;

  dynamic topMovies() async {
    var response = await dio.get(
      '${Constants.movieBaseUrl}movie/now_playing',
        queryParameters: {
          'api_key' : apiKey,
          'page' : 1,
          'language' : 'fa',
        },
      options: Options(
        headers: headers
      )
    );
    return response;
  }

  dynamic actorsList() async {
    var response = await dio.get(
      '${Constants.movieBaseUrl}person/popular',
        queryParameters: {
          'api_key' : apiKey,
          'page' : 1,
          'language' : 'fa',
        },
      options: Options(
        headers: headers
      )
    );
    return response;
  }

  dynamic popularMoviesList(int page) async {
    var response = await dio.get(
      '${Constants.movieBaseUrl}movie/popular',
        queryParameters: {
          'api_key' : apiKey,
          'page' : page,
          'language' : 'fa',
        },
      options: Options(
        headers: headers
      )
    );
    return response;
  }

  dynamic topRatedMoviesList(int page) async {
    var response = await dio.get(
      '${Constants.movieBaseUrl}movie/top_rated',
        queryParameters: {
          'api_key' : apiKey,
          'page' : page,
          'language' : 'fa',
        },
      options: Options(
        headers: headers
      )
    );
    return response;
  }

  dynamic upcomingMoviesList(int page) async {
    var response = await dio.get(
      '${Constants.movieBaseUrl}movie/upcoming',
        queryParameters: {
          'api_key' : apiKey,
          'page' : page,
          'language' : 'fa',
        },
      options: Options(
        headers: headers
      )
    );
    return response;
  }

  dynamic searchMovie({required String name,required int page}) async {
    var response = await dio.get(
      '${Constants.movieBaseUrl}search/movie',
        queryParameters: {
          'query' : name,
          'api_key' : apiKey,
          'page' : page,
          'language' : 'fa',
        },
      options: Options(
        headers: headers
      )
    );
    return response;
  }

}
