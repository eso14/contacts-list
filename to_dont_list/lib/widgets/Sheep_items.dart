import 'package:flutter/material.dart';
import 'package:to_dont_list/objects/Sheep.dart';
import 'package:to_dont_list/widgets/Sheepmain.dart';

typedef ToDoListChangedCallback = Function(Sheep sheep, bool remove);
typedef ToDoListRemovedCallback = Function(Sheep sheep);


// can use "stl" to start a stateless/stateful widget

class SheepItems extends StatefulWidget {
  SheepItems(
      {required this.sheep,
      required this.remove,
      required this.isExpanded,
      required this.onListChanged,
      required this.onDeleteItem})
      : super(key: ObjectKey(sheep));

  final Sheep sheep;
  final bool remove;
  bool isExpanded;
  final ToDoListChangedCallback onListChanged;
  final ToDoListRemovedCallback onDeleteItem;
  

   @override
  State<SheepItems> createState() => _SheepItemsState();

}
class _SheepItemsState extends State<SheepItems> {

  Color _getColor(BuildContext context) {
    // The theme depends on the BuildContext because different
    // parts of the tree can have different themes.
    // The BuildContext indicates where the build is
    // taking place and therefore which theme to use.

    if (widget.remove) {
      return Colors.black54;
    } else {
      return Theme.of(context).primaryColor;
    }
  }

  

  final space4 = SizedBox.fromSize(size: const Size(4, 4));
  final space8 = SizedBox.fromSize(size: const Size(8, 8));

  TextStyle? _getTextStyle(BuildContext context) {
    if (!widget.remove) return null;

    return const TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

List<DropdownMenuItem<String>> get dropdownItems {
List<DropdownMenuItem<String>> menuItems = [
DropdownMenuItem(child: Text("Name"), value: widget.sheep.name),
DropdownMenuItem(child: Text("Grade"), value: widget.sheep.grade),
DropdownMenuItem(child: Text("Age"), value: widget.sheep.age),
];

return menuItems;
}





  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: widget.remove
          ? () {
              widget.onDeleteItem(widget.sheep);
            }
          : null,
      leading: CircleAvatar(
        backgroundColor: _getColor(context),
        child: Text(widget.sheep.grade),
      ),
      title: ExpansionPanelList(
        expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _sheeps[index].isExpanded = !isExpanded;
        });},
         children: _sheeps.map<ExpansionPanel>((Sheep sheep) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(widget.sheep.name),
            );
          },
          body: ListTile(
            title: Row (children: [
      const Text('Grade:'), space4, Text(widget.sheep.grade), space8, 
      const Text("Age:"), space4, Text(widget.sheep.age), space8,],),),
          isExpanded: widget.isExpanded,
        );
      }).toList(),
    ));
  }
      
      /*title: Row(children:[const Text("Name:"), space4, Text(widget.sheep.name),]),
      subtitle: Row ( children: [
      const Text('Grade:'), space4, Text(widget.sheep.grade), space8, 
      const Text("Age:"), space4, Text(widget.sheep.age), space8,],),
      trailing: IconButton(
        onPressed: ()=> setState(() => widget.opened = !widget.opened) , 
        icon: if widget.opened () icon),*/
      //icon button with true false for icon display and on pressed displays subtitle

  }

