import 'package:flutter/material.dart';
import 'package:material_notes/src/general/drawer.dart';
import 'package:material_notes/src/general/note_grid.dart';
import 'package:material_notes/src/note/note.dart';
import 'package:material_notes/src/note/note_details_view.dart';

class DeletedNoteListView extends StatefulWidget {
  static const routeName = "/recycleBin";
  final List<Note> _noteList;

  const DeletedNoteListView(List<Note> notes, {
    super.key
  }) : _noteList = notes;


  @override
  State<StatefulWidget> createState() => _DeletedNoteListViewState();
}

class _DeletedNoteListViewState extends State<DeletedNoteListView> {
  void _onNoteTap(int noteId) {
    Navigator.restorablePushNamed(
      context, NoteDetailsView.routeName,
      arguments: { "noteId": noteId }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recyble bin")
      ),
      
      body: Container(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: widget._noteList.isEmpty ? const Center(
          // RichText is a basic, lower-level approach to rendering text
          // and intentionally does not use theme styles. Text.rich(...)
          // howerver does. A RichText's default color would be white.
          child: Text.rich(
            TextSpan(
              text: "The recycle bin is empty.",
              style: TextStyle(fontStyle: FontStyle.italic)
            )
          ),
        )
        : Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Text("Items show the days until final deletion."),
            const SizedBox(height: 10),
            Expanded(child: buildNoteGrid(widget._noteList, _onNoteTap)),
          ],
        ),
      ),

      drawer: buildDrawer(context, DeletedNoteListView.routeName),
    );
  } 
}
