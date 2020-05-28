import 'package:http/http.dart' as http;
import 'package:pbquiz_app/business_logic/models/quiz.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pbquiz_app/business_logic/models/user.dart';

class WebApiService {
  final _baseURL = 'localhost:3000';
  //final Map<String, String> _headers = {'Accept': 'application/json'};

  //storage
  final storage = new FlutterSecureStorage();
  final key = 'AUTH_TOKEN';

  void _encryptToken(String token) async {
    await storage.write(
      key: key,
      value: token,
    );
  }

  getToken() async {
    String token = await storage.read(key: key);
    return token;
  }

  //Register
  Future<User> registerUser(
    String name,
    String email,
    String password,
  ) async {
    print('Registering new user');
    final _path = 'users/register';
    var body = {
      "name": name,
      "email": email,
      "password": password,
    };
    var bodyEncoded = json.encode(body);
    final uri = Uri.http(_baseURL, _path);
    final results = await http.post(
      uri,
      body: bodyEncoded,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (results.statusCode == 201) {
      final jsonObject = json.decode(results.body);
      final token = jsonObject['token'];
      final userJSON = jsonObject['user'];
      _encryptToken(token);
      return User.fromJson(userJSON);
    } else {
      throw Exception('Failed to register user');
    }
  }

//Sign in
  Future<User> signIn(
    String email,
    String password,
  ) async {
    print('Signing in ...');
    final _path = 'users/login';
    var body = {
      "email": email,
      "password": password,
    };
    var bodyEncoded = json.encode(body);
    final uri = Uri.http(_baseURL, _path);
    final results = await http.post(
      uri,
      body: bodyEncoded,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (results.statusCode == 200) {
      final jsonObject = json.decode(results.body);
      final token = jsonObject['token'];
      final userJSON = jsonObject['user'];
      _encryptToken(token);
      return User.fromJson(userJSON);
    } else {
      throw Exception('Failed to register user');
    }
  }

  //Sign out
  Future<bool> signOut() async {
    print('Signing in ...');
    final _path = 'users/logout';
    final token = await getToken();
    print('Token: $token');
    final uri = Uri.http(_baseURL, _path);
    final results = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (results.statusCode == 200) {
      // Delete all
      await storage.deleteAll();
      return true;
    } else {
      throw Exception('Failed to register user');
    }
  }

  //fetch quiz
  Future<Quiz> fetchQuiz() async {
    print('getting rates from the web');
    final _path = 'getquiz';
    var queryParameters = {
      'id': '1009',
    };
    final token = await getToken();
    print('Token: $token');
    final header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final uri = Uri.http(_baseURL, _path, queryParameters);
    final results = await http.get(uri, headers: header);
    final jsonObject = json.decode(results.body);
    return Quiz.fromJson(jsonObject);
  }

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
