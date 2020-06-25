import 'package:flutter/material.dart';
import 'package:pbquiz_app/business_logic/models/user.dart';
import 'package:pbquiz_app/services/service_locator.dart';
import 'package:pbquiz_app/services/user_service.dart';
import 'package:pbquiz_app/ui/shared/router.dart';
import 'package:provider/provider.dart';

void main() {
  setupServiceLocator();
  runApp(MyApp());
}

const themeBlue = const Color(0xff1724fe);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>(
      create: (context) => serviceLocator<UserService>().userController.stream,
      initialData: User.initial(),
      child: MaterialApp(
        title: 'Pub Quiz',
        theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.indigo,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Roboto',
          textTheme: TextTheme(
            headline1: TextStyle(
                fontSize: 26.0,
                fontWeight: FontWeight.bold,
                color: Colors.indigo),
            headline2: TextStyle(
              fontSize: 22.0,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold,
              color: Colors.indigo,
            ),
            headline5: TextStyle(
              fontSize: 16.0,
              fontStyle: FontStyle.normal,
              color: Colors.indigo,
            ),
            headline6: TextStyle(
              fontSize: 20.0,
              fontStyle: FontStyle.normal,
            ),
            bodyText1: TextStyle(
              fontSize: 16.0,
              color: Colors.grey[900],
            ),
            bodyText2: TextStyle(
              fontSize: 14.0,
              color: Colors.grey[900],
            ),
            button: TextStyle(
              fontSize: 14.0,
              color: Colors.white,
            ),
          ),
        ),
        initialRoute: 'Signup',
        onGenerateRoute: Router.generateRoute,
      ),
    );
  }
}
