import 'package:flutter/material.dart';
import 'package:material_notes/src/deleted_note/deleted_note_list_view.dart';
import 'package:material_notes/src/note/note_list_view.dart';

Widget buildDrawer(BuildContext context, String routeName) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(
          child: Text("Material Notes"),
        ),
        ListTile(
          leading: const Icon(Icons.note_sharp),
          title: const Text("All notes"),
          selected: routeName == NoteListView.routeName,
          onTap: () { Navigator.pushReplacementNamed(context, NoteListView.routeName); },
        ),
        ListTile(
          leading: const Icon(Icons.delete),
          title: const Text("Recycle bin"),
          selected: routeName == DeletedNoteListView.routeName,
          onTap: () { Navigator.pushReplacementNamed(context, DeletedNoteListView.routeName); },
        )
      ],
    ),
  );
}
