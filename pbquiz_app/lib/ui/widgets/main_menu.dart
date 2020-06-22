import 'package:flutter/material.dart';

class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _createHeader(),
          _createDrawerItem(
            icon: Icons.add_circle_outline,
            text: 'Create Quiz',
            onTap: () => Navigator.pushNamed(context, 'CreateQuiz'),
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
            onTap: () {},
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
}
