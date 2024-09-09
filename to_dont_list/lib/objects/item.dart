// Data class to keep the string and have an abbreviation function

class Item {
  // Constructor
  const Item({required this.name});

  // Data
  final String name;

  // Methods
  String abbrev() {
    return name.substring(0, 1);
  }
}

// Could make a new class of items
