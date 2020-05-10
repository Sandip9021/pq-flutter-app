import 'package:flutter/foundation.dart';
import 'package:pbquiz_app/services/auth_service.dart';
import 'package:pbquiz_app/services/service_locator.dart';

class SignUpViewModel extends ChangeNotifier {
  final AuthService _authService = serviceLocator<AuthService>();

  Future<bool> signUp(String name, String email, String password) {
    return _authService.fakeSignup(name, email, password);
  }
}
