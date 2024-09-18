import 'package:dio/dio.dart';

import '../models/movie.dart';

class MovieService {
  final Dio _dio = Dio();
  final String apiKey = '52033d809fcd0174aa4c74a8e34c4136';

  MovieService() {
    _dio.options.baseUrl = 'https://api.themoviedb.org/3';
  }

  Future<List<Movie>> searchMovies(String query) async {
    try {
      final response = await _dio.get('/search/movie', queryParameters: {
        'api_key': apiKey,
        'query': query,
      });

      if (response.statusCode == 200) {
        final List<dynamic> results = response.data['results'];
        return results.map((movieJson) => Movie.fromJson(movieJson)).toList();
      } else {
        throw Exception('Failed to load movies');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}
