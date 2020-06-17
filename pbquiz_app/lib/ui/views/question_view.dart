import 'package:flutter/material.dart';
import 'package:pbquiz_app/business_logic/view_models/quiz_viewmodel.dart';
import 'package:pbquiz_app/services/service_locator.dart';
import 'package:pbquiz_app/ui/views/quiz_result_view.dart';
import 'package:provider/provider.dart';

class QuestionView extends StatefulWidget {
  @override
  _QuestionState createState() => _QuestionState();
}

class _QuestionState extends State<QuestionView> {
  QuizViewModel model = serviceLocator<QuizViewModel>();

  @override
  void initState() {
    model.loadQuiz();
    super.initState();
  }

  Widget options(QuizViewModel model) {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: model.currentQuestion.optionList.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: 50,
          color: Theme.of(context).accentColor,
          child: ListTile(
            title: Text(
              '${model.currentQuestion.optionList[index].optionText}',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 20.0,
              ),
            ),
            trailing: (model.currentQuestion.optionList[index].selected)
                ? Icon(
                    Icons.check_box,
                    color: Colors.white,
                  )
                : Icon(
                    Icons.check_box_outline_blank,
                    color: Colors.white,
                  ),
            onTap: () {
              model.selectOption(index);
            },
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }

  Widget questionText(QuizViewModel model) {
    return Container(
      padding: const EdgeInsets.all(10),
      //height: 50,
      child: Text(
        '${model.questionText()}',
        softWrap: true,
        style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 20.0,
        ),
      ),
    );
  }

  Widget questionCount(QuizViewModel model) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Text(
        'Question ${model.attemptedQuestionCount()} / ${model.totalQuestionCount()}',
        softWrap: true,
        style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  Widget nextButton(QuizViewModel model) {
    RaisedButton button;
    if (model.lastQuestion()) {
      button = RaisedButton(
        child: Text("Submit"),
        color: Theme.of(context).primaryColor,
        textColor: Colors.white,
        onPressed: () {
          model.submit().then((success) {
            if (success) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => QuizResultView(
                            result: model.result,
                          )));
            }
          });
        },
      );
    } else {
      button = RaisedButton(
        child: Text("Next"),
        color: Theme.of(context).primaryColor,
        textColor: Colors.white,
        onPressed: () {
          model.displayNext();
        },
      );
    }
    return button;
  }

  Widget backButton(QuizViewModel model) {
    return RaisedButton(
      child: Text("Previous"),
      color: Theme.of(context).accentColor,
      textColor: Colors.white,
      onPressed: () {
        model.displayPrevious();
      },
    );
  }

  Widget buttonRow(QuizViewModel model) {
    List<Widget> buttons;
    if (model.firstQuestion()) {
      buttons = [
        nextButton(model),
      ];
    } else {
      buttons = [
        backButton(model),
        nextButton(model),
      ];
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: buttons,
    );
  }

  @override
  Widget build(BuildContext context) {
    //pr = new ProgressDialog(context);
    return ChangeNotifierProvider<QuizViewModel>(
      create: (context) => model,
      child: Consumer<QuizViewModel>(
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(title: Text('Todays Quiz')),
          body: buildQuestionView(context, model),
        ),
      ),
    );
  }

  Widget buildQuestionView(BuildContext context, QuizViewModel model) {
    if (model.loading()) {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: <Widget>[
            questionCount(model),
            questionText(model),
            Container(
              height: 300.0,
              child: options(model),
            ),
            buttonRow(model),
          ],
        ),
      );
    }
  }
}
