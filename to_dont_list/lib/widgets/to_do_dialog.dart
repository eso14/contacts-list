import 'package:flutter/material.dart';

typedef ToDoListAddedCallback = Function(
    String value, TextEditingController textConroller, double sliderValue, bool switchValue);

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
  final TextEditingController _inputController = TextEditingController();
  final ButtonStyle yesStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20), backgroundColor: Colors.green);
  final ButtonStyle noStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20), backgroundColor: Colors.red);

  String valueText = "";
  double sliderValue = .0;
  bool switchValue = false; 

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Item To Add'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
      TextField(
        onChanged: (value) {
          setState(() {
            valueText = value;
          });
        },
        controller: _inputController,
        decoration: const InputDecoration(hintText: "type something here"),
      ),
      Slider(
    min: 0, //add min and max
    max: 1,
    value: sliderValue,
    onChanged: (double value) {  
        setState(() {
            sliderValue = value;
        });
    },
),
 SwitchListTile( 
  value: switchValue, 
  onChanged: (bool value){
    setState(() {
              switchValue = value; //update value when sitch changed
          });

  },
  title: RichText(
 text: const TextSpan(
 children: <TextSpan>[
  TextSpan(text: 'Is your book ', style: TextStyle(color:Color.fromARGB(255, 0, 0, 0))),
  TextSpan(text: 'Fiction', style: TextStyle(color:Color.fromARGB(255, 255, 0, 0))),
  TextSpan(text: ' or ', style: TextStyle(color:Color.fromARGB(255, 0, 0, 0))),
  TextSpan(text: 'Non-Fiction', style: TextStyle(color: Color.fromARGB(255, 0, 255, 0))),
  TextSpan(text: ' ?', style: TextStyle(color:Color.fromARGB(255, 0, 0, 0)))
],
),
))
        ],
      ),
      actions: <Widget>[
        // https://stackoverflow.com/questions/52468987/how-to-turn-disabled-button-into-enabled-button-depending-on-conditions
        ValueListenableBuilder<TextEditingValue>(
          valueListenable: _inputController,
          builder: (context, value, child) {
            return ElevatedButton(
              key: const Key("OKButton"),
              style: yesStyle,
              onPressed: value.text.isNotEmpty
                  ? () {
                      setState(() {
                        widget.onListAdded(valueText, _inputController, sliderValue,switchValue);
                        Navigator.pop(context);
                      });
                    }
                  : null,
              child: const Text('OK'),
            );
          },
        ),
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
        

        
      ],
    );
  }
}
