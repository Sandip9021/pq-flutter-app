import 'package:flutter/material.dart';
import 'package:pbquiz_app/business_logic/models/quiz.dart';
import 'package:pbquiz_app/ui/views/create_quiz_view.dart';
import 'package:pbquiz_app/ui/views/home_view.dart';
import 'package:pbquiz_app/ui/views/quiz_result_view.dart';
import 'package:pbquiz_app/ui/views/quiz_start_view.dart';
import 'package:pbquiz_app/ui/views/quiz_view.dart';
import 'package:pbquiz_app/ui/views/signup_view.dart';

const String initialRoute = "Signup";

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'Home':
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
          ),
        );
      case 'Quiz':
        var _quizId = settings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => QuizView(
                  quizId: _quizId,
                ));
      case 'QuizResult':
        var _result = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => QuizResultView(
            result: _result,
          ),
        );
      case 'CreateQuiz':
        return MaterialPageRoute(builder: (_) => CreateQuizView());
        break;

      default:
        return MaterialPageRoute(
          builder: (_) {
            return Scaffold(
              body: Center(
                child: Text('No route defined for ${settings.name}'),
              ),
            );
          },
        );
    }
  }
}
