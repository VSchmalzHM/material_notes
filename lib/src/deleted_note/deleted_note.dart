import 'package:material_notes/src/note/note.dart';

class DeletedNote extends Note {
  final DateTime dateDeleted;

  DeletedNote({
    required this.dateDeleted,
    required super.date,
    required super.title,
    required super.text
  });
}
