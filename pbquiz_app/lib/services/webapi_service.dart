import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pbquiz_app/business_logic/models/quiz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class WebApiService {
  final _baseURL = 'localhost:3000';
  String get baseURl => _baseURL;

  //storage
  final _storage = new FlutterSecureStorage();
  final _authKey = 'AUTH_TOKEN';
  final _userIDkey = 'USER_ID';
  storeAuthToken(String token) async {
    await _storage.write(
      key: _authKey,
      value: token,
    );
  }

  getAuthToken() async {
    String token = await _storage.read(key: _authKey);
    return token;
  }

  storeUserID(String userId) async {
    await _storage.write(
      key: _userIDkey,
      value: userId,
    );
  }

  getUserID() async {
    String token = await _storage.read(key: _userIDkey);
    return token;
  }

  deleteStorage() async {
    await _storage.deleteAll();
  }

  Quiz fakeFetchQuiz() {
    return Quiz.fromJson(quizJSON);
  }

  Future post(String path, Map body) async {
    final token = await getAuthToken();
    final _headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final bodyEncoded = jsonEncode(body);
    final uri = Uri.http(baseURl, path);
    final results = await http.post(
      uri,
      body: bodyEncoded,
      headers: _headers,
    );
    if (results.statusCode == 201) {
      final jsonObject = json.decode(results.body);
      return jsonObject;
    } else {
      throw Exception('POST method failed - $path ');
    }
  }

  Future get(String path, [Map queryParameters]) async {
    final token = await getAuthToken();
    final _headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final uri = queryParameters == null
        ? Uri.http(baseURl, path)
        : Uri.http(baseURl, path, queryParameters);
    final results = await http.get(
      uri,
      headers: _headers,
    );
    if (results.statusCode == 200) {
      final jsonObject = json.decode(results.body);
      return jsonObject;
    } else {
      throw Exception('GET method failed - $path ');
    }
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
