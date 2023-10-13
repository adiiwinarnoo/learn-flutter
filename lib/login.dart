import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class LoginPage extends StatefulWidget {
LoginPage({super.key});

@override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

   @override
  void initState() {
    super.initState();
    // Inisialisasi konteks di sini
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


    Widget backGroundWhite = Container(
      color: Colors.white,
      child: const Align(
        alignment: Alignment.centerRight,
        child: Padding(padding: const EdgeInsets.only(top:20.0,right: 20.0),
        child: Text("LOGIN",style: TextStyle(fontWeight: FontWeight.bold),
        ),
        )
      ),
    );

    Widget textField = Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 20,bottom: 20,right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 10.0),
              child: const Text("매장명"),
            ),
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "input username"
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20.0),
              child: const Text("PW"),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "input your password"
              ),
              obscureText: true,
            )
          ],
        ),
      ),
    );

    Widget btnLogin = Align(
      alignment: Alignment.bottomCenter,
      child: Padding(padding: const EdgeInsets.only(top:40.0,left:20.0,right:20.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size.fromHeight(60),
          backgroundColor: Colors.black
        ),
        onPressed: () {
          var usernameText = usernameController.text;
          var passwordText = passwordController.text;

          Toast.show(
            "username anda $usernameText, password anda $passwordText",
            duration: Toast.lengthLong, gravity: Toast.center,backgroundColor: Colors.red
            );
        },
        child: const Text("로그인",style: TextStyle(color: Colors.white),
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
            children: [
              backGroundBlack,
              backGroundWhite,
              textField,
              btnLogin
            ],
          ),
          )
        ),
      ),
    );
  }
}

 