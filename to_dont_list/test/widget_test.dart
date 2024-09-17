// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:to_dont_list/main.dart';
import 'package:to_dont_list/objects/book.dart';
import 'package:to_dont_list/widgets/to_do_items.dart';

void main() {

  // Yes, you really need the MaterialApp and Scaffold
  testWidgets('BookItem has a text', (tester) async {
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: BookItem(
                item: Book(name: "All the President's Men", isFiction: false, progress: 0.5 ),
                completed: true,
                onListChanged: (Book item, bool completed) {},
                onDeleteItem: (Book item) {}))));
    final textFinder = find.text("All the President's Men");

    // Use the `findsOneWidget` matcher provided by flutter_test to verify
    // that the Text widgets appear exactly once in the widget tree.
    expect(textFinder, findsOneWidget);
  });

  testWidgets('ToDoListItem has a Circular progress indicator',
      (tester) async {
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: BookItem(
                item: Book(name: "All the President's Men", isFiction: false, progress: 0.5 ),
                completed: true,
                onListChanged: (Book item, bool completed) {},
                onDeleteItem: (Book item) {}))));
    final avatarFinder = find.byType(CircularProgressIndicator);


    // Use the `findsOneWidget` matcher provided by flutter_test to verify
    // that the Text widgets appear exactly once in the widget tree.
    expect(avatarFinder,findsOneWidget);
  });

  testWidgets('Default ToDoList has one item', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: ToDoList()));

    final listItemFinder = find.byType(BookItem);

    expect(listItemFinder, findsOneWidget);
  });

  testWidgets('Clicking and Typing adds item to ToDoList', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: ToDoList()));

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

    final listItemFinder = find.byType(BookItem);

    expect(listItemFinder, findsNWidgets(2));
  });

  // One to test the tap and press actions on the items?
}
