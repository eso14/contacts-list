// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:to_dont_list/main.dart';
import 'package:to_dont_list/objects/contact.dart';
import 'package:to_dont_list/objects/item.dart';
import 'package:to_dont_list/widgets/to_do_items.dart';

void main() {
  test('Contact abbreviation should be initials', () {
    const item = Contact(first_name: "Emergency", last_name: "Services", number: "911");
    expect(item.intials(), "ES");
  });

  // Yes, you really need the MaterialApp and Scaffold

  testWidgets('ContactItem has a Circle Avatar with abbreviation',
      (tester) async {
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: ContactListItems(
                item: const Contact(first_name: "test", last_name:"test last", number: "01" ),
                favorited: true,
                onListChanged: (Contact item, bool favorited) {},
                onDeleteItem: (Contact item) {}))));
    final abbvFinder = find.text('tt');
    final avatarFinder = find.byType(CircleAvatar);

    CircleAvatar circ = tester.firstWidget(avatarFinder);
    Text ctext = circ.child as Text;

    // Use the `findsOneWidget` matcher provided by flutter_test to verify
    // that the Text widgets appear exactly once in the widget tree.
    expect(abbvFinder, findsOneWidget);
    expect(ctext.data, "tt");
  });

  testWidgets('Default ContactList has one item', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: ToDoList()));

    final listItemFinder = find.byType(ContactListItems);

    expect(listItemFinder, findsOneWidget);
  });
  testWidgets('Favorite icon changes when clicked',
      (tester) async {
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: ContactListItems(
                item: const Contact(first_name: "test", last_name:"test last", number: "01" ),
                favorited: true,
                onListChanged: (Contact item, bool favorited) {},
                onDeleteItem: (Contact item) {}))));
  
    final buttonFinder = find.byType(FloatingActionButton);

    FloatingActionButton fav = tester.firstWidget(buttonFinder);
    

    // Use the `findsOneWidget` matcher provided by flutter_test to verify
    // that the Text widgets appear exactly once in the widget tree.
    expect(fav.foregroundColor, Colors.red.shade800);
  
  });

  // One to test the tap and press actions on the items?
}
