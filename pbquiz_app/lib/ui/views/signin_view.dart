import 'package:flutter/material.dart';
import 'package:pbquiz_app/business_logic/view_models/signin_viewmodel.dart';
import 'package:pbquiz_app/services/service_locator.dart';
import 'package:pbquiz_app/ui/views/home_view.dart';
import 'package:pbquiz_app/ui/views/signup_view.dart';
import 'package:progress_dialog/progress_dialog.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  SignInViewModel model = serviceLocator<SignInViewModel>();
  final _formKey = GlobalKey<FormState>();

  ProgressDialog pr;
  String email, password;
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
                  Text("Hi there! Nice to see you again.",
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
                            onSaved: (val) => password = val,
                          ),
                          SizedBox(height: 20),
                          RaisedButton(
                            color: Colors.red,
                            textColor: Colors.white,
                            onPressed: () async {
                              // Validate returns true if the form is valid, otherwise false.
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                pr.show();
                                var signInSuccess =
                                    await model.signIn(email, password);
                                pr.hide().then((value) {
                                  if (signInSuccess) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HomeView()));
                                  } else {
                                    cantSignInDialog(context);
                                  }
                                });
                              }
                            },
                            child: const Text('Sign In',
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
                      Text("Don't have an account?"),
                      FlatButton(
                        //color: Colors.blue,
                        textColor: Colors.blue,
                        disabledColor: Colors.grey,
                        disabledTextColor: Colors.black,
                        padding: EdgeInsets.all(8.0),
                        splashColor: Colors.blueAccent,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUp()));
                        },
                        child: Text(
                          "Sign Up",
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

  Future<void> cantSignInDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sign in failed!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Incorrect email or password'),
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
