
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;

class ImageBuilder extends MarkdownElementBuilder {
  @override
  Widget visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    final src = element.attributes['src'] ?? '';
    final alt = element.attributes['alt'] ?? '';
    
    if (src.isEmpty) {
      return const SizedBox.shrink();
    }

    if (src.startsWith('http')) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Image.network(
          src,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                children: [
                  const Icon(Icons.broken_image, size: 48, color: Colors.grey),
                  if (alt.isNotEmpty)
                    Text(alt, style: const TextStyle(color: Colors.grey)),
                ],
              ),
            );
          },
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Image.asset(
          src,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                children: [
                  const Icon(Icons.broken_image, size: 48, color: Colors.grey),
                  if (alt.isNotEmpty)
                    Text(alt, style: const TextStyle(color: Colors.grey)),
                ],
              ),
            );
          },
        ),
      );
    }
  }
}
