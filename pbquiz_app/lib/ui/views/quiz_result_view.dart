import 'package:flutter/material.dart';
import 'package:pbquiz_app/business_logic/utils/constants.dart';

class QuizResultView extends StatelessWidget {
  final String result;
  QuizResultView({Key key, @required this.result}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Result'),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Text(
              'Awesome! You have got $result!!',
              softWrap: true,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 20.0,
              ),
            ),
            RaisedButton(
              child: Text("Home"),
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              onPressed: () {
                Navigator.pushNamed(context, homeRoute);
              },
            )
          ],
        ),
      ),
    );
  }
}
