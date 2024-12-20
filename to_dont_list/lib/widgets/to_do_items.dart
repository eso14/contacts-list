import 'package:flutter/material.dart';
import 'package:to_dont_list/objects/contact.dart';
import 'package:to_dont_list/objects/item.dart';
import 'package:to_dont_list/widgets/edit_contact_dialog.dart';
import 'package:to_dont_list/widgets/to_do_dialog.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:to_dont_list/main.dart';

typedef OnItemAltered = Function(
    Contact contact,
    TextEditingController first_controller,
    TextEditingController last_controller,
    TextEditingController number_controller);
typedef ToDoListRemovedCallback = Function(Contact item);

class ContactListItems extends StatefulWidget {
  ContactListItems(
      {required this.item,
      required this.favorited,
      required this.onItemAltered,
      required this.onDeleteItem})
      : super(key: ObjectKey(item));

  final Contact item;
  bool favorited;

  final OnItemAltered onItemAltered;
  final ToDoListRemovedCallback onDeleteItem;

  @override
  State<ContactListItems> createState() => _ContactListItemsState();
}

class _ContactListItemsState extends State<ContactListItems> {
  Color _getColor(BuildContext context) {
    // The theme depends on the BuildContext because different
    // parts of the tree can have different themes.
    // The BuildContext indicates where the build is
    // taking place and therefore which theme to use.

    return widget.favorited //
        ? Colors.deepPurple
        : Theme.of(context).primaryColor;
  }

  TextStyle? _getTextStyle(BuildContext context) {
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(

      onTap: () {},
      onLongPress:
           () {
              widget.onDeleteItem(widget.item);
            },        
      leading: CircleAvatar(
        backgroundColor: _getColor(context),
        child: Text(widget.item.intials()),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
      FloatingActionButton(
        foregroundColor: widget.item.isFavorite ? Colors.red.shade800 : Colors.grey.shade400,
        onPressed: () {setState(() { widget.item.isFavorite = !widget.item.isFavorite;
        widget.onListChanged(widget.item,true);});},
        child: const Icon(Icons.favorite)),
      FloatingActionButton(
        onPressed: () async{
          final Uri url = Uri(
            scheme: 'tel', path: widget.item.get_number(),
          );
          if (await canLaunchUrl(url)){
            launchUrl(url);
          }else{
            print('cannot launch this url');
          }
        },
        child: const Icon(Icons.call)),
      ]),
      title: Text(
        widget.item.name(),
        style: _getTextStyle(context),
      ),
      subtitle: Text(
        widget.item.get_number(),)
    );

  }
}
