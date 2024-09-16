// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';



import 'package:to_dont_list/objects/Sheep.dart';
import 'package:to_dont_list/widgets/Sheep_items.dart';
import 'package:to_dont_list/widgets/Sheepmain.dart';


void main() {

Sheep sheep1 = Sheep(name: "John", 
      grade: "A2", 
      age: "3", children: []);

  test("Sheep should return info", () {
      // name
      expect(sheep1.name, "John");
      // grade
      expect(sheep1.grade, "A2");
      // age
      expect(sheep1.age, "3");
      // children, none
      expect(sheep1.children, []);
  
  });

  test("Sheep should show children if present", () {
    // adding child to sheep1
      // split test
      Sheep baby = Sheep(name: "baby", 
      grade: "A3", 
      age: "0", children: []);
      sheep1.addChild(baby);
      expect(sheep1.children, [baby]);
  });


  // really just a copy of the origional test, but making sure that theres now three text boxes

  testWidgets('Clicking and Typing adds sheep', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: SheepList()));

    // Note to self: the tests read whats already in main, so John/A2/3 would be read twice sinces hes already in the list
    expect(find.byType(TextField), findsNothing);

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pump(); // Pump after every action to rebuild the widgets
    expect(find.text("hi"), findsNothing);

    // Typing text into EACH box

    await tester.enterText(find.byKey(const Key("nameField")), 'Jack');
    await tester.enterText(find.byKey(const Key("gradeField")), 'B6');
    await tester.enterText(find.byKey(const Key("ageField")), '4');
    await tester.pump();
    
    // Finding typed text
    
    expect(find.text("Jack"), findsOneWidget);
    expect(find.text("B6"), findsOneWidget);
    expect(find.text("4"), findsOneWidget);

    await tester.tap(find.byKey(const Key("OKButton")));
    await tester.pump();
    expect(find.text("Jack"), findsOneWidget);
    // The reason we look for two is because of the grade in the icon, theres two things of B6
    expect(find.text("B6"), findsExactly(2));
    expect(find.text("4"), findsOneWidget);

    final listItemFinder = find.byType(SheepItems);

    expect(listItemFinder, findsNWidgets(6));
  });


  testWidgets('Search functionality filters sheep by name, grade, and age', (tester) async {
  await tester.pumpWidget(const MaterialApp(home: SheepList()));

  // Ensure initial sheep are in the list
  expect(find.text("John"), findsOneWidget);
  expect(find.text("Jack"), findsOneWidget);

  await tester.enterText(find.byType(TextField), 'Jack');
  await tester.pump();
  expect(find.text("John"), findsNothing);
  expect(find.text("Jack"), findsExactly(2)); // Changed to one widget

  // Clear search
  await tester.enterText(find.byType(TextField), '');
  await tester.pump();


  await tester.tap(find.byType(DropdownButton<String>)); // Open the dropdown
  await tester.pumpAndSettle(); // Wait for the dropdown to fully open
  await tester.tap(find.text("Grade").first); // Tap "Grade"
  await tester.pump();
  await tester.enterText(find.byType(TextField), 'B6'); // Enter 'B6' into the TextField
  await tester.pump();
  expect(find.text("B6"), findsOneWidget); // Jack has grade B6
  expect(find.text("John"), findsNothing);

  // Clear search
  await tester.enterText(find.byType(TextField), '');
  await tester.pump();

 
  await tester.tap(find.byType(DropdownButton<String>));
  await tester.pumpAndSettle();
  await tester.tap(find.text("Age").first);
  await tester.pump();
  await tester.enterText(find.byType(TextField), '4');
  await tester.pump();
  expect(find.text("4"), findsExactly(2));
  expect(find.text("Jack"), findsNothing);
});







  
}
