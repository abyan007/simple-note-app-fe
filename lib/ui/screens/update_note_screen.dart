import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/note_bloc.dart';
import '../../../bloc/note_event.dart';
import '../../../data/models/note_model.dart';

class UpdateNoteScreen extends StatelessWidget {
  final Note note;
  final TextEditingController titleCtrl;
  final TextEditingController bodyCtrl;

  UpdateNoteScreen({required this.note})
      : titleCtrl = TextEditingController(text: note.title),
        bodyCtrl = TextEditingController(text: note.body);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Update Note')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: titleCtrl, decoration: const InputDecoration(labelText: 'Title')),
            TextField(controller: bodyCtrl, decoration: const InputDecoration(labelText: 'Body')),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.read<NoteBloc>().add(UpdateNoteEvent(note.id, titleCtrl.text, bodyCtrl.text));
                Navigator.pop(context);
              },
              child: const Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}
