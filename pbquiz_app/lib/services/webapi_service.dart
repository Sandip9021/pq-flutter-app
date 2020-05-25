import 'package:http/http.dart' as http;
import 'package:pbquiz_app/business_logic/models/quiz.dart';
import 'dart:convert';

class WebApiService {
  final _baseURL = 'localhost:3000';
  final _path = 'getquiz';
  final Map<String, String> _headers = {'Accept': 'application/json'};
  Quiz _quiz;
  Future<Quiz> fetchQuiz() async {
    if (_quiz == null) {
      print('getting rates from the web');
      var queryParameters = {
        'id': '1009',
      };
      final uri = Uri.http(_baseURL, _path, queryParameters);
      final results = await http.get(uri, headers: _headers);
      final jsonObject = json.decode(results.body);
      _quiz = Quiz.fromJson(jsonObject);
    }
    return _quiz;
  }

  //New method to get the token from local storage

  Quiz fakeFetchQuiz() {
    return Quiz.fromJson(quizJSON);
  }

  void submitAnswer(AnswerList answerList) {
    print("Submitted successfully!");
  }
}

const quizJSON = {
  "quizId": "1001",
  "questions": [
    {
      "questionId": "1",
      "questionText":
          "How many roads must a man walk down before you can call him a man?",
      "options": [
        {"optionId": "a", "optionText": "10"},
        {"optionId": "b", "optionText": "12"},
        {"optionId": "c", "optionText": "32"},
        {"optionId": "d", "optionText": "22"}
      ]
    },
    {
      "questionId": "2",
      "questionText": "Who is the Prime minister of UK?",
      "options": [
        {"optionId": "a", "optionText": "Boris Jhonson"},
        {"optionId": "b", "optionText": "Angela Markel"},
        {"optionId": "c", "optionText": "Theresa May"},
        {"optionId": "d", "optionText": "Donald Trump"}
      ]
    },
    {
      "questionId": "3",
      "questionText": "Who is the Prime minister of India?",
      "options": [
        {"optionId": "a", "optionText": "Manmohan Singh"},
        {"optionId": "b", "optionText": "Narendra Modi"},
        {"optionId": "c", "optionText": "Rahul Gandhi"},
        {"optionId": "d", "optionText": "Sashi Tharoor"}
      ]
    }
  ]
};
