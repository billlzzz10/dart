
import 'package:flutter/material.dart';
import 'note_editor.dart';
import 'note_viewer.dart';

class NotesPage extends StatefulWidget {
  final String noteId;
  const NotesPage({super.key, required this.noteId});
  
  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  bool readMode = true;
  late TextEditingController ctrl;
  
  @override
  void initState() {
    super.initState();
    ctrl = TextEditingController(text: _loadNote(widget.noteId));
  }
  
  @override
  void dispose() {
    ctrl.dispose();
    super.dispose();
  }
  
  String _loadNote(String noteId) {
    // TODO: Load from database
    return '''# Sample Note

This is a **sample note** with _italic text_.

## Code Block

```dart
void main() {
  print('Hello World!');
}
```

## Callouts

> [!note] Important Note
> This is an important note with some content.

> [!warning] Warning
> This is a warning message.

> [!tip] Pro Tip
> This is a helpful tip for users.

## Wikilinks

Check out [[Another Note]] for more information.

### Inline Code

Use `flutter run` to start the app.

### Lists

- Item 1
- Item 2
  - Nested item
  - Another nested item

1. First item
2. Second item
3. Third item
''';
  }
  
  void _saveNote(String noteId, String content) {
    // TODO: Save to database
    print('Saving note $noteId: ${content.length} characters');
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        backgroundColor: const Color(0xFF1A1B23),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(readMode ? Icons.edit_rounded : Icons.visibility_rounded),
            onPressed: () => setState(() => readMode = !readMode),
            tooltip: readMode ? 'Edit' : 'Read',
          ),
        ],
      ),
      backgroundColor: const Color(0xFF1A1B23),
      body: readMode
          ? NoteViewer(text: ctrl.text)
          : NoteEditor(
              controller: ctrl,
              onChanged: (text) => _saveNote(widget.noteId, text),
            ),
    );
  }
}
