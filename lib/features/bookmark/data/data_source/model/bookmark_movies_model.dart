import 'package:hive/hive.dart';
import 'package:movie_app/features/main/data/models/movie_list_model.dart';

part 'bookmark_movies_model.g.dart';

@HiveType(typeId: 1)
class BookmarkMoviesModel extends Results{
  @HiveField(0)
  bool? adult;
  @HiveField(1)
  String? originalTitle;
  @HiveField(2)
  String? overview;
  @HiveField(3)
  String? posterPath;
  @HiveField(4)
  String? releaseDate;
  @HiveField(5)
  String? title;
  @HiveField(6)
  double? voteAverage;

  BookmarkMoviesModel({
    this.adult,
    this.originalTitle,
    this.overview,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.voteAverage,
  });
}