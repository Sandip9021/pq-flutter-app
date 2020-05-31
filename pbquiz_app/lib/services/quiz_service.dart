import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pbquiz_app/business_logic/models/quiz.dart';
import 'package:pbquiz_app/services/webapi_service.dart';

class QuizService extends WebApiService {
  //fetch quiz
  Future<Quiz> fetchQuiz(String id) async {
    print('getting rates from the web');
    final _path = 'getquiz';
    var queryParameters = {
      'id': '$id',
    };
    final token = await getAuthToken();
    print('Token: $token');
    final header = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final uri = Uri.http(baseURl, _path, queryParameters);
    final results = await http.get(uri, headers: header);
    final jsonObject = json.decode(results.body);
    return Quiz.fromJson(jsonObject);
  }
}
