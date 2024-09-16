class Book {
   Book({required this.name, required this.isFiction,  this.progress = 0 });
  final String name;
  double progress;
  final bool isFiction;
  void changeProgress( double newProgress){
    progress = newProgress;
  }
}