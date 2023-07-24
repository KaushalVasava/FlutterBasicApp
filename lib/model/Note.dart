class Note {
  int id;
  String title;
  bool isDone;

  Note({required this.id, required this.title, this.isDone = false});

  static List<Note> noteList() {
    return [
      Note(id: 0, title: "Morning Exercise", isDone: true),
      Note(id: 1, title: "Evening Exercise"),
      Note(id: 2, title: "Android App Development"),
      Note(id: 3, title: "Flutter simple app"),
      Note(id: 4, title: "Build Rest Api Using Ktor", isDone: true),
      Note(id: 5, title: "Mail for Job"),
      Note(id: 6, title: "Mail to mobile distributors"),
      Note(id: 7, title: "Apply for Jobs"),
      Note(id: 8, title: "Movie watch"),
      Note(id: 9, title: "Sleep 8 hours", isDone: true),
    ];
  }
}
