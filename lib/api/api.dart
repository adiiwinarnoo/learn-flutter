import 'package:http/http.dart' as http;
import 'package:caffein_flutter/constant.dart';
import 'package:caffein_flutter/model/model-discover-movie.dart';
import 'dart:convert';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Api {

  Future<ResponseDiscoverMovie> getDiscoverMovie(
    int currentPage, bool isRefresh,RefreshController refreshController) 
  async {
    if(isRefresh){
      print("refresh true");
      currentPage = 1;
    }else{
      if(currentPage >= 100){
        refreshController.loadNoData();
      }
    }


      final response = await http.get(Uri.parse(
        '${Constant.baseUrl}/3/discover/movie?api_key=${Constant.apiKey}&page=${currentPage}'
        ));
      if (response.statusCode == 200) {
        currentPage++;
        print("data page ${currentPage}");
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
