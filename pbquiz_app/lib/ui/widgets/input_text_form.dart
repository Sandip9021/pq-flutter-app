import 'package:flutter/material.dart';

class InputTextFormField extends StatelessWidget {
  final String hintText;
  final Icon prefixIcon;
  final Function onSaved;
  final Function validator;
  InputTextFormField({
    @required this.hintText,
    this.prefixIcon,
    this.validator,
    this.onSaved,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: this.validator,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: this.hintText,
        prefixIcon: this.prefixIcon,
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        border: OutlineInputBorder(
          borderSide:
              BorderSide(color: Theme.of(context).primaryColor, width: 0.0),
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      onSaved: this.onSaved,
    );
  }
}

class InputPasswordFormField extends StatefulWidget {
  final Function onSaved;
  InputPasswordFormField({
    @required this.onSaved,
  });

  @override
  InputPasswordFormFieldState createState() => InputPasswordFormFieldState();
}

class InputPasswordFormFieldState extends State<InputPasswordFormField> {
  bool _isHidden = true;
  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        obscureText: _isHidden,
        validator: (val) => val.isEmpty ? "Enter password" : null,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          prefixIcon: Icon(Icons.lock),
          suffixIcon: IconButton(
              icon: _isHidden
                  ? Icon(Icons.visibility_off)
                  : Icon(Icons.visibility),
              onPressed: _toggleVisibility),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        onSaved: this.widget.onSaved);
  }
}
