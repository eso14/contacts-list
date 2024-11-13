class Contact {
  Contact(
      {required this.first_name,
      required this.last_name,
      required this.number});
  //constructor
  String first_name;
  String last_name;
  String number;

  //methods
  String intials() {
    return (first_name.substring(0, 1) + last_name.substring(0, 1));
  }

  String get_number() {
    return number;
  }

  String name() {
    return (first_name + " " + last_name);
  }

  // stl-stateless widget , stf- stateful widget, wdiget.(connection to state)
}
