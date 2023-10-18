import 'package:http/http.dart' as http;
import 'package:caffein_flutter/constant.dart';
import 'package:caffein_flutter/model/model-discover-movie.dart';
import 'dart:convert';

class Api {
  static const getDiscoverMovieUrl =
      '${Constant.baseUrl}/3/discover/movie?api_key=${Constant.apiKey}';

  Future<ResponseDiscoverMovie> getDiscoverMovie() async {
      final response = await http.get(Uri.parse(getDiscoverMovieUrl));
      if (response.statusCode == 200) {
        print("Data aku 200 ${response.body}");
        return ResponseDiscoverMovie.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 401) {
        print("Data aku 401 ${jsonDecode(response.body)}");
        throw Exception("server error, please check your connection");
      } else {
        return ResponseDiscoverMovie(
            page: 0,
            totalPages: 11110,
            results: [],
            totalResults: 0);
      }
  }
}
