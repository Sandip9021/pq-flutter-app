import 'package:pbquiz_app/business_logic/models/quiz.dart';
import 'package:pbquiz_app/services/webapi_service.dart';

class QuizService extends WebApiService {
  Future<List<Quiz>> fetchAllQuizes() async {
    print('Getting all quizes');
    final _path = 'quiz/getallquiz';
    try {
      final result = await get(_path);
      var list = result as List;
      List<Quiz> quizList = list.map((i) => Quiz.fromJson(i)).toList();
      return quizList;
    } catch (error) {
      print(error.toString());
      List<Quiz> quizList = new List<Quiz>();
      return quizList;
    }
  }

  //fetch quiz
  Future<Quiz> fetchQuiz(String id) async {
    print('getting Quiz $id from the web');
    final _path = 'quiz/getquiz';
    var _queryParameters = {
      'id': '$id',
    };
    try {
      final result = await get(_path, _queryParameters);
      return Quiz.fromJson(result);
    } catch (error) {
      print(error.toString());
      return Quiz();
    }
  }

  Future<bool> createQuiz(Quiz quiz) async {
    print('Creating quiz');
    final _path = 'quiz/createquiz';
    final _body = quiz.toJson();
    try {
      final result = await post(_path, _body);
      return true;
    } catch (error) {
      return false;
    }
  }

  Future<Result> submitQuiz(AnswerList answer) async {
    print('Submitting quiz');
    final _path = 'answer/submitandevaluate';
    final _body = answer.toJson();

    try {
      final result = await post(_path, _body);
      return Result.fromJson(result);
    } catch (error) {
      print(error.toString());
      return Result();
    }
  }
}
