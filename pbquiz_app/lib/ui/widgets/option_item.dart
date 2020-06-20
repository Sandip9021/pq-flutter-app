import 'package:flutter/material.dart';

class OptionItem extends StatefulWidget {
  final String optionText;
  final String optionID;
  const OptionItem({this.optionID, this.optionText});
  @override
  _OptionItemState createState() => _OptionItemState();
}

class _OptionItemState extends State<OptionItem> {
  bool _selected = false;

  void toggleSelected() {
    setState(() {
      _selected = !_selected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: _selected ? Colors.indigo[50] : Colors.white,
      elevation: _selected ? 5.0 : 3.0,
      shadowColor: Theme.of(context).primaryColorLight,
      child: ListTile(
        leading: _selected
            ? Icon(
                Icons.check_box,
                color: Theme.of(context).primaryColor,
              )
            : Icon(
                Icons.check_box_outline_blank,
                color: Theme.of(context).primaryColor,
              ),
        title: Text(
          widget.optionText,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        onTap: () {
          toggleSelected();
        },
      ),
    );
  }
}
