import 'package:flutter/foundation.dart';
import 'package:pbquiz_app/services/auth_service.dart';
import 'package:pbquiz_app/services/service_locator.dart';

class SignUpViewModel extends ChangeNotifier {
  final AuthService _authService = serviceLocator<AuthService>();
  String _name;
  String _email;
  String _password;

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

  Future<bool> signUp() {
    return _authService.fakeSignup(_name, _email, _password);
  }
}
