import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;

/// A [MarkdownElementBuilder] for building callout blocks.
///
/// This builder creates a styled container for the callout block, with a
/// color and icon that correspond to the callout type.
class CalloutBuilder extends MarkdownElementBuilder {
  @override
  Widget visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    final calloutType = element.attributes['data-callout-type'] ?? 'info';
    final content = element.textContent;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: _getCalloutColor(calloutType).withOpacity(0.1),
        border: Border.all(
          color: _getCalloutColor(calloutType),
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            _getCalloutIcon(calloutType),
            color: _getCalloutColor(calloutType),
            size: 20.0,
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Text(
              content,
              style: TextStyle(
                color: _getCalloutColor(calloutType),
                fontSize: 14.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Returns the color for a given callout type.
  ///
  /// [type] is the type of the callout.
  /// Returns the color for the callout.
  Color _getCalloutColor(String type) {
    switch (type.toLowerCase()) {
      case 'note':
        return Colors.blue;
      case 'tip':
        return Colors.green;
      case 'important':
        return Colors.purple;
      case 'warning':
        return Colors.orange;
      case 'caution':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  /// Returns the icon for a given callout type.
  ///
  /// [type] is the type of the callout.
  /// Returns the icon for the callout.
  IconData _getCalloutIcon(String type) {
    switch (type.toLowerCase()) {
      case 'note':
        return Icons.info_outline;
      case 'tip':
        return Icons.lightbulb_outline;
      case 'important':
        return Icons.priority_high;
      case 'warning':
        return Icons.warning_outlined;
      case 'caution':
        return Icons.dangerous_outlined;
      default:
        return Icons.help_outline;
    }
  }
}

/// A [MarkdownElementBuilder] for building images.
///
/// This builder handles both network and asset images. If the image fails to
/// load, it displays a broken image icon and the alt text.
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