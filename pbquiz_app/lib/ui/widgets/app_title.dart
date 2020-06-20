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
              child: Image.asset('assets/quiz.png',
                  height: 64, width: 64, alignment: Alignment.center),
            ),
            SizedBox(height: 10),
            Text(
              'PUB Quiz',
              style: Theme.of(context).textTheme.headline1,
            ),
            SizedBox(height: 20),
          ]),
    );
  }
}
