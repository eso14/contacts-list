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


  testWidgets("Search bar typing and dropdown", (tester) async {
    // Test list of sheep
    final List<Sheep> testSheepList = [
      Sheep(name: "John", grade: "A2", age: "3", children: []),
      Sheep(name: "Jack", grade: "B6", age: "4", children: []),
      Sheep(name: "Jill", grade: "C3", age: "2", children: []),
    ];

    // Helps to build widgit for testing
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SheepList(),
        ),
      ),
    );

    // Making sure sheep are present
    expect(find.text("John"), findsOneWidget);
    expect(find.text("Jack"), findsOneWidget);
    expect(find.text("Jill"), findsOneWidget);

    // Test 1: Filter by name 'Jack'
    await tester.enterText(find.byType(TextField), 'Jack');
    await tester.pump();

    // Verify only Jack appears in the list
    expect(find.text("John"), findsNothing);
    expect(find.text("Jack"), findsOneWidget);
    expect(find.text("Jill"), findsNothing);

    // Test 2: Clear the search and filter by grade 'C3'
    await tester.enterText(find.byType(TextField), ''); // Clears search
    await tester.pump();
    await tester.tap(find.byType(DropdownButton)); // Open the dropdown menu
    await tester.tap(find.text('Grade').last); // Selects "Grade"
    await tester.pump();
    await tester.enterText(find.byType(TextField), 'C3'); // Enter grade
    await tester.pump();

    // Verify only Jill appears in the list with grade C3
    expect(find.text("John"), findsNothing);
    expect(find.text("Jack"), findsNothing);
    expect(find.text("Jill"), findsOneWidget);

    // Test 3: Clear the search and filter by age '3'
    await tester.enterText(find.byType(TextField), '');
    await tester.pump();
    await tester.tap(find.byType(DropdownButton));
    await tester.tap(find.text('Age').last); // Select "Age" as search criteria
    await tester.pump();
    await tester.enterText(find.byType(TextField), '3'); // Enter age
    await tester.pump();

    // Verify only John appears in the list with age 3
    expect(find.text("John"), findsOneWidget);
    expect(find.text("Jack"), findsNothing);
    expect(find.text("Jill"), findsNothing);

  });



  
}
