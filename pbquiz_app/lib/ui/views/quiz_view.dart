import 'package:flutter/material.dart';
import 'package:pbquiz_app/business_logic/utils/constants.dart';
import 'package:pbquiz_app/business_logic/view_models/base_viewmodel.dart';
import 'package:pbquiz_app/business_logic/view_models/quiz_viewmodel.dart';
import 'package:pbquiz_app/ui/shared/ui_helper.dart';
import 'package:pbquiz_app/ui/views/base_view.dart';
import 'package:pbquiz_app/ui/widgets/custom_button.dart';
import 'package:pbquiz_app/ui/widgets/options_list.dart';
import 'package:pbquiz_app/ui/widgets/quiz_progress.dart';

class QuizView extends StatefulWidget {
  final String quizId;
  QuizView({Key key, @required this.quizId}) : super(key: key);
  @override
  _QuizViewState createState() => _QuizViewState();
}

class _QuizViewState extends State<QuizView> {
  @override
  Widget build(BuildContext context) {
    return BaseView<QuizViewModel>(
      onModelReady: (model) => model.loadQuiz(this.widget.quizId),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text('Quiz'),
          leading: BackButton(
            color: Colors.white,
            onPressed: () {
              showAlertDialog(context, model);
            },
          ),
        ),
        body: model.state == ViewState.Busy
            ? Center(child: CircularProgressIndicator())
            : Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    QuizProgressIndicator(
                      currentQuestion: model.attemptedQuestionCount(),
                      totalQuestions: model.totalQuestionCount(),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 10.0),
                      child: Text(
                        '${model.currentQuestion.questionText}',
                        softWrap: true,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    OptionList(
                      list: model.currentQuestion.optionList,
                      selectedOption: model.selectedOption(),
                      onSelection: (value) {
                        model.changeSelectedOption(value);
                      },
                    ),
                    UIHelper.verticalSpaceLarge(),
                    PrimaryButton(
                      title: 'Submit',
                      onPressed: () {
                        if (model.lastQuestion()) {
                          model.submit().then(
                            (success) {
                              Navigator.pushReplacementNamed(
                                context,
                                quizResultRoute,
                                arguments: success
                                    ? model.result.totalScore
                                    : 'You have already submitted this once!',
                              );
                            },
                          );
                        } else {
                          model.displayNext();
                        }
                      },
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  showAlertDialog(BuildContext context, QuizViewModel model) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Continue"),
      onPressed: () {
        model.submit().then(
          (success) {
            Navigator.pushReplacementNamed(
              context,
              quizResultRoute,
              arguments: success
                  ? model.result.totalScore
                  : 'You have already submitted this once!',
            );
          },
        );
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Exit"),
      content: Text("Your attempt will be recorder. Do you want to exit?"),
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
