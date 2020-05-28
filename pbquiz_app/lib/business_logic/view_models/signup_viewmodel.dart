import 'package:flutter/foundation.dart';
import 'package:pbquiz_app/business_logic/models/user.dart';
//import 'package:pbquiz_app/services/auth_service.dart';
import 'package:pbquiz_app/services/service_locator.dart';
import 'package:pbquiz_app/services/webapi_service.dart';

class SignUpViewModel extends ChangeNotifier {
  //final AuthService _authService = serviceLocator<AuthService>();
  final WebApiService _apiService = serviceLocator<WebApiService>();
  String _name;
  String _email;
  String _password;
  User _user;
  void setName(String name) {
    _name = name;
  }

  void setEmail(String email) {
    _email = email;
  }

  void setPassword(String password) {
    _password = password;
  }

  // Future<bool> signUp(String name, String email, String password) {
  //   return _authService.fakeSignup(name, email, password);
  // }

  Future<bool> signUp() async {
    try {
      _user = await _apiService.registerUser(_name, _email, _password);
      return true;
    } catch (error) {
      return false;
    }
  }
}
