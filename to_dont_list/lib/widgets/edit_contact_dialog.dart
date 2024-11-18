import 'package:flutter/material.dart';
import 'package:to_dont_list/objects/contact.dart';

typedef OnItemAltered = Function(
    Contact contact,
    TextEditingController first_controller,
    TextEditingController last_controller,
    TextEditingController number_controller);

class EditContactDialog extends StatefulWidget {
  OnItemAltered onItemAltered;
  Contact contact;
  EditContactDialog(
      {super.key, required this.contact, required this.onItemAltered});

  @override
  State<EditContactDialog> createState() => EditContactDialogState();
}

class EditContactDialogState extends State<EditContactDialog> {
  // Dialog with text from https://www.appsdeveloperblog.com/alert-dialog-with-a-text-field-in-flutter/
  final TextEditingController _firstController = TextEditingController();
  final TextEditingController _lastController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final ButtonStyle yesStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20), backgroundColor: Colors.green);
  final ButtonStyle noStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20), backgroundColor: Colors.red);

  String valueText = "";
  @override
  void initState() {
    super.initState();
    _firstController.text = widget.contact.first_name;
    _lastController.text = widget.contact.last_name;
    _numberController.text = widget.contact.number;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Contact'),
      content: Column(
        children: [
          TextField(
            onChanged: (value) {
              setState(() {
                valueText = value;
              });
            },
            controller: _firstController,
          ),
          TextField(
            onChanged: (value) {
              setState(() {
                valueText = value;
              });
            },
            controller: _lastController,
          ),
          TextField(
            onChanged: (value) {
              setState(() {
                valueText = value;
              });
            },
            controller: _numberController,
          )
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          key: const Key("CancelButton"),
          style: noStyle,
          child: const Text('Cancel'),
          onPressed: () {
            setState(() {
              Navigator.pop(context);
            });
          },
        ),

        // https://stackoverflow.com/questions/52468987/how-to-turn-disabled-button-into-enabled-button-depending-on-conditions
        ValueListenableBuilder<TextEditingValue>(
          valueListenable: _firstController,
          builder: (context, value, child) {
            return ElevatedButton(
              key: const Key("OKButton"),
              style: yesStyle,
              onPressed: value.text.isNotEmpty
                  ? () {
                      widget.onItemAltered(widget.contact, _firstController,
                          _lastController, _numberController);
                      Navigator.pop(context);
                    }
                  : null,
              child: const Text('OK'),
            );
          },
        ),
      ],
    );
  }
}
