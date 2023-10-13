import 'dart:async';
import 'package:flutter/material.dart';
import 'login.dart';

// ignore: use_key_in_widget_constructors
class SplashScreenPage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
    const Duration(seconds: 3),
    () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/app-icon.png',width: 200,height: 200,),
          ],
        ),
      ),
    );
  }
}