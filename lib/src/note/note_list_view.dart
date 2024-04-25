import 'package:flutter/material.dart';
import 'package:material_notes/src/general/drawer.dart';
import 'package:material_notes/src/general/note_grid.dart';
import 'package:material_notes/src/note/note.dart';
import 'package:material_notes/src/note/note_details_view.dart';

class NoteListView extends StatefulWidget {
  static const routeName = "/";
  final List<Note> _noteList;

  const NoteListView(List<Note> notes, {
    super.key
  }) : _noteList = notes;


  @override
  State<StatefulWidget> createState() => _NoteListViewState();
}

class _NoteListViewState extends State<NoteListView> with RestorationMixin {
  final MenuController _menuController = MenuController();
  final FocusNode _menuFocusNode = FocusNode(debugLabel: 'Menu Button');
  late RestorableRouteFuture<Note> _cardNoteRoute;

  @override
  String get restorationId => NoteListView.routeName;
  
  void _onMenuTap() {
    if(_menuController.isOpen) { _menuController.close(); }
    else { _menuController.open(); }
  }

  void _onNewNote() {
    // Create a new empty note and open it.
    widget._noteList.add(Note(date: DateTime.now(), title: "Aaa", text: "Bbb"));
    Navigator.restorablePushNamed(
      context, NoteDetailsView.routeName,
      arguments: { "noteId": widget._noteList.length - 1 }
    );
    
    setState(() {});
  }

  void _onNoteTap(int noteId) {
    _cardNoteRoute.present({ "noteId": noteId });
  }

  @override
  void initState() {
    super.initState();
    _cardNoteRoute  = RestorableRouteFuture<Note>(
      onPresent: (NavigatorState navigator, Object? arguments) {
        // The `CardDetailsView` returns the backing Note upon returning
        // to this list view.
        return navigator.restorablePushNamed<Note>(
          NoteDetailsView.routeName,
          arguments: arguments
        );
      },
      onComplete: (result) {
        // Update the state incase a note was edited.
        // So the changes are visible.
        setState(() {});
      },
    );
  }
  
  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    // Register the `RestorableRouteFuture` with the state restoration framework.
    // This needs to be done, otherwise an assert will fail because the route
    // future has not been registered.
    registerForRestoration(_cardNoteRoute, NoteDetailsView.routeName);
  }

  @override
  void dispose() {
    super.dispose();
    _cardNoteRoute.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All notes"),
        actions: <Widget>[
          MenuAnchor(
            childFocusNode: _menuFocusNode,
            controller: _menuController,
            menuChildren: <Widget>[
              MenuItemButton(
                onPressed: () { /** TODO: Implement logic. */ },
                child: Text(MenuEntry.edit.label)
              ),
              MenuItemButton(
                onPressed: () { /** TODO: Implement logic. */ },
                child: Text(MenuEntry.view.label)
              ),
            ],
            child: IconButton(
              focusNode: _menuFocusNode,
              icon: const Icon(Icons.more_vert),
              onPressed: () { _onMenuTap(); },
            ),
          ),
        ],
      ),
      
      body: Container(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: buildNoteGrid(widget._noteList, _onNoteTap),
      ),
      
      drawer: buildDrawer(context, NoteListView.routeName),

      floatingActionButton: FloatingActionButton(
        onPressed: _onNewNote,
        child: const Icon(Icons.note_add_sharp),
      ),
    );
  }
}

enum MenuEntry {
  edit("Edit"),
  view("View");

  final String label;

  const MenuEntry(this.label);
}
