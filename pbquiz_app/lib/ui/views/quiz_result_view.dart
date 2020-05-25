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
              'Awesome! You have got 18 and your rank is 2',
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
