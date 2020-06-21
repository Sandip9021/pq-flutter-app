import 'package:flutter/material.dart';
import 'package:pbquiz_app/business_logic/models/quiz.dart';
import 'package:pbquiz_app/ui/views/home_view.dart';
import 'package:pbquiz_app/ui/views/quiz_start_view.dart';
import 'package:pbquiz_app/ui/views/signup_view.dart';

const String initialRoute = "Signup";

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomeView());
        break;
      case 'Signup':
        return MaterialPageRoute(builder: (_) => SignUp());
        break;
      case 'StartQuiz':
        var _quiz = settings.arguments as Quiz;
        return MaterialPageRoute(
            builder: (_) => QuizStartView(
                  quiz: _quiz,
                ));
      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
        });
    }
  }
}
