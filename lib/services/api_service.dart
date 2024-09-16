import 'package:dio/dio.dart';

class ApiService {
  final String apiKey = '52033d809fcd0174aa4c74a8e34c4136';
  final String baseUrl = 'https://api.themoviedb.org/3';
  final Dio _dio = Dio();

  ApiService() {
    _dio.options = BaseOptions(
      baseUrl: baseUrl,
      queryParameters: {'api_key': apiKey},
      responseType: ResponseType.json,
    );
  }

  Future<Map<String, dynamic>> searchMovies(String query) async {
    try {
      final response =
          await _dio.get('/search/movie', queryParameters: {'query': query});
      return response.data;
    } catch (e) {
      throw Exception('Failed to load movies');
    }
  }
}
