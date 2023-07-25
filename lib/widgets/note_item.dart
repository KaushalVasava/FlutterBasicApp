import 'package:flutter/material.dart';

import '../model/Note.dart';
import '../screens/add_note.dart';

class NoteItem extends StatelessWidget {
  const NoteItem(
      {super.key, required this.note, this.onToDoChanged, this.onDeleteItem});

  final Note note;

  final onToDoChanged;
  final onDeleteItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        onTap: () {
          Navigator.push(context,
            MaterialPageRoute(
                builder: (context) => AddNote(noteTitle: note.title))
          );
          // Navigator.pushNamed(context, '/addnote',arguments: {'key': note.title});
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        tileColor: Colors.white,
        leading: IconButton(
          icon: Icon(
              note.isDone ? Icons.check_box : Icons.check_box_outline_blank,
              color: Colors.green),
          onPressed: () {
            onToDoChanged(note);
          },
        ),
        title: Text(
          note.title,
          style: TextStyle(
              fontSize: 16,
              decoration: note.isDone ? TextDecoration.lineThrough : null),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            onDeleteItem(note.id);
          },
        ),
      ),
    );
  }
}
