import 'dart:convert';

import 'package:caffein_flutter/home-page.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'home-page.dart';
import 'model/model-login.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;

  Future<Login> login(String username, String password) async {
    try {
      final response = await http.post(
          Uri.parse('https://api.addictioncompany.co.kr/api/company/login'),
           headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'account_id': username,
      'account_pwd' : password
    }),);
          
      if (response.statusCode == 200) {
        setState(() {
          isLoading = false;
        });
        showToast("berhasil login");
        return Login.fromJson(jsonDecode(response.body));
      } else {
         final responseData = jsonDecode(response.body); // Ubah respons JSON menjadi objek Dart
      final errorMessage = responseData['message']; 
        showToast(errorMessage);
        print(response.statusCode);
        setState(() {
          isLoading = false;
        });
        return const Login(
            status: 555, message: "gagal dielse", token: "kosong");
      }
    } catch (e) {
      print(e);
      showToast(e.toString());
      setState(() {
        isLoading = false;
      });
      return const Login(status: 555, message: "gagal", token: "kosong");
    }
  }

  void showToast(String message) {
    Toast.show(message,
        duration: Toast.lengthLong,
        gravity: Toast.center,
        backgroundColor: Colors.red);
  }

  @override
  void initState() {
    super.initState();
    ToastContext().init(context);
  }

  @override
  Widget build(BuildContext context) {
    Widget backGroundBlack = Container(
      color: Colors.black,
      height: MediaQuery.of(context).size.height / 2,
      child: const Center(
        child: Image(
          image: AssetImage('assets/images/icon.png'),
          height: 150,
          width: 150,
        ),
      ),
    );

    Widget progressBar = Align(
        child: isLoading
            ? const Column(
                children: [
                  CircularProgressIndicator(
                    color: Colors.black,
                    backgroundColor: Colors.grey,
                  )
                ],
              )
            : const SizedBox.shrink());

    Widget backGroundWhite = Container(
      child: const Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.only(top: 20.0, right: 20.0, bottom: 10.0),
            child: Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          )),
    );

    Widget customBgTextField({
      required String label,
      TextEditingController? controller,
      required bool obsText,
    }) {
      return Container(
        margin: const EdgeInsets.only(bottom: 22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 10.0),
              child: Text(
                label,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: const Color(0xffE4E4E4),
                  borderRadius: BorderRadius.circular(10.0)),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Input $label",
                    contentPadding: const EdgeInsets.all(10)),
                obscureText: obsText,
              ),
            ),
          ],
        ),
      );
    }

    Widget textField = Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, bottom: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customBgTextField(
                label: "매장명", controller: usernameController, obsText: false),
            customBgTextField(
                label: "PW", controller: passwordController, obsText: true),
          ],
        ),
      ),
    );

    Widget btnLogin = Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              minimumSize: Size.fromHeight(60), backgroundColor: Colors.black),
          onPressed: isLoading
              ? null
              : () {
                  var usernameText = usernameController.text;
                  var passwordText = passwordController.text;

                  setState(() {
                    isLoading = true;
                  });
                  print("$usernameText, $passwordText");

                  login(usernameText, passwordText);
                },
          child: isLoading
              ? progressBar
              : Text(
                  "로그인",
                  style: TextStyle(
                      color: isLoading ? Colors.black : Colors.white,
                      fontWeight: FontWeight.bold),
                ),
        ),
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [backGroundBlack, backGroundWhite, textField, btnLogin],
          ),
        )),
      ),
    );
  }
}
