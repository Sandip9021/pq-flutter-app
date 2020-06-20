import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class QuizProgressIndicator extends StatelessWidget {
  final int totalQuestions;
  final int currentQuestion;
  QuizProgressIndicator({this.currentQuestion, this.totalQuestions});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            'Question $currentQuestion of $totalQuestions',
            softWrap: true,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          SizedBox(
            height: 20.0,
          ),
          LinearPercentIndicator(
              width: MediaQuery.of(context).size.width - 50,
              lineHeight: 3.0,
              percent: currentQuestion / totalQuestions,
              backgroundColor: Theme.of(context).primaryColorLight,
              progressColor: Theme.of(context).primaryColor),
        ],
      ),
    );
  }
}
