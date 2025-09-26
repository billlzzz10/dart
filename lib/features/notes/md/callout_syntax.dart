import 'package:markdown/markdown.dart' as md;

/// A [md.BlockSyntax] for parsing callout blocks.
///
/// A callout block is a blockquote that starts with `> [!type]`, where `type`
/// can be one of `note`, `info`, `warning`, `danger`, or `tip`. The callout
/// can also have an optional title.
///
/// The content of the callout is any subsequent lines that also start with `>`.
class CalloutBlockSyntax extends md.BlockSyntax {
  /// The regular expression for matching the start of a callout block.
  static final _start = RegExp(r'^\>\s*\[!(\w+)\]\s*(.*)$');

  @override
  RegExp get pattern => _start;

  @override
  md.Node? parse(md.BlockParser parser) {
    final first = parser.current.content;
    final m = _start.firstMatch(first);
    if (m == null) return null;

    final kind = m.group(1)!.toLowerCase(); // note, info, warning, danger, tip
    final title = m.group(2) ?? '';
    final buffer = <String>[];

    parser.advance(); // Skip the first line

    // Consume lines that start with '>' as content
    while (!parser.isDone) {
      final line = parser.current.content;
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