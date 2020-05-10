import 'package:flutter/material.dart';

class Question extends StatefulWidget {
  @override
  _QuestionState createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  final List<String> entries = <String>['A', 'B', 'C', 'D'];
  final List<int> colorCodes = <int>[600, 500, 300, 100];
  String _selectedValue;
  Widget question() {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: entries.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: 50,
          color: Colors.amber[colorCodes[index]],
          child: ListTile(
            title: Text('Option ${entries[index]}'),
            leading: Radio(
                value: entries[index],
                groupValue: _selectedValue,
                onChanged: (val) {
                  setState(() {
                    _selectedValue = val;
                  });
                }),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }

  Widget questionText = Container(
    padding: const EdgeInsets.all(30),
    child: Text(
      'Question text goes here, what is the question?',
      softWrap: true,
    ),
  );

  @override
  Widget build(BuildContext context) {
    Widget options = question();
    return Scaffold(
      appBar: AppBar(title: Text("Quiz 1")),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: <Widget>[
            questionText,
            Container(
              height: 300.0,
              child: options,
            ),
            RaisedButton(
              child: Text("Next"),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
