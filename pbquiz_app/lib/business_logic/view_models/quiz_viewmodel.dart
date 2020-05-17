import 'package:flutter/material.dart';
import 'package:pbquiz_app/business_logic/models/quiz.dart';
import 'package:pbquiz_app/services/service_locator.dart';
import 'package:pbquiz_app/services/webapi_service.dart';

class QuizViewModel extends ChangeNotifier {
  final WebApiService _apiService = serviceLocator<WebApiService>();
  Quiz quiz;
  Question currentQuestion;
  String selectedOptionId;
  var currentQuestionIdex;
  AnswerList answerList;

  void loadQuiz() {
    quiz = _apiService.fakeFetchQuiz();
    answerList = AnswerList(
      quizId: quiz.quizId,
      answers: List<Answer>(),
    );
    currentQuestionIdex = 0;
    currentQuestion = quiz.questions[currentQuestionIdex];
  }

  String questionText() {
    return quiz.questions[currentQuestionIdex].questionText;
  }

  int totalQuestionCount() {
    return quiz.questions.length;
  }

  bool lastQuestion() {
    if (attemptedQuestionCount() == quiz.questions.length) {
      return true;
    }
    return false;
  }

  int attemptedQuestionCount() {
    return currentQuestionIdex + 1;
  }

  void displayNext() {
    currentQuestionIdex += 1;
    Answer answer = Answer(
      questionId: currentQuestion.questionId,
      selectedOptionId: selectedOptionId,
    );
    answerList.answers.add(answer);
    selectedOptionId = "not_attempted";
    currentQuestion = quiz.questions[currentQuestionIdex];
    notifyListeners();
  }

  void submit() {
    Answer answer = Answer(
      questionId: currentQuestion.questionId,
      selectedOptionId: selectedOptionId,
    );
    answerList.answers.add(answer);
    _apiService.submitAnswer(answerList);
  }
}
