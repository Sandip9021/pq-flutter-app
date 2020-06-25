import 'package:pbquiz_app/business_logic/models/quiz.dart';
import 'package:pbquiz_app/business_logic/view_models/base_viewmodel.dart';
import 'package:pbquiz_app/services/quiz_service.dart';
import 'package:pbquiz_app/services/service_locator.dart';

class CreateQuizViewModel extends BaseModel {
  final QuizService _apiService = serviceLocator<QuizService>();
  Quiz _quiz;
  String _questionText, _optionA, _optionB, _optionC, _optionD, _rightOption;
  set questionText(value) => _questionText = value;
  set optionA(value) => _optionA = value;
  set optionB(value) => _optionB = value;
  set optionC(value) => _optionC = value;
  set optionD(value) => _optionD = value;
  set rightOption(value) => _rightOption = value;
  set quiz(value) => _quiz = value;
  Quiz get quiz => _quiz;

  void createQuiz(
      String name, String description, DateTime date, String userId) async {
    _quiz = new Quiz(
      quizName: name,
      quizDescription: description,
      scheduledDate: date.toString(),
      questions: new List<Question>(),
      createdBy: userId,
    );
    print('Created Quiz object');
    print('name: ${_quiz.quizName}');
    print('desc: ${_quiz.quizDescription}');
    print('scheduled date: ${_quiz.scheduledDate.toString()}');
    print('questions: ${_quiz.questions.length}');
  }

  void addQuestion() {
    print('Adding question to Quiz object');
    _quiz.questions.add(newQuestion());
    print('name: ${_quiz.quizName}');
    print('desc: ${_quiz.quizDescription}');
    print('scheduled date: ${_quiz.scheduledDate.toString()}');
    print('questions: ${_quiz.questions.length}');
  }

  List<Option> optionList() {
    final optionA = new Option(optionId: 'a', optionText: _optionA);
    final optionB = new Option(optionId: 'b', optionText: _optionB);
    final optionC = new Option(optionId: 'c', optionText: _optionC);
    final optionD = new Option(optionId: 'd', optionText: _optionD);
    final options = new List<Option>();
    options.addAll([optionA, optionB, optionC, optionD]);
    return options;
  }

  Question newQuestion() {
    int questionId = _quiz.questions.length + 1;
    final newQuestion = Question(
      questionId: '$questionId',
      questionText: _questionText,
      optionList: optionList(),
      marks: 2,
      rightOption: _rightOption,
    );
    return newQuestion;
  }

  void clearData() {
    _questionText = '';
    _optionA = '';
    _optionB = '';
    _optionC = '';
    _optionD = '';
    _rightOption = '';
  }

  void nextQuestion() {
    clearData();
    notifyListeners();
  }

  Future<bool> submitQuiz() async {
    addQuestion();
    clearData();
    var result = await _apiService.createQuiz(this._quiz);
    return result;
  }
}
