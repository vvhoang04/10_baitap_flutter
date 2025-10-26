// lib/screens/note_list_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/note_provider.dart'; // <--- CHÚ Ý DẤU ../
import '../models/note_model.dart';       // <--- CHÚ Ý DẤU ../
import 'add_edit_note_screen.dart';      // <--- (File này cùng thư mục)

class NoteListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Notes'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => AddEditNoteScreen()),
          );
        },
      ),
      body: Consumer<NoteProvider>(
        builder: (context, noteProvider, child) {
          final notes = noteProvider.notes;

          if (notes.isEmpty) {
            return Center(
              child: Text(
                'No notes yet. Add one!',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }

          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final note = notes[index];
              return NoteItem(note: note);
            },
          );
        },
      ),
    );
  }
}

// Widget NoteItem (vẫn trong cùng file)
class NoteItem extends StatelessWidget {
  final Note note;
  const NoteItem({Key? key, required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        title: Text(note.title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(
          note.content,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete_outline, color: Colors.red[300]),
          onPressed: () {
            _showDeleteDialog(context, note);
          },
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddEditNoteScreen(note: note),
            ),
          );
        },
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, Note note) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Confirm Delete'),
        content: Text('Are you sure you want to delete this note?'),
        actions: [
          TextButton(
            child: Text('Cancel'),
            onPressed: () => Navigator.of(ctx).pop(),
          ),
          TextButton(
            child: Text('Delete', style: TextStyle(color: Colors.red)),
            onPressed: () {
              Provider.of<NoteProvider>(context, listen: false)
                  .deleteNote(note.id);
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }
}