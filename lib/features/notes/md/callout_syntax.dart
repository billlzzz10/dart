
import 'package:markdown/markdown.dart' as md;

/// Captures blocks starting with `> [!type]` syntax
class CalloutBlockSyntax extends md.BlockSyntax {
  static final _start = RegExp(r'^\>\s*\[!(\w+)\]\s*(.*)$');
  
  @override
  RegExp get pattern => _start;
  
  @override
  md.Node? parse(md.BlockParser parser) {
    final first = parser.current;
    final m = _start.firstMatch(first);
    if (m == null) return null;
    
    final kind = m.group(1)!.toLowerCase(); // note, info, warning, danger, tip
    final title = m.group(2) ?? '';
    final buffer = <String>[];
    
    parser.advance(); // Skip the first line
    
    // Consume lines that start with '>' as content
    while (!parser.isDone) {
      final line = parser.current;
      if (line.startsWith('>')) {
        buffer.add(line.substring(1).trimLeft());
        parser.advance();
      } else {
        break;
      }
    }
    
    final content = buffer.join('\n');
    final el = md.Element('callout', []);
    el.attributes['kind'] = kind;
    el.attributes['title'] = title.isEmpty ? kind.toUpperCase() : title;
    if (content.isNotEmpty) {
      el.children!.add(md.Element.text('p', content));
    }
    return el;
  }
}
