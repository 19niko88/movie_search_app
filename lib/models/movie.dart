class Movie {
  final int id;
  final String title;
  final String posterPath;
  final String releaseDate;
  final String overview;
  final double rating;

  Movie({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.releaseDate,
    required this.overview,
    required this.rating,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      posterPath: json['poster_path'],
      releaseDate: json['release_date'],
      overview: json['overview'],
      rating: json['vote_average'].toDouble(),
    );
  }
}
