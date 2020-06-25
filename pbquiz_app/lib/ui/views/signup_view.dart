import 'package:flutter/material.dart';
import 'package:pbquiz_app/business_logic/utils/constants.dart';
import 'package:pbquiz_app/business_logic/view_models/base_viewmodel.dart';
import 'package:pbquiz_app/business_logic/view_models/signup_viewmodel.dart';
import 'package:pbquiz_app/ui/shared/ui_helper.dart';
import 'package:pbquiz_app/ui/views/base_view.dart';
import 'package:pbquiz_app/ui/views/home_view.dart';
import 'package:pbquiz_app/ui/widgets/app_title.dart';
import 'package:pbquiz_app/ui/widgets/custom_button.dart';
import 'package:pbquiz_app/ui/widgets/input_text_form.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  bool _isSignUp = false;

  void _toggleForm() {
    _formKey.currentState.reset();
    setState(() {
      this._isSignUp = !this._isSignUp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<SignUpViewModel>(
      builder: (context, model, child) => Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AppTitle(),
            Text(
              this._isSignUp
                  ? "Create an account to join"
                  : "Hi there! Nice to see you again.",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            UIHelper.verticalSpaceSmall(),
            signUpForm(model),
            model.state == ViewState.Busy
                ? CircularProgressIndicator()
                : Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: PrimaryButton(
                      title: this._isSignUp ? "Sign up" : "Sign in",
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          bool success = await model.submit(this._isSignUp);
                          if (success) {
                            Navigator.pushNamed(context, homeRoute);
                          } else {
                            cantSignUpDialog(context);
                          }
                        }
                      },
                    ),
                  ),
            signInOption(),
          ],
        ),
      ),
    );
  }

  Widget signUpForm(SignUpViewModel model) {
    final nameTextFormField = InputTextFormField(
      hintText: "Name",
      prefixIcon: Icon(Icons.account_circle),
      validator: (val) => val.isEmpty ? "Enter email" : null,
      onSaved: (val) => model.setName(val),
    );

    final emailTextFormField = InputTextFormField(
      hintText: "Email",
      prefixIcon: Icon(Icons.email),
      validator: (val) => val.isEmpty ? "Enter email" : null,
      onSaved: (val) => model.setEmail(val),
    );

    final passwordTextFormField = InputPasswordFormField(
      onSaved: (val) => model.setPassword(val),
    );

    final signUpFormFields = <Widget>[
      nameTextFormField,
      SizedBox(height: 10),
      emailTextFormField,
      SizedBox(height: 10),
      passwordTextFormField,
    ];
    final signInFormFields = <Widget>[
      emailTextFormField,
      SizedBox(height: 10),
      passwordTextFormField,
    ];
    return Form(
      key: _formKey,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          children: this._isSignUp ? signUpFormFields : signInFormFields,
        ),
      ),
    );
  }

  Widget signInOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
            this._isSignUp
                ? "Already have an account?"
                : "Don't have an account?",
            style: Theme.of(context).textTheme.bodyText1),
        FlatButton(
          //color: Colors.blue,
          textColor: Theme.of(context).primaryColor,
          padding: EdgeInsets.all(8.0),
          splashColor: Theme.of(context).accentColor,
          onPressed: () {
            _toggleForm();
          },
          child: Text(
            this._isSignUp ? "Sign in" : "Sign up",
            style: TextStyle(
              fontSize: 16.0,
              fontFamily: 'Roboto',
            ),
          ),
        )
      ],
    );
  }

  Future<void> cantSignUpDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Snap! Something went wrong!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(this._isSignUp ? 'Sign up failed!' : 'Sign in failed!'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
