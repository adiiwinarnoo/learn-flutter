class Login {
  final int status;
  final String message;
  final String token;


  const Login ({
    required this.status,
    required this.message,
    required this.token
  });

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
      status: json['status'],
      message: json['message'],
      token: json['token'],
    );
  }
}