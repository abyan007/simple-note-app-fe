import '../data/models/note_model.dart';

abstract class NoteEvent {}

class LoadNotes extends NoteEvent {}
class AddNoteEvent extends NoteEvent {
  final String title;
  final String body;
  AddNoteEvent(this.title, this.body);
}
class UpdateNoteEvent extends NoteEvent {
  final int id;
  final String title;
  final String body;
  UpdateNoteEvent(this.id, this.title, this.body);
}
class DeleteNoteEvent extends NoteEvent {
  final int id;
  DeleteNoteEvent(this.id);
}
class SaveLocalNotesEvent extends NoteEvent {
  final List<Note> notes;
  SaveLocalNotesEvent(this.notes);
}
