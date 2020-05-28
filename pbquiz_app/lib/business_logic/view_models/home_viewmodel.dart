import 'package:flutter/material.dart';
import 'package:pbquiz_app/services/webapi_service.dart';
import 'package:pbquiz_app/services/service_locator.dart';

class HomeViewModel extends ChangeNotifier {
  WebApiService _apiService = serviceLocator<WebApiService>();
  Future<bool> signOut() async {
    try {
      await _apiService.signOut();
      return true;
    } catch (error) {
      return false;
    }
  }
}
