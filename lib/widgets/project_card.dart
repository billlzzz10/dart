import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../data/db/models/project.dart';
import 'project_cover.dart';

/// A card widget for displaying a summary of a project.
///
/// This widget displays the project's cover image, name, description, and
/// other details in a styled card. It is typically used in a list or grid
/// of projects.
class ProjectCard extends StatelessWidget {
  /// The project to be displayed.
  final Project project;

  /// A callback that is called when the card is tapped.
  final VoidCallback? onTap;

  /// Creates a new [ProjectCard] instance.
  ///
  /// [project] is the project to be displayed.
  /// [onTap] is a callback that is called when the card is tapped.
  const ProjectCard({
    super.key,
    required this.project,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF2A2D3D),
              Color(0xFF1F222F),
            ],
          ),
          boxShadow: [
            BoxShadow(
              offset: const Offset(-4, -4),
              blurRadius: 8,
              color: Colors.white.withOpacity(0.1),
            ),
            BoxShadow(
              offset: const Offset(4, 4),
              blurRadius: 16,
              color: Colors.black.withOpacity(0.3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProjectCover(project: project, height: 120),
              const SizedBox(height: 12),
              Row(
                children: [
                  if (project.icon != null && project.icon!.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Icon(
                        _getIconData(project.icon!) ?? LucideIcons.bookOpen,
                        size: 20,
                        color: Colors.white70,
                      ),
                    ),
                  if (project.emoji != null && project.emoji!.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Text(
                        project.emoji!,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  Expanded(
                    child: Text(
                      project.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              if (project.description.isNotEmpty) ...[
                const SizedBox(height: 4),
                Text(
                  project.description,
                  style: const TextStyle(
                    color: Colors.white60,
                    fontSize: 12,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
              if (project.settings.isNotEmpty) ...[
                const SizedBox(height: 8),
                Wrap(
                  spacing: 4,
                  runSpacing: 4,
                  children: project.settings.take(3).map((tag) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color(0x334CC38A),
                      border: Border.all(color: const Color(0xFF4CC38A), width: 0.5),
                    ),
                    child: Text(
                      tag,
                      style: const TextStyle(
                        color: Color(0xFF4CC38A),
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )).toList(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  /// Returns the [IconData] for a given icon name.
  ///
  /// This method maps a string icon name to the corresponding [IconData] from
  /// the `lucide_icons` package.
  ///
  /// [iconName] is the name of the icon to be returned.
  /// Returns the [IconData] for the icon, or `null` if the icon name is not found.
  IconData? _getIconData(String iconName) {
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