import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pbquiz_app/business_logic/models/user.dart';
import 'package:pbquiz_app/services/webapi_service.dart';

class UserService extends WebApiService {
  //Register
  Future<User> registerUser(
    String name,
    String email,
    String password,
  ) async {
    print('Registering new user');
    final _path = 'users/register';
    final _headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };
    final body = {
      "name": name,
      "email": email,
      "password": password,
    };
    var bodyEncoded = json.encode(body);
    final uri = Uri.http(baseURl, _path);
    final results = await http.post(
      uri,
      body: bodyEncoded,
      headers: _headers,
    );
    if (results.statusCode == 201) {
      final jsonObject = json.decode(results.body);
      final token = jsonObject['token'];
      final userJSON = jsonObject['user'];
      storeAuthToken(token);
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
    final body = {
      "email": email,
      "password": password,
    };
    final _headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };
    var bodyEncoded = json.encode(body);
    final uri = Uri.http(baseURl, _path);
    final results = await http.post(
      uri,
      body: bodyEncoded,
      headers: _headers,
    );
    if (results.statusCode == 200) {
      final jsonObject = json.decode(results.body);
      final token = jsonObject['token'];
      final userJSON = jsonObject['user'];
      storeAuthToken(token);
      return User.fromJson(userJSON);
    } else {
      throw Exception('Failed to register user');
    }
  }

  //Sign out
  Future<bool> signOut() async {
    print('Signing in ...');
    final _path = 'users/logout';
    final token = await getAuthToken();
    final _headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final uri = Uri.http(baseURl, _path);
    final results = await http.post(
      uri,
      headers: _headers,
    );
    if (results.statusCode == 200) {
      // Delete all
      await deleteStorage();
      return true;
    } else {
      throw Exception('Failed to register user');
    }
  }
}
