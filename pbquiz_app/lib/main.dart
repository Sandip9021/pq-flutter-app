import 'package:flutter/material.dart';
import 'package:pbquiz_app/business_logic/models/user.dart';
import 'package:pbquiz_app/services/service_locator.dart';
import 'package:pbquiz_app/services/user_service.dart';
import 'package:pbquiz_app/ui/views/signup_view.dart';
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
          // This is the theme of your application.
          brightness: Brightness.light,
          primarySwatch: Colors.indigo,
          // This makes the visual density adapt to the platform that you run
          // the app on. For desktop platforms, the controls will be smaller and
          // closer together (more dense) than on mobile platforms.
          visualDensity: VisualDensity.adaptivePlatformDensity,
          // Define the default font family.
          fontFamily: 'Roboto',
          // Define the default TextTheme. Use this to specify the default
          // text styling for headlines, titles, bodies of text, and more.
          textTheme: TextTheme(
            headline1: TextStyle(
                fontSize: 26.0,
                fontWeight: FontWeight.bold,
                color: Colors.indigo),
            headline6: TextStyle(
              fontSize: 20.0,
              fontStyle: FontStyle.normal,
            ),
            bodyText1: TextStyle(
              fontSize: 16.0,
              fontFamily: 'Roboto',
              color: Colors.grey[900],
            ),
            bodyText2: TextStyle(
              fontSize: 14.0,
              fontFamily: 'Roboto',
              color: Colors.grey[900],
            ),
            button: TextStyle(
              fontSize: 14.0,
              fontFamily: 'Roboto',
              color: Colors.white,
            ),
          ),
        ),
        home: SignUp(),
      ),
    );
  }
}
