import 'package:flutter/material.dart';
import 'package:pbquiz_app/ui/views/question_view.dart';

class QuizStartView extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<QuizStartView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Start Quiz"),
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
            textSection,
            RaisedButton(
              child: Text("Start"),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => QuestionView()));
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget textSection = Container(
    padding: const EdgeInsets.all(10),
    child: Text(
      'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
      'Alps. Situated 1,578 meters above sea level, it is one of the '
      'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
      'half-hour walk through pastures and pine forest, leads you to the '
      'lake, which warms to 20 degrees Celsius in the summer. Activities '
      'enjoyed here include rowing, and riding the summer toboggan run.',
      softWrap: true,
    ),
  );
}
