
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;

/// Captures [[wikilink]] syntax
class WikiLinkSyntax extends md.InlineSyntax {
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

class WikiLinkBuilder extends MarkdownElementBuilder {
  final String Function(String) resolveLinkCallback;
  
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

String resolveByBestMatch(String linkText) {
  // TODO: Implement actual resolution from database
  return linkText;
}
