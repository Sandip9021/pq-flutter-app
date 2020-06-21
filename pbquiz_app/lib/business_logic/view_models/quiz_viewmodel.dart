import 'package:pbquiz_app/business_logic/models/quiz.dart';
import 'package:pbquiz_app/business_logic/view_models/base_viewmodel.dart';
import 'package:pbquiz_app/services/service_locator.dart';
import 'package:pbquiz_app/services/quiz_service.dart';

class QuizViewModel extends BaseModel {
  final QuizService _apiService = serviceLocator<QuizService>();
  Quiz quiz;
  Result result;
  Question currentQuestion;
  var currentQuestionIdex;
  AnswerList _answerList;

  void loadQuiz(String quizId) async {
    setState(ViewState.Busy);
    quiz = await _apiService.fetchQuiz(quizId);
    _answerList = AnswerList(
      quizId: quiz.quizId,
      userId: await _apiService.getUserID(),
      answers: List<Answer>(),
    );
    currentQuestionIdex = 0;
    currentQuestion = quiz.questions[currentQuestionIdex];
    setState(ViewState.Idle);
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

  String selectedOption() {
    String selectedOptionId = "not_attempted";
    for (var option in currentQuestion.optionList) {
      if (option.selected) {
        selectedOptionId = option.optionId;
        break;
      }
    }
    return selectedOptionId;
  }

  void changeSelectedOption(String newOptionId) {
    currentQuestion.optionList.forEach((option) {
      option.selected = option.optionId == newOptionId ? true : false;
    });
    notifyListeners();
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

  Future<bool> submit() async {
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
    try {
      result = await _apiService.submitQuiz(_answerList);
      return true;
    } catch (error) {
      return false;
    }
  }
}
