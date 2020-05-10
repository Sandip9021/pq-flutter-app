import 'package:flutter/foundation.dart';
import 'package:pbquiz_app/services/auth_service.dart';
import 'package:pbquiz_app/services/service_locator.dart';

class SignInViewModel extends ChangeNotifier {
  final AuthService _authService = serviceLocator<AuthService>();

  Future<bool> signIn(String email, String password) {
    return _authService.fakeSignIn(email, password);
  }
}
