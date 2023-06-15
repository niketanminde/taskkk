import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jd_task/movie_model.dart';

class ApiService {
  static const apiKey = 'f6eb773ad8d6b13251eef4f2561c21d5';
  static const baseUrl = 'https://api.themoviedb.org/3';

  Future<List<Movie>> getUpcomingMovies() async {
    final url = '$baseUrl/movie/upcoming?api_key=$apiKey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final moviesData = jsonData['results'] as List<dynamic>;

      return moviesData.map((data) => Movie.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load upcoming movies');
    }
  }
}
