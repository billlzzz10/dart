
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NoteEditor extends StatefulWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  
  const NoteEditor({super.key, required this.controller, required this.onChanged});
  
  @override
  State<NoteEditor> createState() => _NoteEditorState();
}

class _NoteEditorState extends State<NoteEditor> {
  final FocusNode _focusNode = FocusNode();
  
  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF1A1B23),
      child: Column(
        children: [
          _Toolbar(controller: widget.controller),
          const Divider(height: 1, color: Color(0xFF2D2E3F)),
          Expanded(
            child: Shortcuts(
              shortcuts: {
                LogicalKeySet(LogicalKeyboardKey.meta, LogicalKeyboardKey.keyB): const _BoldIntent(),
                LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyB): const _BoldIntent(),
                LogicalKeySet(LogicalKeyboardKey.meta, LogicalKeyboardKey.keyI): const _ItalicIntent(),
                LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyI): const _ItalicIntent(),
                LogicalKeySet(LogicalKeyboardKey.meta, LogicalKeyboardKey.keyK): const _WikiLinkIntent(),
                LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyK): const _WikiLinkIntent(),
              },
              child: Actions(
                actions: {
                  _BoldIntent: CallbackAction<_BoldIntent>(
                    onInvoke: (_) => _wrapSelection('**', '**'),
                  ),
                  _ItalicIntent: CallbackAction<_ItalicIntent>(
                    onInvoke: (_) => _wrapSelection('_', '_'),
                  ),
                  _WikiLinkIntent: CallbackAction<_WikiLinkIntent>(
                    onInvoke: (_) => _wrapSelection('[[', ']]'),
                  ),
                },
                child: TextField(
                  controller: widget.controller,
                  focusNode: _focusNode,
                  maxLines: null,
                  expands: true,
                  autofocus: true,
                  keyboardType: TextInputType.multiline,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    height: 1.4,
                    fontSize: 14,
                    color: Colors.white,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16),
                    hintText: 'Start typing your note...',
                    hintStyle: TextStyle(color: Colors.white38),
                  ),
                  onChanged: widget.onChanged,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  void _wrapSelection(String left, [String right = '']) {
    final controller = widget.controller;
    final selection = controller.selection;
    final text = controller.text;
    final selectedText = text.substring(selection.start, selection.end);
    final rightWrapper = right.isEmpty ? left : right;
    
    final newText = text.replaceRange(
      selection.start,
      selection.end,
      '$left$selectedText$rightWrapper',
    );
    
    controller.text = newText;
    controller.selection = TextSelection.collapsed(
      offset: selection.start + left.length + selectedText.length + rightWrapper.length,
    );
    
    _focusNode.requestFocus();
  }
}

class _Toolbar extends StatelessWidget {
  final TextEditingController controller;
  
  const _Toolbar({required this.controller});
  
  void _wrapSelection(String left, [String right = '']) {
    final selection = controller.selection;
    final text = controller.text;
    final selectedText = text.substring(selection.start, selection.end);
    final rightWrapper = right.isEmpty ? left : right;
    
    controller.text = text.replaceRange(
      selection.start,
      selection.end,
      '$left$selectedText$rightWrapper',
    );
    
    controller.selection = TextSelection.collapsed(
      offset: selection.start + left.length + selectedText.length + rightWrapper.length,
    );
  }
  
  void _insertAtCursor(String text) {
    final selection = controller.selection;
    final currentText = controller.text;
    
    controller.text = currentText.replaceRange(
      selection.start,
      selection.end,
      text,
    );
    
    controller.selection = TextSelection.collapsed(
      offset: selection.start + text.length,
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      color: const Color(0xFF1A1B23),
      child: Wrap(
        spacing: 8,
        runSpacing: 4,
        children: [
          _SoftButton(
            child: const Text('H1', style: TextStyle(fontWeight: FontWeight.bold)),
            onPressed: () => _wrapSelection('# '),
          ),
          _SoftButton(
            child: const Text('H2', style: TextStyle(fontWeight: FontWeight.bold)),
            onPressed: () => _wrapSelection('## '),
          ),
          _SoftButton(
            child: const Text('**B**', style: TextStyle(fontWeight: FontWeight.bold)),
            onPressed: () => _wrapSelection('**', '**'),
          ),
          _SoftButton(
            child: const Text('_I_', style: TextStyle(fontStyle: FontStyle.italic)),
            onPressed: () => _wrapSelection('_', '_'),
          ),
          _SoftButton(
            child: const Text('`code`', style: TextStyle(fontFamily: 'monospace')),
            onPressed: () => _wrapSelection('`', '`'),
          ),
          _SoftButton(
            child: const Text('```'),
            onPressed: () => _insertAtCursor('```\n\n```'),
          ),
          _SoftButton(
            child: const Text('[[link]]'),
            onPressed: () => _wrapSelection('[[', ']]'),
          ),
          _SoftButton(
            child: const Text('Callout'),
            onPressed: () => _insertAtCursor('> [!note] Title\n> Content goes here...\n'),
          ),
          _SoftButton(
            child: const Text('• List'),
            onPressed: () => _insertAtCursor('- '),
          ),
        ],
      ),
    );
  }
}

class _SoftButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  
  const _SoftButton({required this.child, required this.onPressed});
  
  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFF2D2E3F),
      borderRadius: BorderRadius.circular(6),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(6),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: DefaultTextStyle(
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

// Intent classes for keyboard shortcuts
class _BoldIntent extends Intent {
  const _BoldIntent();
}

class _ItalicIntent extends Intent {
  const _ItalicIntent();
}

class _WikiLinkIntent extends Intent {
  const _WikiLinkIntent();
}
