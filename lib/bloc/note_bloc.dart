import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/models/note_model.dart';
import '../data/services/note_api_service.dart';
import '../data/services/note_local_service.dart';
import 'note_event.dart';
import 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final NoteApiService apiService;
  final NoteLocalService localService;

  NoteBloc(this.apiService, this.localService) : super(NoteInitial()) {
    on<LoadNotes>(_onLoadNotes);
    on<AddNoteEvent>(_onAddNote);
    on<UpdateNoteEvent>(_onUpdateNote);
    on<DeleteNoteEvent>(_onDeleteNote);
    on<SaveLocalNotesEvent>(_onSaveLocalNotes);
  }

  Future<void> _onLoadNotes(LoadNotes event, Emitter<NoteState> emit) async {
    emit(NoteLoading());
    try {
      final notes = await apiService.fetchNotes();
      await localService.saveNotes(notes);
      emit(NoteLoaded(notes));
    } catch (e) {
      final localNotes = await localService.loadNotes();
      emit(NoteLoaded(localNotes));
    }
  }

  Future<void> _onAddNote(AddNoteEvent event, Emitter<NoteState> emit) async {
    await apiService.addNote(event.title, event.body);
    add(LoadNotes());
  }

  Future<void> _onUpdateNote(UpdateNoteEvent event, Emitter<NoteState> emit) async {
    await apiService.updateNote(event.id, event.title, event.body);
    add(LoadNotes());
  }

  Future<void> _onDeleteNote(DeleteNoteEvent event, Emitter<NoteState> emit) async {
    await apiService.deleteNote(event.id);
    add(LoadNotes());
  }

  Future<void> _onSaveLocalNotes(SaveLocalNotesEvent event, Emitter<NoteState> emit) async {
    await localService.saveNotes(event.notes);
  }
}
