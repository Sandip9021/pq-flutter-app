import 'package:flutter/material.dart';
import 'package:pbquiz_app/business_logic/view_models/signup_viewmodel.dart';
import 'package:pbquiz_app/services/service_locator.dart';
import 'package:pbquiz_app/ui/views/home_view.dart';
import 'package:progress_dialog/progress_dialog.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  SignUpViewModel model = serviceLocator<SignUpViewModel>();
  final _formKey = GlobalKey<FormState>();
  ProgressDialog pr;
  String name, email, password;
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
                  Center(
                    child: Image.asset("assets/quiz_icon_small.png",
                        height: 30, width: 30, alignment: Alignment.center),
                  ),
                  SizedBox(height: 30),
                  Text(
                    "PUB QUIZ",
                  ),
                  SizedBox(height: 30),
                  Text("Create an account to join",
                      textAlign: TextAlign.center),
                  Form(
                    key: _formKey,
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 45),
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            validator: (val) =>
                                val.isEmpty ? "Enter name" : null,
                            decoration: InputDecoration(
                              hintText: "Name",
                              prefixIcon: Icon(Icons.account_circle),
                            ),
                            onSaved: (val) => name = val,
                          ),
                          TextFormField(
                            validator: (val) =>
                                val.isEmpty ? "Enter email" : null,
                            decoration: InputDecoration(
                              hintText: "Email",
                              prefixIcon: Icon(Icons.email),
                            ),
                            onSaved: (val) => email = val,
                          ),
                          TextFormField(
                            obscureText: _isHidden,
                            validator: (val) =>
                                val.isEmpty ? "Enter password" : null,
                            decoration: InputDecoration(
                              hintText: "Password",
                              prefixIcon: Icon(Icons.lock),
                              suffixIcon: IconButton(
                                  icon: _isHidden
                                      ? Icon(Icons.visibility_off)
                                      : Icon(Icons.visibility),
                                  onPressed: _toggleVisibility),
                            ),
                            onSaved: (val) => val = password,
                          ),
                          SizedBox(height: 20),
                          RaisedButton(
                            color: Colors.red,
                            textColor: Colors.white,
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                pr.show();
                                var signUpSuccess =
                                    await model.signUp(name, email, password);
                                pr.hide().then((value) {
                                  if (signUpSuccess) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HomeView()));
                                  } else {
                                    cantSignUpDialog(context);
                                  }
                                });
                              }
                            },
                            child: const Text('Sign Up',
                                style: TextStyle(fontSize: 20)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
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
                  ),
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
}
