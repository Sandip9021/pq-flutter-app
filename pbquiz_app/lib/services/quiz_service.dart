import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pbquiz_app/business_logic/models/quiz.dart';
import 'package:pbquiz_app/services/webapi_service.dart';

class QuizService extends WebApiService {
  //fetch quiz
  Future<Quiz> fetchQuiz(String id) async {
    print('getting rates from the web');
    final _path = 'quiz/getquiz';
    var queryParameters = {
      'id': '$id',
    };
    final token = await getAuthToken();
    print('Token: $token');
    final _headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final uri = Uri.http(baseURl, _path, queryParameters);
    final results = await http.get(uri, headers: _headers);
    final jsonObject = json.decode(results.body);
    return Quiz.fromJson(jsonObject);
  }

  Future<bool> createQuiz(Quiz quiz) async {
    print('Creating quiz');
    final _path = 'quiz/createquiz';
    final token = await getAuthToken();
    print('Token: $token');
    final _headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final map = quiz.toJson();
    final bodyEncoded = jsonEncode(map);
    final uri = Uri.http(baseURl, _path);
    final results = await http.post(
      uri,
      body: bodyEncoded,
      headers: _headers,
    );
    if (results.statusCode == 201) {
      return true;
    } else {
      throw Exception('Failed to create quiz');
    }
  }

  Future<Result> submitQuiz(AnswerList answer) async {
    print('Submitting quiz');
    final _path = 'answer/submitandevaluate';
    final token = await getAuthToken();
    print('Token: $token');
    final _headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final map = answer.toJson();
    final bodyEncoded = jsonEncode(map);
    final uri = Uri.http(baseURl, _path);
    final results = await http.post(
      uri,
      body: bodyEncoded,
      headers: _headers,
    );
    if (results.statusCode == 201) {
      final jsonObject = json.decode(results.body);
      print('Quiz Submitted');
      return Result.fromJson(jsonObject);
    } else {
      throw Exception('Failed to submit quiz');
    }
  }
}
