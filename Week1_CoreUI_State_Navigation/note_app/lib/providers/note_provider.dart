// lib/providers/note_provider.dart

import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import '../models/note_model.dart'; // <--- CHÚ Ý DẤU ../

class NoteProvider with ChangeNotifier {
  final Uuid _uuid = Uuid();

  List<Note> _notes = [];

  List<Note> get notes => List.unmodifiable(_notes);

  void addNote(String title, String content) {
    final newNote = Note(
      id: _uuid.v4(),
      title: title,
      content: content,
      timestamp: DateTime.now(),
    );
    _notes.add(newNote);
    notifyListeners();
  }

  void updateNote(String id, String newTitle, String newContent) {
    final index = _notes.indexWhere((note) => note.id == id);
    if (index != -1) {
      final updatedNote = Note(
        id: id,
        title: newTitle,
        content: newContent,
        timestamp: DateTime.now(),
      );
      _notes[index] = updatedNote;
      notifyListeners();
    }
  }

  void deleteNote(String id) {
    _notes.removeWhere((note) => note.id == id);
    notifyListeners();
  }
}