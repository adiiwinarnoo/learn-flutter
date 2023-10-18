import 'dart:convert';
import 'dart:io';
import 'package:caffein_flutter/constant.dart';
import 'package:caffein_flutter/movie-poster.dart';
import 'package:caffein_flutter/utils/auth-manager.dart';
import 'package:flutter/material.dart';
import 'model/model-discover-movie.dart';
import 'package:http/http.dart' as http;
import 'api/api.dart';

class HomePagge extends StatefulWidget {
  const HomePagge({super.key});

  @override
  State<HomePagge> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<HomePagge>
    with SingleTickerProviderStateMixin {
  late Future<ResponseDiscoverMovie> responseDiscoverMovie;
  late AnimationController _controller;
  bool isLoading = true;
  String? userToken = AuthManager().getUserToken();
  String baseUrl = "https://api.themoviedb.org";
  String apiKey =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhMzhhZDFkMmZkOTIzNzY0NTM5MmRlMzIxMjI1NTRlYiIsInN1YiI6IjY0ZTRkYTM1NjNlNmZiMDBjNmYyMGQxNSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.e_J4sp10fyAn9_go3ZIddA7D4tbQECa3DRcDYSa24yE";

  Future<ResponseDiscoverMovie> getMovie(String apiKey) async {
    try {
      final responseData = await http.get(
          Uri.parse("$baseUrl/3/discover/movie?page=3"),
          headers: {HttpHeaders.authorizationHeader: 'Bearer $apiKey'});

      print("statuscode ${responseData.statusCode} item ${responseData.body}");

      if (responseData.statusCode == 200) {
        print(responseData.body);
      }

      return ResponseDiscoverMovie.fromJson(jsonDecode(responseData.body));
    } catch (e) {
      return ResponseDiscoverMovie(
          page: 0, totalPages: 0, results: [], totalResults: 0);
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        isLoading = false;
      });
    });
    _loadData();
    // getMovie(apiKey);
    // final responseDiscoverMovie = Api().getDiscoverMovie();
    // print("${responseDiscoverMovie.results}");
    print("usertoken : $userToken");
  }

  Future<void> _loadData() async {
    try{
    responseDiscoverMovie = Api().getDiscoverMovie();
    }catch(e){
      print(e);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My App'),
      ),
      body: Center(
        child: FutureBuilder<ResponseDiscoverMovie>(
          future: responseDiscoverMovie,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(); // Show loading indicator
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData) {
              return Text('No data available');
            } else {
              // Data is available, you can access it using snapshot.data
              print(snapshot.data!.results);
              return ListView(
  children: snapshot.data!.results.map((resultItem) {
    final imageUrl = '${Constant.pathImage}${resultItem.posterPath}';
    return ListTile(
      contentPadding: EdgeInsets.all(16), // Add padding around the ListTile content
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 200, // Set the width to control the poster size
            height: 200,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/images/loading-gif.gif', 
                image: imageUrl,
                fit: BoxFit.cover,
                width: 200,
                height: 200,)
            ),
          ),
        SizedBox(height: 8),
          Text(
            resultItem.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Text(
            resultItem.overview,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }).toList(),
);

            }
          },
        ),
      ),
    );
  }
}
