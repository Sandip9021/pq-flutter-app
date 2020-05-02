import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  String email, password;
  bool _loading = false;

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
                        width: double.infinity,
                        height: double.infinity,
                        child: Image.asset(
                          "quiz.png",
                          fit: BoxFit.fill,
                        ),
                      ),
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
                                style: GoogleFonts.roboto(),
                              ),
                              SizedBox(height: 30),
                              Text("Create an account to join",
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
                                            val.isEmpty ? "Enter name" : null,
                                        decoration:
                                            InputDecoration(hintText: "Name"),
                                      ),
                                      TextFormField(
                                        validator: (val) =>
                                            val.isEmpty ? "Enter email" : null,
                                        decoration:
                                            InputDecoration(hintText: "Email"),
                                      ),
                                      TextFormField(
                                        obscureText: true,
                                        validator: (val) => val.isEmpty
                                            ? "Enter password"
                                            : null,
                                        decoration: InputDecoration(
                                            hintText: "Password"),
                                      ),
                                      TextFormField(
                                        obscureText: true,
                                        validator: (val) => val.isEmpty
                                            ? "Retype password"
                                            : null,
                                        decoration: InputDecoration(
                                            hintText: "Confirm Password"),
                                      ),
                                      SizedBox(height: 20),
                                      RaisedButton(
                                        color: Color.blue,
                                        onPressed: () {
                                          // Validate returns true if the form is valid, otherwise false.
                                          if (_formKey.currentState
                                              .validate()) {
                                            Scaffold.of(context).showSnackBar(
                                                SnackBar(
                                                    content: Text(
                                                        'Processing Data')));
                                          }
                                        },
                                        child: const Text('Sign Up',
                                            style: TextStyle(fontSize: 20)),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ]),
                      ),
                    ])),
              ));
  }
}
