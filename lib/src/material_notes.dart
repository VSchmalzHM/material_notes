import 'package:flutter/material.dart';
import 'package:material_notes/src/deleted_note/deleted_note_list_view.dart';
import 'package:material_notes/src/note/note.dart';
import 'package:material_notes/src/note/note_details_view.dart';
import 'package:material_notes/src/note/note_list_view.dart';

class MaterialNotesApp extends StatefulWidget {
  const MaterialNotesApp({ super.key });

  @override
  State<StatefulWidget> createState() => _MaterialNotesAppState();
}

class _MaterialNotesAppState extends State<MaterialNotesApp> {
  final List<Note> notes = [
    Note(title: "My first note", date: DateTime.now(), text: "Bla bla bla"),
    Note(title: "Shopping list", date: DateTime.now(), text: "- Bread\n- Bierschinken"),
    Note(title: "Another note", date: DateTime.now(), text: "Bli bla blub"),
    Note(title: "Some placeholder", date: DateTime.now(), text: "Lorem ipsum ..."),
    Note(title: "Out of ideas", date: DateTime.now(), text: "I really have no idea what to put here."),
    Note(title: "Solair of Astora", date: DateTime.now(), text: "A Warrior of Sunlight"),
  ];
  final List<Note> notesDeleted = [

  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material Notes',
      theme: ThemeData(
        colorScheme: const ColorScheme.highContrastLight(),
        useMaterial3: true,
      ),
      
      // Define a function to handle named routes in order to support
      // Flutter web url navigation and deep linking.
      onGenerateRoute: (RouteSettings routeSettings) {
        // Explicitly creating page routes is necessary when there are
        // routes with different return types.
        switch(routeSettings.name) {
          case DeletedNoteListView.routeName:
            return MaterialPageRoute(
              settings: routeSettings,
              builder: (BuildContext context) {
                return DeletedNoteListView(notesDeleted);
              }
            );
          case NoteDetailsView.routeName:
            final noteArgs = routeSettings.arguments as Map<String, int>;
            return MaterialPageRoute<Note>(
              settings: routeSettings,
              builder: (BuildContext context) {
                return NoteDetailsView(note: notes[noteArgs["noteId"] as int]);
              }
            );
          case NoteListView.routeName:
            return MaterialPageRoute(
              settings: routeSettings,
              builder: (BuildContext context) {
                return NoteListView(notes);
              }
            );
          default:
            throw ArgumentError("Invalid route ${routeSettings.name}.");
        }
      },
    );
  }
}
