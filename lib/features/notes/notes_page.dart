import 'package:flutter/material.dart';
import 'note_editor.dart';
import 'note_viewer.dart';

/// A page for viewing and editing a single note.
///
/// This page is a stateful widget that toggles between a read-only view
/// and an editing view. It takes a `noteId` as a parameter to identify the
/// note to be displayed.
class NotesPage extends StatefulWidget {
  /// The unique identifier for the note.
  final String noteId;

  /// Creates a new [NotesPage] instance.
  ///
  /// [noteId] is the ID of the note to be displayed.
  const NotesPage({super.key, required this.noteId});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  /// Whether the page is in read-only mode.
  bool readMode = true;

  /// The text editing controller for the note content.
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

  /// Loads the content of a note.
  ///
  /// This is a placeholder method that returns a sample note.
  /// In a real application, this would fetch the note from a database.
  ///
  /// [noteId] is the ID of the note to load.
  /// Returns the content of the note.
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

  /// Saves the content of a note.
  ///
  /// This is a placeholder method that prints the note content to the console.
  /// In a real application, this would save the note to a database.
  ///
  /// [noteId] is the ID of the note to save.
  /// [content] is the content of the note to save.
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