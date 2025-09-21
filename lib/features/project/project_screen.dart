
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/db/models/project.dart';
import '../../data/repos/project_repo.dart';
import '../../widgets/project_cover.dart';
import '../../src/widgets/asset_picker_dialog.dart';

class ProjectScreen extends ConsumerWidget {
  final String projectId;

  const ProjectScreen({super.key, required this.projectId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final project = ref.watch(projectRepoProvider).getProject(int.parse(projectId));

    if (project == null) {
      return const Scaffold(
        body: Center(
          child: Text('Project not found'),
        ),
      );
    }

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
                    project.description ?? '',
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
