import 'package:flutter/material.dart';
import 'package:pbquiz_app/ui/views/home_view.dart';
import 'package:pbquiz_app/ui/views/signup_view.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  String email, password;
  bool _loading = false;

  bool _isHidden = true;

  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loading
          ? Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Stack(children: <Widget>[
                  Container(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Center(
                            child: Image.asset("assets/quiz_icon_small.png",
                                height: 30,
                                width: 30,
                                alignment: Alignment.center),
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
                              margin: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 45),
                              child: Column(
                                children: <Widget>[
                                  TextFormField(
                                    validator: (val) =>
                                        val.isEmpty ? "Enter email" : null,
                                    decoration: InputDecoration(
                                      hintText: "Email",
                                      prefixIcon: Icon(Icons.email),
                                    ),
                                  ),
                                  TextFormField(
                                    obscureText: true,
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
                                  ),
                                  SizedBox(height: 20),
                                  RaisedButton(
                                    color: Colors.red,
                                    textColor: Colors.white,
                                    onPressed: () {
                                      // Validate returns true if the form is valid, otherwise false.
                                      if (_formKey.currentState.validate()) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HomeView()));
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
                ]),
              ),
            ),
    );
  }
}
