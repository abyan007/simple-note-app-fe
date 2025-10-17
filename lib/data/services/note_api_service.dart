import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/note_model.dart';

class NoteApiService {
  final String baseUrl = 'http://localhost:8080/notes';

  Future<List<Note>> fetchNotes() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((json) => Note.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load notes');
    }
  }

  Future<void> addNote(String title, String body) async {
    await http.post(
      Uri.parse(baseUrl),
      body: jsonEncode({'title': title, 'body': body}),
      headers: {'Content-Type': 'application/json'},
    );
  }

  Future<void> updateNote(int id, String title, String body) async {
    await http.patch(
      Uri.parse('$baseUrl/$id'),
      body: jsonEncode({'title': title, 'body': body}),
      headers: {'Content-Type': 'application/json'},
    );
  }

  Future<void> deleteNote(int id) async {
    await http.delete(Uri.parse('$baseUrl/$id'));
  }
}
