// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:to_dont_list/main.dart';
import 'package:to_dont_list/objects/checklist_item.dart';
import 'package:to_dont_list/widgets/checklist_list_item.dart';
import 'package:to_dont_list/widgets/checklist_dialog.dart';
import 'package:to_dont_list/checklist_data.dart';

void main() {
  test('Item abbreviation should be first letter', () { //
    const item = ChecklistItem(name: "add more todos");
    expect(item.abbrev(), "a");
  });

  // Yes, you really need the MaterialApp and Scaffold
  testWidgets('ToDoListItem has a text', (tester) async {
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: ChecklistListItem(
                item: const ChecklistItem(name: "test"),
                completed: true,
                onListChanged: (ChecklistItem item, bool completed) {},
                onDeleteItem: (ChecklistItem item) {}))));
    final textFinder = find.text('test');

    // Use the `findsOneWidget` matcher provided by flutter_test to verify
    // that the Text widgets appear exactly once in the widget tree.
    expect(textFinder, findsOneWidget);
  });

  testWidgets('ToDoListItem has a Circle Avatar with abbreviation',
      (tester) async {
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: ChecklistListItem(
                item: const ChecklistItem(name: "test"),
                completed: true,
                onListChanged: (ChecklistItem item, bool completed) {},
                onDeleteItem: (ChecklistItem item) {}))));
    final abbvFinder = find.text('t');
    final avatarFinder = find.byType(CircleAvatar);

    CircleAvatar circ = tester.firstWidget(avatarFinder);
    Text ctext = circ.child as Text;

    // Use the `findsOneWidget` matcher provided by flutter_test to verify
    // that the Text widgets appear exactly once in the widget tree.
    expect(abbvFinder, findsOneWidget);
    expect(circ.backgroundColor, Colors.black54);
    expect(ctext.data, "t");
  });

  testWidgets('Default ToDoList has one item', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: ToDoList(title: 'Test Title',)));

    final listItemFinder = find.byType(ChecklistListItem);

    expect(listItemFinder, findsOneWidget);
  });

  testWidgets('Clicking and Typing adds item to ToDoList', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: ToDoList(title: 'Test Title',)));

    expect(find.byType(TextField), findsNothing);

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump(); // Pump after every action to rebuild the widgets
    expect(find.text("hi"), findsNothing);

    await tester.enterText(find.byType(TextField), 'hi');
    await tester.pump();
    expect(find.text("hi"), findsOneWidget);

    await tester.tap(find.byKey(const Key("OKButton")));
    await tester.pump();
    expect(find.text("hi"), findsOneWidget);

    final listItemFinder = find.byType(ChecklistListItem);

    expect(listItemFinder, findsNWidgets(2));
  });

  testWidgets('Adding new checklist updates the list', (tester) async {
  await tester.pumpWidget(const MaterialApp(home: ToDoList(title: 'Test Title')));

  final initialChecklistCount = checklists.length;

  await tester.tap(find.byType(FloatingActionButton));
  await tester.pumpAndSettle();

  await tester.enterText(find.byType(TextField), 'New Checklist');
  await tester.tap(find.text('OK'));
  await tester.pumpAndSettle();

  expect(checklists.length, initialChecklistCount + 1);
  expect(find.text('New Checklist'), findsOneWidget);
});

  // One to test the tap and press actions on the items?
}
