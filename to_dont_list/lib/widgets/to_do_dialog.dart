import 'package:flutter/material.dart';

typedef ToDoListAddedCallback = Function(
    String value, TextEditingController nameController,
    String gradeValue, TextEditingController gradeController,
    String ageValue, TextEditingController ageController);

class ToDoDialog extends StatefulWidget {
  const ToDoDialog({
    super.key,
    required this.onListAdded,
  });

  final ToDoListAddedCallback onListAdded;

  @override
  State<ToDoDialog> createState() => _ToDoDialogState();
}

class _ToDoDialogState extends State<ToDoDialog> {
  // Dialog with text from https://www.appsdeveloperblog.com/alert-dialog-with-a-text-field-in-flutter/
  final TextEditingController _nameinputController = TextEditingController();
  final TextEditingController _gradeinputController = TextEditingController();
  final TextEditingController _ageinputController = TextEditingController();
  final ButtonStyle yesStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20), backgroundColor: Colors.green);
  final ButtonStyle noStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20), backgroundColor: Colors.red);

  String valueText = "";
  
  String gradeText = "";

  String ageText = "";

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Sheep'),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [TextField(
        onChanged: (value) {
          setState(() {
            valueText = value;
          });
        },
        controller: _nameinputController,
        decoration: const InputDecoration(hintText: "Name"),
      ),
      Row(children: [TextField(
        onChanged: (gradeValue) {
          setState(() {
            gradeText = gradeValue.toUpperCase();
          });
        },
        controller: _gradeinputController,
        decoration: const InputDecoration(hintText: "Grade"),
        ),
        TextField(
          onChanged: (ageValue) {
            setState(() {
              ageText = ageValue;
            });
          },
        controller: _ageinputController,
        decoration: const InputDecoration(hintText: "Age"),
        )],)]),
      actions: <Widget>[
        ElevatedButton(
          key: const Key("Cancle"),
          style: noStyle,
          child: const Text('cancle'),
          onPressed: () {
            setState(() {
              Navigator.pop(context);
            });
          },
        ),

        // https://stackoverflow.com/questions/52468987/how-to-turn-disabled-button-into-enabled-button-depending-on-conditions
        ValueListenableBuilder<TextEditingValue>(
          valueListenable: _nameinputController,
          builder: (context, value, child) {
            return ElevatedButton(
              key: const Key("OKButton"),
              style: yesStyle,
              onPressed: value.text.isNotEmpty
                  ? () {
                      setState(() {
                        widget.onListAdded(valueText, _nameinputController, gradeText, _gradeinputController, ageText, _ageinputController);
                        Navigator.pop(context);
                      });
                    }
                  : null,
              child: const Text('ok'),
            );
          },
        ),
      ],
    );
  }
}
