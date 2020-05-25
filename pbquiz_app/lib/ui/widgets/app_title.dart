import 'package:flutter/material.dart';

class AppTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Image.asset("assets/quiz_icon_small.png",
                  height: 30, width: 30, alignment: Alignment.center),
            ),
            SizedBox(height: 10),
            Text(
              "PUB QUIZ",
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 20),
          ]),
    );
  }
}
