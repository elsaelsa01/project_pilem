import 'dart:convert';
import 'package:http/http.dart' as http;
class ApiService {
  static const String baseUrl = "https://api.themoviedb.org/3";
  static const String apiKey = '0920a3ff23b5276d93fa7b94d7fca7cc';
  Future<List<Map<String, dynamic>>> getAllMovies() async {
    final response = await
    http.get(Uri.parse("$baseUrl/movie/now_playing?api_key=$apiKey"));
    final data = json.decode(response.body);
    return List<Map<String, dynamic>>.from(data['results']);
  }
  Future<List<Map<String, dynamic>>> getTrendingMovies() async {
    final response = await
    http.get(Uri.parse("$baseUrl/trending/movie/week?api_key=$apiKey"));
    final data = json.decode(response.body);
    return List<Map<String, dynamic>>.from(data['results']);
  }
  Future<List<Map<String, dynamic>>> getPopularMovies() async {
    final response = await
    http.get(Uri.parse("$baseUrl/movie/popular?api_key=$apiKey"));
    final data = json.decode(response.body);
    return List<Map<String, dynamic>>.from(data['results']);
  }

  // tambahan di pertemuan 5
  Future<List<Map<String, dynamic>>> searchMovies(String query) async {
    final response = await
    http.get(Uri.parse("$baseUrl/search/movie?query=$query&api_key=$apiKey"));
    final data = json.decode(response.body);
    return List<Map<String, dynamic>>.from(data['results']);
  }
}