
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../data/db/models/project.dart';

class ProjectCover extends StatelessWidget {
  final Project project;
  final double height;
  final double? width;
  final VoidCallback? onEdit;

  const ProjectCover({
    super.key,
    required this.project,
    this.height = 160,
    this.width,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    Widget coverContent;

    if (project.coverUrl != null && project.coverUrl!.isNotEmpty) {
      coverContent = ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: project.coverUrl!.startsWith('http')
            ? Image.network(
                project.coverUrl!,
                fit: BoxFit.cover,
                height: height,
                width: width ?? double.infinity,
                errorBuilder: (context, error, stackTrace) => _buildFallback(),
              )
            : Image.asset(
                project.coverUrl!,
                fit: BoxFit.cover,
                height: height,
                width: width ?? double.infinity,
                errorBuilder: (context, error, stackTrace) => _buildFallback(),
              ),
      );
    } else {
      coverContent = _buildFallback();
    }

    if (onEdit != null) {
      return Stack(
        clipBehavior: Clip.none,
        children: [
          coverContent,
          Positioned(
            bottom: 8,
            right: 8,
            child: TextButton.icon(
              onPressed: onEdit,
              icon: const Icon(LucideIcons.imagePlus, size: 16),
              label: const Text('Change'),
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.black.withOpacity(0.6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
            ),
          ),
        ],
      );
    }

    return coverContent;
  }

  Widget _buildFallback() {
    return Container(
      height: height,
      width: width ?? double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0x332E86FF),
            Color(0x556B46C1),
          ],
        ),
      ),
      child: Center(
        child: _buildIconOrEmoji(),
      ),
    );
  }

  Widget _buildIconOrEmoji() {
    if (project.icon != null && project.icon!.isNotEmpty) {
      final IconData? iconData = _getIconData(project.icon!);
      if (iconData != null) {
        return Icon(iconData, size: 64, color: Colors.white70);
      }
    }
    
    if (project.emoji != null && project.emoji!.isNotEmpty) {
      return Text(
        project.emoji!,
        style: const TextStyle(fontSize: 56),
      );
    }
    
    return const Icon(
      LucideIcons.bookOpen,
      size: 64,
      color: Colors.white70,
    );
  }

  IconData? _getIconData(String iconName) {
    // Map common icon names to LucideIcons
    const iconMap = {
      'book-open': LucideIcons.bookOpen,
      'file-text': LucideIcons.fileText,
      'pen-tool': LucideIcons.penTool,
      'users': LucideIcons.users,
      'map-pin': LucideIcons.mapPin,
      'calendar': LucideIcons.calendar,
      'star': LucideIcons.star,
      'heart': LucideIcons.heart,
      'lightning': LucideIcons.zap,
      'globe': LucideIcons.globe,
    };
    
    return iconMap[iconName];
  }
}
