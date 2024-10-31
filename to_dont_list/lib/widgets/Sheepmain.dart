// Started with https://docs.flutter.dev/development/ui/widgets-intro
import 'package:flutter/material.dart';
import 'package:to_dont_list/objects/Sheep.dart';
import 'package:to_dont_list/widgets/Sheep_items.dart';
import 'package:to_dont_list/widgets/to_do_dialog.dart';

class SheepList extends StatefulWidget {
  const SheepList({super.key});

// if I want to talk to anything in the state (i.e. extends state)
// use widgit._______ like if I set count here, to accses it in other classes that extend state
// I can do widgit.count

  @override
  State createState() => _SheepListState();
}

class _SheepListState extends State<SheepList> {
  final List<Sheep> sheeps = [Sheep(name: "John", grade: "A2", age: "3", children: []), 
  Sheep(name: "Jack", grade: "B2", age: "4", children: []),
  Sheep(name: "Billy", grade: "A1", age: "2", children: []),
  Sheep(name: "Susan", grade: "C3", age: "3", children: []),
  Sheep(name: "Astrid", grade: "A2", age: "1", children: [])];
  final _sheepSet = <Sheep>{};
  List<Sheep> filteredSheep = [];
  // for searching stuff
  String searchQuery = '';
  String searchCriteria = 'name';


  @override
  void initState() {
    super.initState();
    filteredSheep = sheeps;
  }

  void _filterSheep(String search) {
    List<Sheep> results = [];
    if (search.isEmpty) {
      results = sheeps;
    } else {
      results = sheeps.where((sheep) {
        if (searchCriteria == 'name') {
          return sheep.name.toLowerCase().contains(search.toLowerCase());
        } else if (searchCriteria == 'grade') {
          return sheep.grade.toLowerCase().contains(search.toLowerCase());
        } else if (searchCriteria == 'age') {
          return sheep.age.toLowerCase().contains(search.toLowerCase());
        }
        return false;
      }).toList();
    }

    setState(() {
      searchQuery = search;
      filteredSheep = results;
    });
  }



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
      _filterSheep(searchQuery);
    });
  }

  void _handleDeleteItem(Sheep sheep) {
    setState(() {
      print("Deleting item");
      sheeps.remove(sheep);
      _filterSheep(searchQuery);
    });
  }

  void _handleNewItem(String sheepText, TextEditingController nameController, String gradeText, TextEditingController gradeController, String age, TextEditingController ageController) {
    setState(() {
      print("Adding new item");
      Sheep sheep = Sheep(name: sheepText, grade: gradeText, age: age, children: []);
      sheeps.insert(0, sheep);
      nameController.clear();
      gradeController.clear();
      ageController.clear();
      _filterSheep(searchQuery);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              // helps with spacing
              Expanded(child: TextField(
                onChanged: (search) => _filterSheep(search),
                // allows for like hint text / icons
                decoration: const InputDecoration(
                  hintText: "Search. . .",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(borderRadius: BorderRadius.horizontal(left: Radius.zero))
                ),
              )
              ),
            const SizedBox(width: 4),
            DropdownButton<String>(
              value: searchCriteria,
              items: const [
                DropdownMenuItem(value: "name", child: Text("Name")),
                DropdownMenuItem(value: "grade", child: Text("Grade")),
                DropdownMenuItem(value: "age", child: Text("Age"),)
              ], 
              onChanged: (value) {
                setState(() {
                  // value! is saying that value will never be null at this point, removes nullability check
                  searchCriteria = value!;
                  _filterSheep(searchQuery);
                });
              })
            ],
          )
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          children: filteredSheep.map((sheep) {
            return SheepItems(
              sheep: sheep,
              remove: _sheepSet.contains(sheep),
              isExpanded: false,
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
              })
    );
  }
}

void main() {
  runApp(const MaterialApp(
    title: 'Sheep Repository',
    home: SheepList(),
  ));
}
