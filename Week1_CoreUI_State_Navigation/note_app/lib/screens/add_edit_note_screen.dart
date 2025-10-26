// lib/screens/add_edit_note_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/note_provider.dart'; // <--- CHÚ Ý DẤU ../
import '../models/note_model.dart';       // <--- CHÚ Ý DẤU ../

class AddEditNoteScreen extends StatefulWidget {
  final Note? note;

  AddEditNoteScreen({this.note});

  @override
  _AddEditNoteScreenState createState() => _AddEditNoteScreenState();
}

class _AddEditNoteScreenState extends State<AddEditNoteScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  bool _isEditMode = false;

  @override
  void initState() {
    super.initState();

    _isEditMode = widget.note != null;

    _titleController = TextEditingController(
      text: _isEditMode ? widget.note!.title : '',
    );
    _contentController = TextEditingController(
      text: _isEditMode ? widget.note!.content : '',
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _saveNote() {
    if (_formKey.currentState!.validate()) {
      final title = _titleController.text;
      final content = _contentController.text;

      final noteProvider = Provider.of<NoteProvider>(context, listen: false);

      if (_isEditMode) {
        noteProvider.updateNote(widget.note!.id, title, content);
      } else {
        noteProvider.addNote(title, content);
      }

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditMode ? 'Edit Note' : 'Add New Note'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveNote,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Expanded(
                child: TextFormField(
                  controller: _contentController,
                  decoration: InputDecoration(
                    labelText: 'Content',
                    border: OutlineInputBorder(),
                    alignLabelWithHint: true,
                  ),
                  maxLines: null,
                  expands: true,
                  keyboardType: TextInputType.multiline,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}