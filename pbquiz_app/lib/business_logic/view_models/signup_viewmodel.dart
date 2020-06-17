import 'package:flutter/foundation.dart';
import 'package:pbquiz_app/business_logic/models/user.dart';
import 'package:pbquiz_app/services/service_locator.dart';
import 'package:pbquiz_app/services/user_service.dart';

class SignUpViewModel extends ChangeNotifier {
  final UserService _apiService = serviceLocator<UserService>();
  String _name;
  String _email;
  String _password;
  bool _isSignUp = false;
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

  void toogleView() {
    _isSignUp = !_isSignUp;
    notifyListeners();
  }

  bool isSignUp() {
    return _isSignUp;
  }

  Future<bool> submit() async {
    try {
      if (_isSignUp) {
        _user = await _apiService.registerUser(_name, _email, _password);
      } else {
        _user = await _apiService.signIn(_email, _password);
      }
      print("SUCCESS: $_user");
      return true;
    } catch (error) {
      return false;
    }
  }

  Future<bool> signUp() async {
    try {
      _user = await _apiService.registerUser(_name, _email, _password);
      await _apiService.storeUserID(_user.userId);
      return true;
    } catch (error) {
      return false;
    }
  }

  Future<bool> signIn() async {
    try {
      _user = await _apiService.signIn(_email, _password);
      await _apiService.storeUserID(_user.userId);
      return true;
    } catch (error) {
      return false;
    }
  }
}
