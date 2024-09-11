import 'package:flutter/material.dart';
import 'package:to_dont_list/objects/Sheep.dart';

typedef ToDoListChangedCallback = Function(Sheep sheep, bool remove);
typedef ToDoListRemovedCallback = Function(Sheep sheep);


// can use "stl" to start a stateless/stateful widget

class SheepItems extends StatelessWidget {
  SheepItems(
      {required this.sheep,
      required this.remove,
      required this.onListChanged,
      required this.onDeleteItem})
      : super(key: ObjectKey(sheep));

  final Sheep sheep;
  final bool remove;
  final ToDoListChangedCallback onListChanged;
  final ToDoListRemovedCallback onDeleteItem;

  Color _getColor(BuildContext context) {
    // The theme depends on the BuildContext because different
    // parts of the tree can have different themes.
    // The BuildContext indicates where the build is
    // taking place and therefore which theme to use.

    if (!remove) {
      return Colors.black54;
    } else {
      return Theme.of(context).primaryColor;
    }
  }

  TextStyle? _getTextStyle(BuildContext context) {
    if (remove) return null;

    return const TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: remove
          ? () {
              onDeleteItem(sheep);
            }
          : null,
      leading: CircleAvatar(
        backgroundColor: _getColor(context),
        child: Text(sheep.name),
      ),
      title: Text(
        sheep.name,
        style: _getTextStyle(context),
      ),
      trailing: Row(
        children: <Text>[Text(sheep.grade), Text(sheep.age.toString())],
      ),
    );
  }
}
