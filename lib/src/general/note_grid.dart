import 'package:flutter/material.dart';
import 'package:material_notes/src/general/note_card.dart';
import 'package:material_notes/src/note/note.dart';

Widget buildNoteGrid(List<Note> noteList, Function(int) onNoteTap) {
  // To work with lists/grids that may contain a large number of items,
  // it’s best to use the ListView.builder or GridView.builder constructor
  // respectively.
  //
  // In contrast to the default view constructors, which require building
  // all Widgets up front, the builder constructors lazily build Widgets
  // as they’re scrolled into view.
  return GridView.builder(
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2, crossAxisSpacing: 10,
      mainAxisExtent: 150, mainAxisSpacing: 10,
      childAspectRatio: 0.5
    ),
    itemCount: noteList.length,
    itemBuilder: (BuildContext context, int index) {
      // Stop creating new elements if the length of the backing note
      // list has been reached.
      if(index >= noteList.length) { return null; }

      final Note note = noteList[index];
      return buildNoteCard(note, index, onNoteTap);
    },
    // Providing a restorationId allows the ListView/GridView to restore the
    // scroll position when a user leaves and returns to the app after it
    // has been killed while running in the background.
    restorationId: "noteView",
  );
}
