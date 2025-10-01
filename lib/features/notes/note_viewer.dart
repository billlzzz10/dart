import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/atom-one-dark.dart';
import 'package:markdown/markdown.dart' as md;
import 'md/callout_syntax.dart';
import 'md/callout_builder.dart';
import 'md/wikilink_syntax.dart';

/// A widget for viewing a note with rendered Markdown content.
///
/// This widget uses the `flutter_markdown` package to render the note content.
/// It supports standard Markdown syntax, as well as custom syntax for callouts
/// and wikilinks.
class NoteViewer extends StatelessWidget {
  /// The text of the note to be displayed.
  final String text;

  /// Creates a new [NoteViewer] instance.
  ///
  /// [text] is the text of the note to be displayed.
  const NoteViewer({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF1A1B23),
      child: Markdown(
        data: text,
        selectable: true,
        softLineBreak: true,
        inlineSyntaxes: [WikiLinkSyntax()],
        blockSyntaxes: [CalloutBlockSyntax(), ...md.ExtensionSet.gitHubFlavored.blockSyntaxes],
        builders: {
          'code': CodeBlockBuilder(),
          'callout': CalloutBuilder(),
          'wikilink': WikiLinkBuilder(resolveByBestMatch),
        },
        styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
          blockquoteDecoration: const BoxDecoration(), // Disable default blockquote styling
          codeblockPadding: const EdgeInsets.all(0),
          codeblockDecoration: const BoxDecoration(),
          code: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 13,
            backgroundColor: Color(0xFF2D2E3F),
            color: Color(0xFFE1E4E8),
          ),
          h1: const TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
            height: 1.3,
          ),
          h2: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            height: 1.3,
          ),
          h3: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            height: 1.3,
          ),
          h4: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            height: 1.3,
          ),
          h5: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            height: 1.3,
          ),
          h6: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            height: 1.3,
          ),
          p: const TextStyle(
            color: Colors.white70,
            fontSize: 16,
            height: 1.5,
          ),
          strong: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          em: const TextStyle(
            color: Colors.white,
            fontStyle: FontStyle.italic,
          ),
          listBullet: const TextStyle(
            color: Colors.white70,
            fontSize: 16,
          ),
          tableBody: const TextStyle(
            color: Colors.white70,
            fontSize: 14,
          ),
          tableHead: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        padding: const EdgeInsets.all(16),
      ),
    );
  }
}

/// A [MarkdownElementBuilder] for building code blocks with syntax highlighting.
///
/// This builder uses the `flutter_highlight` package to render code blocks
/// with the Atom One Dark theme.
class CodeBlockBuilder extends MarkdownElementBuilder {
  @override
  Widget visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    final className = element.attributes['class'];
    final language = className?.replaceFirst('language-', '') ?? 'plaintext';
    final code = element.textContent;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: HighlightView(
          code,
          language: language,
          theme: atomOneDarkTheme,
          padding: const EdgeInsets.all(16),
          textStyle: const TextStyle(
            fontSize: 13,
            fontFamily: 'monospace',
            height: 1.4,
          ),
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