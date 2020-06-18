import 'package:flutter/material.dart';
import 'package:pbquiz_app/business_logic/models/quiz.dart';
import 'package:pbquiz_app/services/quiz_service.dart';
import 'package:pbquiz_app/services/user_service.dart';
import 'package:pbquiz_app/services/service_locator.dart';

class HomeViewModel extends ChangeNotifier {
  List<Quiz> quizList;
  UserService _userService = serviceLocator<UserService>();
  QuizService _quizService = serviceLocator<QuizService>();
  bool _loading = true;
  bool _error = false;

  bool loading() {
    return _loading;
  }

  bool error() {
    return _error;
  }

  Future<bool> signOut() async {
    try {
      await _userService.signOut();
      return true;
    } catch (error) {
      return false;
    }
  }

  void getAllQuiz() async {
    try {
      quizList = await _quizService.fetchAllQuizes();
      _loading = false;
      _error = false;
      print("Loading Quiz");
      notifyListeners();
    } catch (error) {
      _loading = false;
      _error = true;
      print("Error");
      notifyListeners();
    }
  }
}
