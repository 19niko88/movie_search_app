import 'package:flutter/foundation.dart';

class MovieProvider with ChangeNotifier {
  List<dynamic> _movies = [];
  final List<int> _favoriteMovies = [];

  List<dynamic> get movies => _movies;

  List<int> get favoriteMovies => _favoriteMovies;

  void setMovies(List<dynamic> movies) {
    _movies = movies;
    notifyListeners();
  }

  void toggleFavorite(int movieId) {
    if (_favoriteMovies.contains(movieId)) {
      _favoriteMovies.remove(movieId);
    } else {
      _favoriteMovies.add(movieId);
    }
    notifyListeners();
  }

  bool isFavorite(int movieId) => _favoriteMovies.contains(movieId);
}
