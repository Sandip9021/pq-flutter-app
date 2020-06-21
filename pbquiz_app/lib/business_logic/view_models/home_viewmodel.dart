import 'package:pbquiz_app/business_logic/models/quiz.dart';
import 'package:pbquiz_app/business_logic/view_models/base_viewmodel.dart';
import 'package:pbquiz_app/services/quiz_service.dart';
import 'package:pbquiz_app/services/user_service.dart';
import 'package:pbquiz_app/services/service_locator.dart';

class HomeViewModel extends BaseModel {
  List<Quiz> quizList;
  UserService _userService = serviceLocator<UserService>();
  QuizService _quizService = serviceLocator<QuizService>();

  Future<bool> signOut() async {
    try {
      setState(ViewState.Busy);
      await _userService.signOut();
      setState(ViewState.Idle);
      return true;
    } catch (error) {
      setState(ViewState.Idle);
      return false;
    }
  }

  void getAllQuiz() async {
    setState(ViewState.Busy);
    quizList = await _quizService.fetchAllQuizes();
    print("Loading Quiz");
    setState(ViewState.Idle);
  }
}
