import 'package:flutter/material.dart';
import 'package:pbquiz_app/business_logic/models/quiz.dart';
import 'package:pbquiz_app/services/service_locator.dart';
import 'package:pbquiz_app/services/quiz_service.dart';

class QuizViewModel extends ChangeNotifier {
  final QuizService _apiService = serviceLocator<QuizService>();
  Quiz quiz;
  Question currentQuestion;
  var currentQuestionIdex;
  AnswerList _answerList;
  bool _loadingQuiz = true;

  bool loading() {
    return _loadingQuiz;
  }

  void loadQuiz() async {
    quiz = await _apiService.fetchQuiz('1009');
    _answerList = AnswerList(
      quizId: quiz.quizId,
      answers: List<Answer>(),
    );
    currentQuestionIdex = 0;
    currentQuestion = quiz.questions[currentQuestionIdex];
    _loadingQuiz = false;
    notifyListeners();
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

  bool firstQuestion() {
    if (attemptedQuestionCount() == 1) {
      return true;
    }
    return false;
  }

  int attemptedQuestionCount() {
    return currentQuestionIdex + 1;
  }

  void selectOption(int index) {
    int lastSelectedOptionIndex;
    for (var option in currentQuestion.optionList) {
      if (option.selected) {
        lastSelectedOptionIndex = currentQuestion.optionList.indexOf(option);
        break;
      }
    }
    if (lastSelectedOptionIndex != null && lastSelectedOptionIndex != index) {
      currentQuestion.optionList[lastSelectedOptionIndex].selected = false;
    }
    currentQuestion.optionList[index].selected =
        !currentQuestion.optionList[index].selected;
    notifyListeners();
  }

  void displayNext() {
    currentQuestionIdex += 1;
    currentQuestion = quiz.questions[currentQuestionIdex];
    notifyListeners();
  }

  void displayPrevious() {
    currentQuestionIdex -= 1;
    currentQuestion = quiz.questions[currentQuestionIdex];
    notifyListeners();
  }

  void submit() {
    for (var question in quiz.questions) {
      String selectedOptionId = "not_attempted";
      for (var option in question.optionList) {
        if (option.selected) {
          selectedOptionId = option.optionId;
          break;
        }
      }
      Answer answer = Answer(
        questionId: question.questionId,
        selectedOptionId: selectedOptionId,
      );
      _answerList.answers.add(answer);
    }
    _apiService.submitAnswer(_answerList);
  }
}
