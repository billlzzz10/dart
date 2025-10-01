import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repos/project_repo.dart';
import '../../widgets/project_cover.dart';
import '../../src/widgets/asset_picker_dialog.dart';

/// A screen that displays the details of a single project.
///
/// This screen shows the project's cover image, name, and description.
/// It also provides an option to edit the cover image.
class ProjectScreen extends ConsumerWidget {
  /// The unique identifier for the project.
  final String projectId;

  /// Creates a new [ProjectScreen] instance.
  ///
  /// [projectId] is the ID of the project to be displayed.
  const ProjectScreen({super.key, required this.projectId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // This is a temporary way to get a project. In a real app, this would
    // be an asynchronous operation.
    final projects = ref.watch(projectRepoProvider).getProjects();
    final project = projects.firstWhere(
      (p) => p.projectId == projectId,
      orElse: () => projects.first, // Fallback for demo purposes
    );

    return Scaffold(
      backgroundColor: const Color(0xFF1A1B23),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250.0,
            floating: false,
            pinned: true,
            stretch: true,
            backgroundColor: const Color(0xFF1A1B23),
            flexibleSpace: FlexibleSpaceBar(
              background: ProjectCover(
                project: project,
                height: 250,
                onEdit: () {
                  showDialog(
                    context: context,
                    builder: (context) => const AssetPickerDialog(),
                  );
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project.name,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.white),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    project.description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white70),
                  ),
                  // TODO: Add more project details here
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}