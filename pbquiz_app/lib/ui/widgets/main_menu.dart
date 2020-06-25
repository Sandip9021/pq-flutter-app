import 'package:flutter/material.dart';
import 'package:pbquiz_app/business_logic/utils/constants.dart';
import 'package:pbquiz_app/services/service_locator.dart';
import 'package:pbquiz_app/services/user_service.dart';

class MainMenu extends StatelessWidget {
  final UserService _userService = serviceLocator<UserService>();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _createHeader(),
          _createDrawerItem(
            icon: Icons.home,
            text: 'Home',
            onTap: () => Navigator.pushReplacementNamed(context, homeRoute),
          ),
          _createDrawerItem(
            icon: Icons.add_circle_outline,
            text: 'Create Quiz',
            onTap: () =>
                Navigator.pushReplacementNamed(context, createQuizRoute),
          ),
          _createDrawerItem(
            icon: Icons.person_outline,
            text: 'Profile',
            onTap: () {},
          ),
          _createDrawerItem(
            icon: Icons.settings,
            text: 'Settings',
            onTap: () {},
          ),
          _createDrawerItem(
            icon: Icons.exit_to_app,
            text: 'Sign Out',
            onTap: () async {
              showAlertDialog(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _createHeader() {
    return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage('assets/bg-018.jpg'),
        ),
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: 12.0,
            left: 16.0,
            child: Text(
              "Welcome to PubQuiz",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget _createDrawerItem(
      {IconData icon, String text, GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(
              text,
            ),
          )
        ],
      ),
      onTap: onTap,
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Continue"),
      onPressed: () async {
        await _userService.signOut().then((success) => success
            ? Navigator.pushReplacementNamed(context, initialRoute)
            : null);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Sign out"),
      content: Text("Would you like to sign out of the app?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
