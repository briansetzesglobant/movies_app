class Movie {
  Movie({
    required this.posterPath,
    required this.adult,
    required this.overview,
    required this.releaseDate,
    required this.genreIds,
    required this.id,
    required this.originalTitle,
    required this.originalLanguage,
    required this.title,
    required this.backdropPath,
    required this.popularity,
    required this.voteCount,
    required this.video,
    required this.voteAverage,
  });

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

  final String? posterPath;
  final bool adult;
  final String overview;
  final String releaseDate;
  final List<int> genreIds;
  final int id;
  final String originalTitle;
  final String originalLanguage;
  final String title;
  final String? backdropPath;
  final num popularity;
  final int voteCount;
  final bool video;
  final num voteAverage;
}
