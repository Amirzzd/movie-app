// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmark_movies_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookmarkMoviesModelAdapter extends TypeAdapter<BookmarkMoviesModel> {
  @override
  final int typeId = 1;

  @override
  BookmarkMoviesModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BookmarkMoviesModel(
      adult: fields[0] as bool?,
      originalTitle: fields[1] as String?,
      overview: fields[2] as String?,
      posterPath: fields[3] as String?,
      releaseDate: fields[4] as String?,
      title: fields[5] as String?,
      voteAverage: fields[6] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, BookmarkMoviesModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.adult)
      ..writeByte(1)
      ..write(obj.originalTitle)
      ..writeByte(2)
      ..write(obj.overview)
      ..writeByte(3)
      ..write(obj.posterPath)
      ..writeByte(4)
      ..write(obj.releaseDate)
      ..writeByte(5)
      ..write(obj.title)
      ..writeByte(6)
      ..write(obj.voteAverage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookmarkMoviesModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
