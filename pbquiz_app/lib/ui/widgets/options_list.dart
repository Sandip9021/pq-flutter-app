import 'package:flutter/material.dart';
import 'package:pbquiz_app/business_logic/models/quiz.dart';

class OptionList extends StatelessWidget {
  final List<Option> list;
  final String selectedOption;
  final Function(String) onSelection;
  const OptionList({
    this.list,
    this.selectedOption,
    this.onSelection,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.all(8),
        itemCount: this.list.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            elevation: this.list[index].selected ? 5.0 : 1.0,
            shadowColor: Theme.of(context).primaryColor,
            child: RadioListTile<String>(
              title: Text(
                '${this.list[index].optionText}',
              ),
              value: this.list[index].optionId,
              groupValue: this.selectedOption,
              onChanged: (value) => this.onSelection(value),
              selected: this.list[index].selected,
            ),
          );
        },
      ),
    );
  }
}
