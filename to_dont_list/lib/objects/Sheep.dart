// Data class to keep the string and have an abbreviation function

class Sheep{
// constructor
   Sheep(
    {required this.name,
    required this.grade,
    required this.age,
    required this.parent1,
    required this.parent2,
    required this.children}

  );

// data
final String name;

final String grade;

final int age;

final Sheep parent1;

final Sheep parent2;

List<Sheep> children;

// methods

int getAge() {
  return age;
}

String getName() {
  return name;
}

String getGrade() {
  return grade;
}

List getChildren() {
  return children;
}

void addChild(Sheep child) {
  children.add(child);
}

}
