import 'package:flutter/material.dart';
import 'package:pbquiz_app/ui/views/home_view.dart';

class QuizResultView extends StatefulWidget {
  @override
  _QuizResultViewState createState() => _QuizResultViewState();
}

class _QuizResultViewState extends State<QuizResultView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Result')),
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
              'Awesome! You have got 18 and you Rank is 2nd',
              softWrap: true,
            ),
            RaisedButton(
              child: Text("Home"),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeView()));
              },
            )
          ],
        ),
      ),
    );
  }
}
