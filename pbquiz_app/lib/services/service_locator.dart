import 'package:get_it/get_it.dart';
import 'package:pbquiz_app/business_logic/view_models/home_viewmodel.dart';
import 'package:pbquiz_app/business_logic/view_models/quiz_viewmodel.dart';
import 'package:pbquiz_app/business_logic/view_models/signup_viewmodel.dart';
import 'package:pbquiz_app/services/quiz_service.dart';
import 'package:pbquiz_app/services/user_service.dart';
import 'package:pbquiz_app/services/webapi_service.dart';

GetIt serviceLocator = GetIt.instance;
void setupServiceLocator() {
  // services
  serviceLocator.registerLazySingleton<WebApiService>(() => WebApiService());
  serviceLocator.registerLazySingleton<UserService>(() => UserService());
  serviceLocator.registerLazySingleton<QuizService>(() => QuizService());
  // view models
  serviceLocator.registerFactory<SignUpViewModel>(() => SignUpViewModel());
  serviceLocator.registerFactory<QuizViewModel>(() => QuizViewModel());
  serviceLocator.registerFactory<HomeViewModel>(() => HomeViewModel());
}
