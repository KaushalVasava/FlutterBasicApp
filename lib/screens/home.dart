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
  final _noteController = TextEditingController();
  final _searchController = TextEditingController();
  @override
  void initState() {
    foundList = noteList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xEAFFFFFF),
      appBar: buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [searchBox(), listView(), bottomTextAndButton()],
            ),
          ),
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

  void _clearQuery(){
    setState(() {
      foundList = noteList;
    });
    _searchController.clear();
  }
  void _addToDoItem(String title) {
    setState(() {
      noteList.add(Note(
        id: DateTime.now().millisecondsSinceEpoch,
        title: title,
      ));
    });
    // for clear text field
    _noteController.clear();
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
      title: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Notes",
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }

  Widget listView() {
    return Expanded(
        child: ListView(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 16, bottom: 16),
          child: const Text(
            "All notes",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
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
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: TextField(
        controller: _searchController,
        textAlignVertical: TextAlignVertical.center,
        onChanged: (value) => _runFilter(value),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(0),
          prefixIcon: const Icon(
            Icons.search,
            color: Colors.black,
            size: 20,
          ),
          prefixIconConstraints: const BoxConstraints(maxHeight: 20, minWidth: 25),
          border: InputBorder.none,
          hintText: "Search notes",
          hintStyle: const TextStyle(color: Colors.grey),
          suffixIcon: IconButton(
              onPressed: _clearQuery,
              icon: const Icon(Icons.close, color: Colors.grey, size: 20)),
        ),
      ),
    );
  }

  Widget bottomTextAndButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(bottom: 16, right: 16),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
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
                controller: _noteController,
                decoration: const InputDecoration(
                  hintText: "Add new note",
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: ElevatedButton(
              onPressed: () {
                _addToDoItem(_noteController.text);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: const Size(60, 60),
                elevation: 10,
                shape: const CircleBorder(),
              ),
              child: const Text(
                '+',
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
