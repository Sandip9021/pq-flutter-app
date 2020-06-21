import 'package:flutter/material.dart';
import 'package:pbquiz_app/business_logic/models/quiz.dart';
import 'package:pbquiz_app/ui/shared/ui_helper.dart';
import 'package:pbquiz_app/ui/views/quiz_view.dart';
import 'package:pbquiz_app/ui/widgets/custom_button.dart';

class QuizStartView extends StatelessWidget {
  final Quiz quiz;
  QuizStartView({Key key, @required this.quiz}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Start Quiz"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            UIHelper.verticalSpaceLarge(),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                'Joining ${this.quiz.quizName}!!',
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text('Read the rules carefully...',
                  style: Theme.of(context).textTheme.bodyText1),
            ),
            UIHelper.verticalSpaceLarge(),
            Container(
              padding: const EdgeInsets.all(10),
              child: Text(
                'Never break the rules. '
                'Every question has 3 wrong options and only 1 right option.  '
                'There is no penalty for wrong answer, '
                'but if you give a right answer within 5 seconds, '
                'you would get bonous points. ',
                softWrap: true,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(90.0, 200.0, 90.0, 20),
              child: PrimaryButton(
                title: 'Start quiz',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuizView(
                        quizId: this.quiz.quizId,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
