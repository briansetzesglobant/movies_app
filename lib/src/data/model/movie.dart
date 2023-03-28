import 'package:movies_app/src/domain/entity/movie_entity.dart';

class Movie extends MovieEntity {
  Movie({
    required String? posterPath,
    required bool adult,
    required String overview,
    required String releaseDate,
    required List<int> genreIds,
    required int id,
    required String originalTitle,
    required String originalLanguage,
    required String title,
    required String? backdropPath,
    required num popularity,
    required int voteCount,
    required bool video,
    required num voteAverage,
  }) : super(
          posterPath: posterPath,
          adult: adult,
          overview: overview,
          releaseDate: releaseDate,
          genreIds: genreIds,
          id: id,
          originalTitle: originalTitle,
          originalLanguage: originalLanguage,
          title: title,
          backdropPath: backdropPath,
          popularity: popularity,
          voteCount: voteCount,
          video: video,
          voteAverage: voteAverage,
        );

  factory Movie.fromJson(Map<String, dynamic> json) {
    var jsonList = json['genre_ids'] as List;
    List<int> genreIdsList = jsonList.map((genreId) => genreId as int).toList();
    return Movie(
      posterPath: json['poster_path'],
      adult: json['adult'],
      overview: json['overview'],
      releaseDate: json['release_date'],
      genreIds: genreIdsList,
      id: json['id'],
      originalTitle: json['original_title'],
      originalLanguage: json['original_language'],
      title: json['title'],
      backdropPath: json['backdrop_path'],
      popularity: json['popularity'],
      voteCount: json['vote_count'],
      video: json['video'],
      voteAverage: json['vote_average'],
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'poster_path': posterPath,
      'adult': adult,
      'overview': overview,
      'release_date': releaseDate,
      'genre_ids': genreIds.map((genreId) => genreId).toList(),
      'id': id,
      'original_title': originalTitle,
      'original_language': originalLanguage,
      'title': title,
      'backdrop_path': backdropPath,
      'popularity': popularity,
      'vote_count': voteCount,
      'video': video,
      'vote_average': voteAverage,
    };
  }
}
