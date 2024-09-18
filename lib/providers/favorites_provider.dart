import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../services/movie_service.dart';

class FavoritesProvider with ChangeNotifier {
  final List<Movie> _favorites = [];
  List<Movie> _searchResults = [];
  String _query = '';
  bool _isLoading = false;

  List<Movie> get favorites => _favorites;
  List<Movie> get searchResults => _searchResults;
  bool get isLoading => _isLoading;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void updateQuery(String query) {
    _query = query;
    notifyListeners();
  }

  Future<void> searchMovies(String query) async {
    if (query.isEmpty) return;

    setLoading(true);
    try {
      final movieService = MovieService();
      _searchResults = await movieService.searchMovies(query);
    } catch (e) {
      _searchResults = [];
      // Handle error (optional)
    } finally {
      setLoading(false);
      notifyListeners();
    }
  }

  void toggleFavorite(Movie movie) {
    if (_favorites.contains(movie)) {
      _favorites.remove(movie);
    } else {
      _favorites.add(movie);
    }
    notifyListeners();
  }

  bool isFavorite(Movie movie) => _favorites.contains(movie);
}
