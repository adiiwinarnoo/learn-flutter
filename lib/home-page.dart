import 'package:caffein_flutter/constant.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'api/api.dart'; // Import your API class
import 'model/model-discover-movie.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<HomePage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  List<ResultsItemDiscover> movies = [];
  int currentPage = 1;
  bool isRefresh = false;

  void _loadData({bool refresh = false}) async {
    if (refresh) {
      currentPage = 1;
    }

     final responseDiscoverMovie = await Api().getDiscoverMovie(
    currentPage,
    refresh, // Pass the refresh boolean
    _refreshController, // Pass the RefreshController
  );
    
    if (responseDiscoverMovie != null) {
      setState(() {
        if (refresh) {
          movies = responseDiscoverMovie.results;
        } else {
          movies.addAll(responseDiscoverMovie.results);
        }
        currentPage++;
        isRefresh = false;
      });

      if (refresh) {
        _refreshController.refreshCompleted();
      } else {
        _refreshController.loadComplete();
      }
    } else {
      if (refresh) {
        _refreshController.refreshFailed();
      } else {
        _refreshController.loadFailed();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My App'),
      ),
      body: Center(
        child: SmartRefresher(
          controller: _refreshController,
          enablePullUp: true,
          enablePullDown: true,
          onRefresh: () {
            _loadData(refresh: true);
            isRefresh = true;
          },
          onLoading: () {
            _loadData();
          },
          child: ListView(
            children: movies.map((resultItem) {
              final imageUrl = '${Constant.pathImage}${resultItem.posterPath}';
              return ListTile(
                contentPadding: EdgeInsets.all(16),
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 200,
                      height: 200,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: FadeInImage.assetNetwork(
                          placeholder: 'assets/images/loading-gif.gif',
                          image: imageUrl,
                          fit: BoxFit.cover,
                          width: 200,
                          height: 200,
                        ),
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
          ),
        ),
      ),
    );
  }
}
