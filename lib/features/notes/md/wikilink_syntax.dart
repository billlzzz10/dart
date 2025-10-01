import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;

/// A [md.InlineSyntax] for parsing `[[wikilink]]` syntax.
///
/// This syntax captures text enclosed in double square brackets and creates a
/// `wikilink` element.
class WikiLinkSyntax extends md.InlineSyntax {
  /// Creates a new [WikiLinkSyntax] instance.
  WikiLinkSyntax() : super(r'\[\[([^\]]+)\]\]');

  @override
  bool onMatch(md.InlineParser parser, Match match) {
    final linkText = match.group(1)!;
    final element = md.Element('wikilink', [md.Element.text('span', linkText)]);
    element.attributes['link'] = linkText;
    parser.addNode(element);
    return true;
  }
}

/// A [MarkdownElementBuilder] for building wikilinks.
///
/// This builder creates a tappable text widget that, when tapped, should
/// navigate to the linked note. The text of the link is resolved using the
/// [resolveLinkCallback].
class WikiLinkBuilder extends MarkdownElementBuilder {
  /// A callback that resolves the link text to the actual note title.
  final String Function(String) resolveLinkCallback;

  /// Creates a new [WikiLinkBuilder] instance.
  ///
  /// [resolveLinkCallback] is a callback that resolves the link text to the
  /// actual note title.
  WikiLinkBuilder(this.resolveLinkCallback);

  @override
  Widget visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    final linkText = element.attributes['link'] ?? '';
    final resolvedText = resolveLinkCallback(linkText);

    return GestureDetector(
      onTap: () {
        // TODO: Navigate to linked note
        print('Navigate to: $linkText');
      },
      child: Text(
        resolvedText,
        style: const TextStyle(
          color: Color(0xFF61A8E3),
          decoration: TextDecoration.underline,
          decorationColor: Color(0xFF61A8E3),
        ),
      ),
    );
  }
}

/// Resolves a wikilink by finding the best match in the database.
///
/// This is a placeholder function that simply returns the link text.
/// In a real application, this would search the database for a note
/// with a matching title or alias.
///
/// [linkText] is the text of the wikilink to resolve.
/// Returns the resolved link.
String resolveByBestMatch(String linkText) {
  // TODO: Implement actual resolution from database
  return linkText;
}