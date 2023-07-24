import 'package:basic_app/widgets/note_item.dart';
import 'package:flutter/material.dart';

import '../model/Note.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final noteList = Note.noteList();
  List<Note> foundList = [];
  final _todoController = TextEditingController();

  @override
  void initState() {
    foundList = noteList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [searchBox(), listView()],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin:
                        const EdgeInsets.only(bottom: 16, right: 16, left: 16),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 0.0),
                            blurRadius: 10.0,
                            spreadRadius: 0.0)
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: _todoController,
                      decoration: InputDecoration(
                        hintText: "Add new note",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 16, right: 16),
                  child: ElevatedButton(
                    child: Text(
                      '+',
                      style: TextStyle(
                        fontSize: 40,
                      ),
                    ),
                    onPressed: () {
                      _addToDoItem(_todoController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      disabledBackgroundColor: Colors.green,
                      minimumSize: Size(60, 60),
                      elevation: 10,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _handleToDoChange(Note note) {
    setState(() {
      note.isDone = !note.isDone;
    });
  }

  void _deleteToDoItem(int id) {
    setState(() {
      noteList.removeWhere((item) => item.id == id);
    });
  }

  void _addToDoItem(String title) {
    setState(() {
      noteList.add(Note(
        id: DateTime.now().millisecondsSinceEpoch,
        title: title,
      ));
    });
    // for clear text field
    _todoController.clear();
  }

  void _runFilter(String query) {
    List<Note> results = [];
    if (query.isEmpty) {
      results = noteList;
    } else {
      results = noteList
          .where(
              (item) => item.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    setState(() {
      foundList = results;
    });
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.green,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.menu,
            color: Colors.black,
            size: 30,
          ),
          Icon(Icons.settings, color: Colors.black, size: 30)
        ],
      ),
    );
  }

  Widget listView() {
    return Expanded(
        child: ListView(
      children: [
        Container(
          margin: EdgeInsets.only(top: 24, bottom: 16),
          child: Text(
            "All notes",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
          ),
        ),
        for (Note note in foundList)
          NoteItem(
            note: note,
            onToDoChanged: _handleToDoChange,
            onDeleteItem: _deleteToDoItem,
          ),
      ],
    ));
  }

  Widget searchBox() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
          color: Colors.white54, borderRadius: BorderRadius.circular(20)),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(0),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.black,
              size: 20,
            ),
            prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 25),
            border: InputBorder.none,
            hintText: "Search notes",
            hintStyle: TextStyle(color: Colors.grey)),
      ),
    );
  }
}
