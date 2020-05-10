class AuthService {
  AuthService();

  String _email = "test";
  String _password = "pass";

  Future<bool> fakeSignIn(String email, String password) {
    if (_email == email && _password == password) {
      return Future.delayed(Duration(seconds: 1), () => true);
    } else {
      return Future.delayed(Duration(seconds: 1), () => false);
    }
  }

  Future<bool> fakeSignup(String name, String email, String password) {
    return Future.delayed(Duration(seconds: 1), () => true);
  }
}
