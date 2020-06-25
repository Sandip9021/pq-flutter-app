import 'package:flutter/material.dart';
import 'package:pbquiz_app/business_logic/models/quiz.dart';
import 'package:pbquiz_app/business_logic/utils/constants.dart';
import 'package:pbquiz_app/ui/views/add_question_view.dart';
import 'package:pbquiz_app/ui/views/create_quiz_view.dart';
import 'package:pbquiz_app/ui/views/home_view.dart';
import 'package:pbquiz_app/ui/views/quiz_result_view.dart';
import 'package:pbquiz_app/ui/views/quiz_start_view.dart';
import 'package:pbquiz_app/ui/views/quiz_view.dart';
import 'package:pbquiz_app/ui/views/signup_view.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initialRoute:
        return MaterialPageRoute(builder: (_) => SignUp());
        break;

      case homeRoute:
        return MaterialPageRoute(builder: (_) => HomeView());
        break;

      case startQuizRoute:
        var _quiz = settings.arguments as Quiz;
        return MaterialPageRoute(
          builder: (_) => QuizStartView(
            quiz: _quiz,
          ),
        );
      case quizRoute:
        var _quizId = settings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => QuizView(
                  quizId: _quizId,
                ));
      case quizResultRoute:
        var _result = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => QuizResultView(
            result: _result,
          ),
        );
      case createQuizRoute:
        return MaterialPageRoute(builder: (_) => CreateQuizView());
        break;
      case addQuestionRoute:
        var arguments = settings.arguments as List;
        var _name = arguments[0];
        var _desc = arguments[1];
        var _date = arguments[2];
        return MaterialPageRoute(
          builder: (_) => AddQuestionView(
            quizName: _name,
            quizDesc: _desc,
            scheduledDate: _date,
          ),
        );
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
