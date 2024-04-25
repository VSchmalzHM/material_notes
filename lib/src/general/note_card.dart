import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_notes/src/note/note.dart';

final DateFormat formatter = DateFormat("dd. MMM. yyyy");

Widget buildNoteCard(Note note, int noteId, Function(int) onNoteTap) {
  return Card(
    // A Card is a sheet of material, it cannot capture user interactions.
    // To enable interactions we use an InkWell or GestureDetector. The
    // clip behavior is necessary because otherwise, the InkWell's would
    // clip out of the card.
    clipBehavior: Clip.hardEdge,
    child: InkWell(
      onTap: () => onNoteTap(noteId),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(note.title),
            subtitle: Text(formatter.format(note.date)),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              constraints: const BoxConstraints.expand(),
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              padding: const EdgeInsets.all(5),
              child: Text(note.text),
            ),
          ),
        ],
      ),
    ),
  );
}
