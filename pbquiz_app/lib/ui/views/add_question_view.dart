import 'package:flutter/material.dart';
import 'package:pbquiz_app/business_logic/models/quiz.dart';
import 'package:pbquiz_app/business_logic/models/user.dart';
import 'package:pbquiz_app/business_logic/utils/constants.dart';
import 'package:pbquiz_app/business_logic/view_models/create_quiz_viewmodel.dart';
import 'package:pbquiz_app/ui/shared/ui_helper.dart';
import 'package:pbquiz_app/ui/views/base_view.dart';
import 'package:pbquiz_app/ui/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class AddQuestionView extends StatefulWidget {
  final String quizName;
  final String quizDesc;
  final DateTime scheduledDate;
  AddQuestionView({
    Key key,
    @required this.quizName,
    @required this.quizDesc,
    @required this.scheduledDate,
  }) : super(key: key);

  @override
  _AddQuestionViewState createState() => _AddQuestionViewState();
}

class _AddQuestionViewState extends State<AddQuestionView> {
  final _addQuestionformKey = GlobalKey<FormState>();
  String _rightOption = '';
  bool _isRightOption(String option) {
    return _rightOption == option ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<CreateQuizViewModel>(
      onModelReady: (model) => model.createQuiz(
          this.widget.quizName,
          this.widget.quizDesc,
          this.widget.scheduledDate,
          Provider.of<User>(context).userId),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text('Add question'),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(5),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: addQuestionForm(context, model),
          ),
        ),
      ),
    );
  }

  Widget addQuestionForm(BuildContext context, CreateQuizViewModel model) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            'Adding question to ${this.widget.quizName}',
            style: Theme.of(context).textTheme.headline2,
          ),
        ),
        Form(
          key: _addQuestionformKey,
          child: Card(
            elevation: 5.0,
            color: Colors.white,
            shadowColor: Theme.of(context).primaryColor,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Question',
                      border: null,
                      hintText: 'Enter a question',
                    ),
                    validator: (val) => val.isEmpty ? "Enter question" : null,
                    onSaved: (val) => model.questionText = val,
                    keyboardType: TextInputType.multiline,
                    maxLines: 2,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Option A',
                      border: null,
                      hintText: 'Enter option',
                      suffixIcon: IconButton(
                        icon: _isRightOption('a')
                            ? Icon(Icons.check_box)
                            : Icon(Icons.check_box_outline_blank),
                        onPressed: () {
                          setState(() {
                            _rightOption = 'a';
                          });
                        },
                      ),
                    ),
                    validator: (val) => val.isEmpty ? "Enter option" : null,
                    onSaved: (val) => model.optionA = val,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Option B',
                      border: null,
                      hintText: 'Enter option',
                      suffixIcon: IconButton(
                        icon: _isRightOption('b')
                            ? Icon(Icons.check_box)
                            : Icon(Icons.check_box_outline_blank),
                        onPressed: () {
                          setState(() {
                            _rightOption = 'b';
                          });
                        },
                      ),
                    ),
                    validator: (val) => val.isEmpty ? "Enter option" : null,
                    onSaved: (val) => model.optionB = val,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Option C',
                      border: null,
                      hintText: 'Enter option',
                      suffixIcon: IconButton(
                        icon: _isRightOption('c')
                            ? Icon(Icons.check_box)
                            : Icon(Icons.check_box_outline_blank),
                        onPressed: () {
                          setState(() {
                            _rightOption = 'c';
                          });
                        },
                      ),
                    ),
                    validator: (val) => val.isEmpty ? "Enter option" : null,
                    onSaved: (val) => model.optionC = val,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Option D',
                      border: null,
                      hintText: 'Enter option',
                      suffixIcon: IconButton(
                        icon: _isRightOption('d')
                            ? Icon(Icons.check_box)
                            : Icon(Icons.check_box_outline_blank),
                        onPressed: () {
                          setState(() {
                            _rightOption = 'd';
                          });
                        },
                      ),
                    ),
                    validator: (val) => val.isEmpty ? "Enter option" : null,
                    onSaved: (val) => model.optionD = val,
                  ),
                  UIHelper.verticalSpaceSmall(),
                  PrimaryButton(
                    title: 'Add more',
                    onPressed: () async {
                      if (_addQuestionformKey.currentState.validate()) {
                        _addQuestionformKey.currentState.save();
                        model.rightOption = _rightOption;
                        model.addQuestion();
                        _rightOption = '';
                        _addQuestionformKey.currentState.reset();
                        model.nextQuestion();
                      }
                    },
                  ),
                  UIHelper.verticalSpaceSmall(),
                  SecondaryButton(
                    title: 'Submit',
                    onPressed: () async {
                      if (_addQuestionformKey.currentState.validate()) {
                        _addQuestionformKey.currentState.save();
                        model.rightOption = _rightOption;
                        var success = await model.submitQuiz();
                        if (success) {}
                        _rightOption = '';
                        _addQuestionformKey.currentState.reset();
                        Navigator.pushNamed(context, homeRoute);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
