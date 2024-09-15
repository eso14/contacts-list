// Started with https://docs.flutter.dev/development/ui/widgets-intro
import 'package:flutter/material.dart';
import 'package:to_dont_list/objects/item.dart';
import 'package:to_dont_list/objects/Sheep.dart';
import 'package:to_dont_list/widgets/Sheep_items.dart';
import 'package:to_dont_list/widgets/to_do_items.dart';
import 'package:to_dont_list/widgets/to_do_dialog.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

// if I want to talk to anything in the state (i.e. extends state)
// use widgit._______ like if I set count here, to accses it in other classes that extend state
// I can do widgit.count

  @override
  State createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  final List<Sheep> sheeps = [Sheep(name: "John", grade: "A2", age: "3", children: [] )];
  final _sheepSet = <Sheep>{};

  void _handleListChanged(Sheep sheep, bool completed) {
    setState(() {
      // When a user changes what's in the list, you need
      // to change _itemSet inside a setState call to
      // trigger a rebuild.
      // The framework then calls build, below,
      // which updates the visual appearance of the app.

      sheeps.remove(sheep);
      if (!completed) {
        print("Completing");
        _sheepSet.add(sheep);
        sheeps.add(sheep);
      } else {
        print("Making Undone");
        _sheepSet.remove(sheep);
        sheeps.insert(0, sheep);
      }
    });
  }

  void _handleDeleteItem(Sheep sheep) {
    setState(() {
      print("Deleting item");
      sheeps.remove(sheep);
    });
  }

  void _handleNewItem(String sheepText, String gradeText, String age, List<Sheep> children, TextEditingController textController) {
    setState(() {
      print("Adding new item");
      Sheep sheep = Sheep(name: sheepText, grade: gradeText, age: age, children: children);
      sheeps.insert(0, sheep);
      textController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Sheep Repository'),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          children: sheeps.map((sheep) {
            return SheepItems(
              sheep: sheep,
              remove: _sheepSet.contains(sheep),
              onListChanged: _handleListChanged,
              onDeleteItem: _handleDeleteItem,
            );
          }).toList(),
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
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
    title: 'To Do List',
    home: ToDoList(),
  ));
}
