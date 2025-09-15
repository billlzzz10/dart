
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;

class CalloutBuilder extends MarkdownElementBuilder {
  Color _getColor(String kind) {
    switch (kind) {
      case 'warning':
        return const Color(0xFFF6C04E);
      case 'danger':
      case 'error':
        return const Color(0xFFE36161);
      case 'info':
        return const Color(0xFF61A8E3);
      case 'tip':
      case 'success':
        return const Color(0xFF4CC38A);
      case 'note':
      default:
        return const Color(0xFF8A8FA3);
    }
  }
  
  IconData _getIcon(String kind) {
    switch (kind) {
      case 'warning':
        return Icons.warning_rounded;
      case 'danger':
      case 'error':
        return Icons.error_rounded;
      case 'info':
        return Icons.info_rounded;
      case 'tip':
      case 'success':
        return Icons.lightbulb_rounded;
      case 'note':
      default:
        return Icons.sticky_note_2_rounded;
    }
  }
  
  @override
  Widget visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    final kind = element.attributes['kind'] ?? 'note';
    final title = element.attributes['title'] ?? kind.toUpperCase();
    final body = element.children?.isNotEmpty == true 
        ? (element.children!.first as md.Element).textContent 
        : '';
    
    final color = _getColor(kind);
    final icon = _getIcon(kind);
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: color.withOpacity(0.1),
        border: Border.all(color: color.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            offset: const Offset(-2, -2),
            blurRadius: 4,
            color: Colors.white.withOpacity(0.1),
          ),
          BoxShadow(
            offset: const Offset(3, 3),
            blurRadius: 8,
            color: Colors.black.withOpacity(0.2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: color),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          if (body.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              body,
              style: const TextStyle(
                color: Colors.white70,
                height: 1.4,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;

class CalloutBuilder extends MarkdownElementBuilder {
  @override
  Widget visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    final kind = element.attributes['kind'] ?? 'note';
    final title = element.attributes['title'] ?? 'NOTE';
    final content = element.textContent;
    
    Color backgroundColor;
    Color borderColor;
    Color titleColor;
    IconData icon;
    
    switch (kind.toLowerCase()) {
      case 'info':
        backgroundColor = const Color(0xFF1E3A8A).withOpacity(0.1);
        borderColor = const Color(0xFF3B82F6);
        titleColor = const Color(0xFF3B82F6);
        icon = Icons.info_outline;
        break;
      case 'warning':
        backgroundColor = const Color(0xFFF59E0B).withOpacity(0.1);
        borderColor = const Color(0xFFF59E0B);
        titleColor = const Color(0xFFF59E0B);
        icon = Icons.warning_amber_outlined;
        break;
      case 'danger':
        backgroundColor = const Color(0xFFDC2626).withOpacity(0.1);
        borderColor = const Color(0xFFDC2626);
        titleColor = const Color(0xFFDC2626);
        icon = Icons.error_outline;
        break;
      case 'tip':
        backgroundColor = const Color(0xFF10B981).withOpacity(0.1);
        borderColor = const Color(0xFF10B981);
        titleColor = const Color(0xFF10B981);
        icon = Icons.lightbulb_outline;
        break;
      default: // note
        backgroundColor = const Color(0xFF6B7280).withOpacity(0.1);
        borderColor = const Color(0xFF6B7280);
        titleColor = const Color(0xFF6B7280);
        icon = Icons.note_outlined;
        break;
    }
    
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border(
          left: BorderSide(color: borderColor, width: 4),
        ),
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(4),
          bottomRight: Radius.circular(4),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: titleColor, size: 20),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    color: titleColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            if (content.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                content,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
