// Started with https://docs.flutter.dev/development/ui/widgets-intro
import 'package:flutter/material.dart';
import 'package:to_dont_list/objects/contact.dart';
import 'package:to_dont_list/objects/item.dart';
import 'package:to_dont_list/widgets/to_do_items.dart';
import 'package:to_dont_list/widgets/to_do_dialog.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

  @override
  State createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  final List<Contact> items = [
    Contact(first_name: "Emergency", last_name: "Services", number: "911")
  ];
  final _itemSet = <Contact>{};

  void _handleContactChanged(
      Contact contact,
      TextEditingController first_controller,
      TextEditingController last_controller,
      TextEditingController number_controller) {
    setState(() {
      // When a user changes what's in the list, you need
      // to change _itemSet inside a setState call to
      // trigger a rebuild.
      // The framework then calls build, below,
      // which updates the visual appearance of the app.

      contact.first_name = first_controller.text;
      contact.last_name = last_controller.text;
      contact.number = number_controller.text;
    });
  }

  void _handleDeleteItem(Contact item) {
    setState(() {
      print("Deleting item");
      //_itemSet.remove(item);
      items.remove(item);
    });
  }

  void _handleNewItem(TextEditingController textController,
      TextEditingController txtcontroller, TextEditingController txtcontrol) {
    setState(() {
      print("Adding new item");
      Contact item = Contact(
          first_name: textController.text,
          last_name: txtcontroller.text,
          number: txtcontrol.text);
      //_itemSet.add(item);
      items.insert(0, item);
      textController.clear();
      txtcontroller.clear();
      txtcontrol.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Contacts'),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          children: items.map((item) {
            return ContactListItems(
              item: item,
              favorited: _itemSet.contains(item),
              onItemAltered: _handleContactChanged,
              onDeleteItem: _handleDeleteItem,
            );
          }).toList(),
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            key: Key('Add'),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return ToDoDialog(onListAdded: _handleNewItem);
                  });
            }));
  }
}

void main() {
  runApp(const MaterialApp(
    title: 'Contacts',
    home: ToDoList(),
  ));
}
