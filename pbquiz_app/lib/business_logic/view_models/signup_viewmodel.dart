import 'package:pbquiz_app/business_logic/models/user.dart';
import 'package:pbquiz_app/business_logic/view_models/base_viewmodel.dart';
import 'package:pbquiz_app/services/service_locator.dart';
import 'package:pbquiz_app/services/user_service.dart';

class SignUpViewModel extends BaseModel {
  final UserService _apiService = serviceLocator<UserService>();
  String _name;
  String _email;
  String _password;
  User _user;
  void setName(String name) {
    _name = name;
  }

  void setEmail(String email) {
    _email = email;
  }

  void setPassword(String password) {
    _password = password;
  }

  Future<bool> submit(bool isSignUp) async {
    setState(ViewState.Busy);
    try {
      if (isSignUp) {
        _user = await _apiService.registerUser(_name, _email, _password);
      } else {
        _user = await _apiService.signIn(_email, _password);
      }
      await _apiService.storeUserID(_user.userId);
      setState(ViewState.Idle);
      return true;
    } catch (error) {
      setState(ViewState.Idle);
      return false;
    }
  }
}
