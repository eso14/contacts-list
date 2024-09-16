// Data class to keep the string and have an abbreviation function

class item {
  const item({required this.name});

  final String name;

  String abbrev() {
    return name.substring(0, 1);
  }
}
