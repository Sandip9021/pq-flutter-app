import 'package:flutter/foundation.dart';
import 'package:pbquiz_app/business_logic/models/user.dart';
//import 'package:pbquiz_app/services/auth_service.dart';
import 'package:pbquiz_app/services/service_locator.dart';
import 'package:pbquiz_app/services/webapi_service.dart';

class SignInViewModel extends ChangeNotifier {
  final WebApiService _authService = serviceLocator<WebApiService>();
  String _email;
  String _password;
  User _user;
  void setEmail(String email) {
    _email = email;
  }

  void setPassword(String password) {
    _password = password;
  }

  Future<bool> signIn() async {
    try {
      _user = await _authService.signIn(_email, _password);
      return true;
    } catch (error) {
      return false;
    }
  }

  // Future<bool> signIn() {
  //   return _authService.fakeSignIn(_email, _password);
  // }

}
