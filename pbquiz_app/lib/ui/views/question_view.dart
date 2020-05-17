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
          color: Colors.blue[100],
          child: ListTile(
            title:
                Text('${model.currentQuestion.optionList[index].optionText}'),
            leading: Radio(
              value: model.currentQuestion.optionList[index].optionId,
              groupValue: model.selectedOptionId,
              onChanged: (val) {
                setState(() {
                  model.selectedOptionId = val;
                });
              },
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }

  Widget questionText(QuizViewModel model) {
    return Container(
      padding: const EdgeInsets.all(30),
      child: Text(
        '${model.questionText()}',
        softWrap: true,
      ),
    );
  }

  Widget button(QuizViewModel model) {
    RaisedButton button;
    if (model.lastQuestion()) {
      button = RaisedButton(
        child: Text("Submit"),
        onPressed: () {
          model.submit();
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => QuizResultView()));
        },
      );
    } else {
      button = RaisedButton(
        child: Text("Next"),
        onPressed: () {
          model.displayNext();
        },
      );
    }
    return button;
  }

  @override
  Widget build(BuildContext context) {
    //Widget optionsList = options(model);
    return ChangeNotifierProvider<QuizViewModel>(
      create: (context) => model,
      child: Consumer<QuizViewModel>(
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
              title: Text(
                  "Question ${model.attemptedQuestionCount()} / ${model.totalQuestionCount()}")),
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: <Widget>[
                questionText(model),
                Container(
                  height: 300.0,
                  child: options(model),
                ),
                button(model),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
