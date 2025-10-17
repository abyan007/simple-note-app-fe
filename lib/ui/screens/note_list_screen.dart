import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/note_bloc.dart';
import '../../../bloc/note_event.dart';
import '../../../bloc/note_state.dart';
import '../../../data/models/note_model.dart';
import 'add_note_screen.dart';
import 'note_detail_screen.dart';

class NoteListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<NoteBloc>().add(LoadNotes());

    return Scaffold(
      appBar: AppBar(title: const Text('Notes')),
      body: BlocBuilder<NoteBloc, NoteState>(
        builder: (context, state) {
          if (state is NoteLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NoteLoaded) {
            return ListView.builder(
              itemCount: state.notes.length,
              itemBuilder: (context, index) {
                final note = state.notes[index];
                return ListTile(
                  title: Text(note.title),
                  subtitle: Text(note.body),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => NoteDetailScreen(note: note)),
                    );
                  },
                );
              },
            );
          } else {
            return const Center(child: Text('No notes available'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => AddNoteScreen()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
