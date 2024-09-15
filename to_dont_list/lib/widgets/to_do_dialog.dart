import 'package:flutter/material.dart';

typedef ToDoListAddedCallback = Function(
  String nameValue, TextEditingController nameController,
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
  // Have to make controller for each text box
  // also cleaned the spacing a bit
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _gradeController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  final ButtonStyle yesStyle = ElevatedButton.styleFrom(
    textStyle: const TextStyle(fontSize: 20),
    backgroundColor: Colors.green,
  );
  
  final ButtonStyle noStyle = ElevatedButton.styleFrom(
    textStyle: const TextStyle(fontSize: 20),
    backgroundColor: Colors.red,
  );

  String nameValue = "";
  String gradeValue = "";
  String ageValue = "";

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Sheep'),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextField(
            // used in test
            key: const Key("nameField"),
            onChanged: (value) {
              setState(() {
                nameValue = value;
              });
            },
            controller: _nameController,
            decoration: const InputDecoration(hintText: "Enter name here"),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  key: const Key("gradeField"),
                  onChanged: (value) {
                    setState(() {
                      gradeValue = value.toUpperCase();
                    });
                  },
                  controller: _gradeController,
                  decoration: const InputDecoration(hintText: "Enter grade here"),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  key: const Key("ageField"),
                  onChanged: (value) {
                    setState(() {
                      ageValue = value;
                    });
                  },
                  controller: _ageController,
                  decoration: const InputDecoration(hintText: "Enter age here"),
                ),
              ),
            ],
          ),
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          key: const Key("Cancle"),
          style: noStyle,
          child: const Text('cancel'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        ValueListenableBuilder<TextEditingValue>(
          valueListenable: _nameController,
          builder: (context, value, child) {
            return ElevatedButton(
              key: const Key("OKButton"),
              style: yesStyle,
              onPressed: value.text.isNotEmpty
                  ? () {
                      setState(() {
                        widget.onListAdded(nameValue, _nameController, gradeValue, _gradeController, ageValue, _ageController);
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