import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/note_bloc.dart';
import 'data/services/note_api_service.dart';
import 'data/services/note_local_service.dart';
import 'ui/screens/note_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final NoteApiService apiService = NoteApiService();
  final NoteLocalService localService = NoteLocalService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Note Taking App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: BlocProvider(
        create: (_) => NoteBloc(apiService, localService),
        child: NoteListScreen(),
      ),
    );
  }
}
