import 'package:flutter/material.dart';

class MoviePoster extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;

  MoviePoster({required this.imageUrl,required this.title,required this.subtitle});

 @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: MoviePoster(imageUrl: imageUrl, title: title, subtitle: subtitle),
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }
}
