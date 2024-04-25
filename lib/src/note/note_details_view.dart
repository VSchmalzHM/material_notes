import 'package:flutter/material.dart';
import 'package:material_notes/src/note/note.dart';

class NoteDetailsView extends StatefulWidget {
  static const routeName = "/note";
  final Note note;

  const NoteDetailsView({super.key, required this.note});

  @override
  State<StatefulWidget> createState() => _NoteDetailsView();
}

class _NoteDetailsView extends State<NoteDetailsView> {
  final TextEditingController _controllerTitle = TextEditingController();
  final TextEditingController _controllerText = TextEditingController();
  bool _showDetails = false;

  void _updateTitle(String value) { widget.note.title = value; }
  void _updateText(String value) { widget.note.text = value; }

  // Tell the `NoteListView` which Note closed.
  void _onNavigateBack() {
    widget.note.title = _controllerTitle.text;
    widget.note.text = _controllerText.text;
    Navigator.pop(context, widget.note);
  }
  
  @override
  void dispose() {
    _controllerTitle.dispose();
    _controllerText.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _controllerTitle.text = widget.note.title;
    _controllerText.text = widget.note.text;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: _showDetails
            ? const Icon(Icons.arrow_upward)
            : const Icon(Icons.arrow_back),
          onPressed: _showDetails
            ? () { setState(() { _showDetails = false; }); }
            :  _onNavigateBack,
        ),
        title: _showDetails
          ? InkWell(
            child: TextField(
              controller: _controllerTitle,
              onChanged: _updateTitle,
            )
          )
          : InkWell(
            onTap: () { setState(() { _showDetails = true; }); },
            child: Text(widget.note.title)
          ),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: TextField(
          controller: _controllerText,
          expands: true,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          onChanged: _updateText,
        )
      ),
    );
  }
}
