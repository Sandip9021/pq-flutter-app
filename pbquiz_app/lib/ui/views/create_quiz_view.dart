import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pbquiz_app/business_logic/utils/constants.dart';
import 'package:pbquiz_app/business_logic/view_models/create_quiz_viewmodel.dart';
import 'package:pbquiz_app/ui/shared/ui_helper.dart';
import 'package:pbquiz_app/ui/views/base_view.dart';
import 'package:pbquiz_app/ui/widgets/custom_button.dart';
import 'package:pbquiz_app/ui/widgets/main_menu.dart';

class CreateQuizView extends StatefulWidget {
  @override
  _CreateQuizViewState createState() => _CreateQuizViewState();
}

class _CreateQuizViewState extends State<CreateQuizView> {
  final _createQuizformKey = GlobalKey<FormState>();
  String _quizName = '';
  String _quizDesc = '';
  DateTime _selectedDate = DateTime.now();
  final _textController = TextEditingController();
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked.toLocal();
        _textController.text = DateFormat('EEE d MMM').format(picked);
      });
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<CreateQuizViewModel>(
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Create quiz'),
            leading: BackButton(
              color: Colors.white,
              onPressed: () {
                showAlertDialog(context);
              },
            ),
          ),
          drawer: MainMenu(),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(5),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: createQuizForm(context, model),
            ),
          ),
        );
      },
    );
  }

  Widget createQuizForm(BuildContext context, CreateQuizViewModel model) {
    return Column(
      children: <Widget>[
        UIHelper.verticalSpaceMedium(),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            'Add a name and a short description to start',
            style: Theme.of(context).textTheme.headline2,
          ),
        ),
        UIHelper.verticalSpaceSmall(),
        Form(
          key: _createQuizformKey,
          child: Card(
            elevation: 5.0,
            color: Colors.white,
            shadowColor: Theme.of(context).primaryColor,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Quiz name',
                      labelStyle: Theme.of(context).textTheme.headline5,
                      border: null,
                      hintText: 'Enter name',
                    ),
                    validator: (val) => val.isEmpty ? "Enter name" : null,
                    onSaved: (val) => this._quizName = val,
                  ),
                  UIHelper.verticalSpaceSmall(),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Quiz description',
                      labelStyle: Theme.of(context).textTheme.headline5,
                      border: null,
                      hintText: 'Enter short descritpion',
                    ),
                    validator: (val) =>
                        val.isEmpty ? "Enter description" : null,
                    onSaved: (val) => this._quizName = val,
                    maxLines: 3,
                  ),
                  UIHelper.verticalSpaceSmall(),
                  TextFormField(
                    controller: _textController,
                    decoration: InputDecoration(
                      labelText: 'Quiz date',
                      labelStyle: Theme.of(context).textTheme.headline5,
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
                  ),
                  UIHelper.verticalSpaceLarge(),
                  UIHelper.verticalSpaceLarge(),
                  PrimaryButton(
                    title: 'Add question',
                    onPressed: () async {
                      if (_createQuizformKey.currentState.validate()) {
                        _createQuizformKey.currentState.save();

                        Navigator.pushNamed(context, addQuestionRoute,
                            arguments: [
                              this._quizName,
                              this._quizName,
                              this._selectedDate,
                            ]);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  showAlertDialog(BuildContext context) {
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
        Navigator.pushReplacementNamed(context, homeRoute);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Exit"),
      content: Text("Do you want to exit?"),
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
