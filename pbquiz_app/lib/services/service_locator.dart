import 'package:get_it/get_it.dart';
import 'package:pbquiz_app/business_logic/view_models/signin_viewmodel.dart';
import 'package:pbquiz_app/business_logic/view_models/signup_viewmodel.dart';
import 'package:pbquiz_app/services/auth_service.dart';

GetIt serviceLocator = GetIt.instance;
void setupServiceLocator() {
  // services
  serviceLocator.registerLazySingleton<AuthService>(() => AuthService());

  // view models
  serviceLocator.registerFactory<SignInViewModel>(() => SignInViewModel());
  serviceLocator.registerFactory<SignUpViewModel>(() => SignUpViewModel());
}
