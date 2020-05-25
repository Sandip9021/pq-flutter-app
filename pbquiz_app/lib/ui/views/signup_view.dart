import 'package:flutter/material.dart';
import 'package:pbquiz_app/business_logic/view_models/signup_viewmodel.dart';
import 'package:pbquiz_app/services/service_locator.dart';
import 'package:pbquiz_app/ui/views/home_view.dart';
import 'package:pbquiz_app/ui/widgets/app_title.dart';
import 'package:progress_dialog/progress_dialog.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  SignUpViewModel model = serviceLocator<SignUpViewModel>();
  final _formKey = GlobalKey<FormState>();
  TextStyle style =
      TextStyle(fontFamily: 'Roboto', fontSize: 20.0, color: Colors.blue[600]);
  ProgressDialog pr;
  //String name, email, password;
  bool _isHidden = true;

  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Container(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  AppTitle(),
                  Text(
                    "Create an account to join",
                    textAlign: TextAlign.center,
                    style: style.copyWith(color: Colors.blue, fontSize: 14.0),
                  ),
                  SizedBox(height: 20),
                  signUpForm(),
                  signInOption(),
                ]),
          ),
        ),
      ),
    );
  }

  Future<void> cantSignUpDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sign Up failed!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Account already exists!'),
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

  Widget signUpForm() {
    final signUpButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          // Validate returns true if the form is valid, otherwise false.
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            pr.show();
            bool signUpSuccess = await model.signUp();
            pr.hide().then(
              (value) {
                if (signUpSuccess) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeView()));
                } else {
                  cantSignUpDialog(context);
                }
              },
            );
          }
        },
        child: Text("Sign Up",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
    return Form(
      key: _formKey,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 45),
        child: Column(
          children: <Widget>[
            TextFormField(
              validator: (val) => val.isEmpty ? "Enter name" : null,
              decoration: InputDecoration(
                hintText: "Name",
                prefixIcon: Icon(Icons.account_circle),
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
              ),
              onSaved: (val) => model.setName(val),
            ),
            SizedBox(height: 10),
            TextFormField(
              validator: (val) => val.isEmpty ? "Enter email" : null,
              decoration: InputDecoration(
                hintText: "Email",
                prefixIcon: Icon(Icons.email),
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
              ),
              onSaved: (val) => model.setEmail(val),
            ),
            SizedBox(height: 10),
            TextFormField(
              obscureText: _isHidden,
              validator: (val) => val.isEmpty ? "Enter password" : null,
              decoration: InputDecoration(
                hintText: "Password",
                prefixIcon: Icon(Icons.lock),
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0)),
                suffixIcon: IconButton(
                    icon: _isHidden
                        ? Icon(Icons.visibility_off)
                        : Icon(Icons.visibility),
                    onPressed: _toggleVisibility),
              ),
              onSaved: (val) => model.setPassword(val),
            ),
            SizedBox(height: 20),
            signUpButton,
          ],
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
        Text("Already have an account?"),
        FlatButton(
          //color: Colors.blue,
          textColor: Colors.blue,
          disabledColor: Colors.grey,
          disabledTextColor: Colors.black,
          padding: EdgeInsets.all(8.0),
          splashColor: Colors.blueAccent,
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            "Sign in",
            style: TextStyle(fontSize: 20.0),
          ),
        )
      ],
    );
  }
}
