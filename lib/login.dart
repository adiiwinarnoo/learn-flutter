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

  void showToast(String message){
     Toast.show(
            message,
            duration: Toast.lengthLong, gravity: Toast.center,backgroundColor: Colors.red
      );
  }

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

    Widget customBgTextField({required String label, TextEditingController? controller, required bool obsText,
    }){
      return Container(
        margin: const EdgeInsets.only(bottom: 22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        Container(
          margin: const EdgeInsets.only(bottom: 10.0),
          child: Text(label,),
        ),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xffE4E4E4),
            borderRadius: BorderRadius.circular(10.0)
          ),
          child:  TextField(
          controller: controller,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Input $label",
            contentPadding: const EdgeInsets.all(10)
          ),
          obscureText: obsText,
        ),
        ),
      ],
    ),
  );
}

    Widget textField = Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 20,bottom: 20,right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customBgTextField(label: "매장명",controller: usernameController, obsText: false),
            customBgTextField(label: "PW",controller: passwordController, obsText: true)
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
          var usernameText = usernameController.text.trim();
          var passwordText = passwordController.text;

          if(usernameText.isEmpty){
            showToast("username cannot be null or empty");
          }else if (passwordText.isEmpty){
            showToast("password cannot be null or empty");
          }else{
            showToast("ini akun $usernameText dan password $passwordText");
          }
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

 