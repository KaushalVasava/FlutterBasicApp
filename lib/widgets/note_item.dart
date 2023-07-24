import 'package:flutter/material.dart';

import '../model/Note.dart';

class NoteItem extends StatelessWidget {
  const NoteItem(
      {super.key, required this.note, this.onToDoChanged, this.onDeleteItem});

  final Note note;

  final onToDoChanged;
  final onDeleteItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: ListTile(
        onTap: () {
          print("GO to new page");
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        tileColor: Colors.white54,
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
          icon: Icon(Icons.delete),
          onPressed: () {
            onDeleteItem(note.id);
          },
        ),
      ),
    );
  }
}
