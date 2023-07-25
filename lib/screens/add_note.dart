import 'package:flutter/material.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key, required this.noteTitle});

  final String noteTitle;

  @override
  State<AddNote> createState() => _AddNoteState(noteTitle: noteTitle);
}

class _AddNoteState extends State<AddNote> {
  final _noteController = TextEditingController();

  final String noteTitle;

  _AddNoteState({required this.noteTitle});

  @override
  void initState() {
    _noteController.text = noteTitle;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xEAFFFFFF),
      appBar: buildAppBar(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                TextField(
                  controller: _noteController,
                  decoration: InputDecoration(
                    hintText: _noteController.text,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.green,
      title: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Update Note",
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
