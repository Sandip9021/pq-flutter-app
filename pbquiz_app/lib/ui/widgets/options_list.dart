import 'package:flutter/material.dart';
import 'package:pbquiz_app/ui/widgets/option_item.dart';

class OptionList extends StatefulWidget {
  final List<String> list;
  const OptionList({this.list});
  @override
  _OptionListState createState() => _OptionListState();
}

class _OptionListState extends State<OptionList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.all(8),
        itemCount: widget.list.length,
        itemBuilder: (BuildContext context, int index) {
          return OptionItem(
            optionText: widget.list[index],
          );
        },
      ),
    );
  }
}
