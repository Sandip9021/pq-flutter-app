import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pbquiz_app/business_logic/view_models/create_quiz_viewmodel.dart';
import 'package:pbquiz_app/services/service_locator.dart';
import 'package:provider/provider.dart';

class CreateQuizView extends StatefulWidget {
  @override
  _CreateQuizViewState createState() => _CreateQuizViewState();
}

class _CreateQuizViewState extends State<CreateQuizView> {
  CreateQuizViewModel model = serviceLocator<CreateQuizViewModel>();
  final _createQuizformKey = GlobalKey<FormState>();
  final _addQuestionformKey = GlobalKey<FormState>();
  bool _addingQuestion = false;
  String _rightOption = '';
  TextStyle style =
      TextStyle(fontFamily: 'Roboto', fontSize: 16.0, color: Colors.blue[600]);

  DateTime selectedDate = DateTime.now();
  final _textController = TextEditingController();
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked.toLocal();
        _textController.text = DateFormat('EEE d MMM').format(picked);
      });
  }

  bool _isRightOption(String option) {
    return _rightOption == option ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CreateQuizViewModel>(
      create: (context) => model,
      child: Consumer<CreateQuizViewModel>(
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: _addingQuestion ? Text('Add question') : Text('Create quiz'),
            actions: <Widget>[
              FlatButton(
                onPressed: () async {
                  if (_addQuestionformKey.currentState.validate()) {
                    _addQuestionformKey.currentState.save();
                    model.rightOption = _rightOption;
                    model.submitQuiz();
                    _rightOption = '';
                    _addQuestionformKey.currentState.reset();
                  }
                },
                child: Text('Submit'),
              )
            ],
          ),
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.all(10),
            child: buildForm(context),
          ),
        ),
      ),
    );
  }

  Widget buildForm(BuildContext context) {
    Widget form = _addingQuestion ? addQuestionForm() : createQuizForm();
    return form;
  }

  Widget createQuizForm() {
    return Form(
      key: _createQuizformKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Quiz name',
              border: null,
              hintText: 'Enter name',
            ),
            validator: (val) => val.isEmpty ? "Enter name" : null,
            onSaved: (val) => model.quizName = val,
          ),
          SizedBox(
            height: 20.0,
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Quiz description',
              border: null,
              hintText: 'Enter short descritpion',
            ),
            validator: (val) => val.isEmpty ? "Enter description" : null,
            onSaved: (val) => model.quizDescription = val,
          ),
          SizedBox(
            height: 20.0,
          ),
          TextFormField(
            controller: _textController,
            decoration: InputDecoration(
              labelText: 'Quiz date',
              border: null,
              hintText: 'Select a date',
              suffixIcon: Icon(
                Icons.calendar_today,
                color: Colors.blue[600],
              ),
            ),
            onTap: () async {
              FocusScope.of(context).requestFocus(new FocusNode());
              _selectDate(context);
            },
            validator: (val) => val.isEmpty ? "Select date" : null,
            onSaved: (val) => model.scheduledDate = selectedDate,
          ),
          SizedBox(
            height: 40.0,
          ),
          Row(
            children: <Widget>[
              RaisedButton(
                onPressed: () async {
                  if (_createQuizformKey.currentState.validate()) {
                    _createQuizformKey.currentState.save();
                    model.createQuiz();
                    _createQuizformKey.currentState.reset();
                    setState(() {
                      _addingQuestion = true;
                    });
                  }
                },
                child: Text('Add question'),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget addQuestionForm() {
    return Form(
      key: _addQuestionformKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Question',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(4.0)),
              hintText: 'Enter a question',
            ),
            validator: (val) => val.isEmpty ? "Enter question" : null,
            onSaved: (val) => model.questionText = val,
            keyboardType: TextInputType.multiline,
          ),
          SizedBox(height: 20.0),
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
                    // _selectedA = true;
                    // _selectedB = false;
                    // _selectedC = false;
                    // _selectedD = false;
                  });
                },
              ),
            ),
            validator: (val) => val.isEmpty ? "Enter option" : null,
            onSaved: (val) => model.optionA = val,
          ),
          SizedBox(height: 10.0),
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
                    _rightOption = 'a';
                    // _selectedA = false;
                    // _selectedB = true;
                    // _selectedC = false;
                    // _selectedD = false;
                  });
                },
              ),
            ),
            validator: (val) => val.isEmpty ? "Enter option" : null,
            onSaved: (val) => model.optionB = val,
          ),
          SizedBox(height: 10.0),
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
                    // _selectedA = false;
                    // _selectedB = false;
                    // _selectedC = true;
                    // _selectedD = false;
                  });
                },
              ),
            ),
            validator: (val) => val.isEmpty ? "Enter option" : null,
            onSaved: (val) => model.optionC = val,
          ),
          SizedBox(height: 10.0),
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
                    // _selectedA = false;
                    // _selectedB = false;
                    // _selectedC = false;
                    // _selectedD = true;
                  });
                },
              ),
            ),
            validator: (val) => val.isEmpty ? "Enter option" : null,
            onSaved: (val) => model.optionD = val,
          ),
          RaisedButton(
            child: Text('Next'),
            onPressed: () async {
              if (_addQuestionformKey.currentState.validate()) {
                _addQuestionformKey.currentState.save();
                model.rightOption = _rightOption;
                model.nextQuestion();
                _rightOption = '';
                _addQuestionformKey.currentState.reset();
              }
            },
          )
        ],
      ),
    );
  }
}
