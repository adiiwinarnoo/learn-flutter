class AuthManager {
  
  String? _userToken;
  static final AuthManager _instance = AuthManager._internal();

  factory AuthManager(){
    return _instance;
  }

  AuthManager._internal();

  void setUserToken(String token){
    _userToken = token;
  }

  String? getUserToken(){
    return _userToken;
  }


}