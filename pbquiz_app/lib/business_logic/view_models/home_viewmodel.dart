import 'package:flutter/material.dart';
import 'package:pbquiz_app/services/user_service.dart';
import 'package:pbquiz_app/services/service_locator.dart';

class HomeViewModel extends ChangeNotifier {
  UserService _apiService = serviceLocator<UserService>();
  Future<bool> signOut() async {
    try {
      await _apiService.signOut();
      return true;
    } catch (error) {
      return false;
    }
  }
}
