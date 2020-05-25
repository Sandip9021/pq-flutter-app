import 'package:flutter/foundation.dart';
import 'package:pbquiz_app/services/auth_service.dart';
import 'package:pbquiz_app/services/service_locator.dart';

class SignInViewModel extends ChangeNotifier {
  final AuthService _authService = serviceLocator<AuthService>();
  String _email;
  String _password;

  void setEmail(String email) {
    _email = email;
  }

  void setPassword(String password) {
    _password = password;
  }

  // Future<bool> signIn(String email, String password) {
  //   return _authService.fakeSignIn(email, password);
  // }

  Future<bool> signIn() {
    return _authService.fakeSignIn(_email, _password);
  }
}
