import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../data/repos/project_repo.dart';
import '../../widgets/project_card.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projects = ref.watch(projectRepoProvider).getProjects();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Novelist Plus'),
        backgroundColor: const Color(0xFF1A1B23),
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color(0xFF1A1B23),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: StaggeredGridView.countBuilder(
          crossAxisCount: 4,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          itemCount: projects.length,
          itemBuilder: (context, index) {
            final project = projects[index];
            return StaggeredGridTile.count(
              crossAxisCount: 1,
              mainAxisCount: 1,
              child: ProjectCard(
                project: project,
                onTap: () => context.push('/project/${project.id}'),
              ),
            );
          },
          staggeredTileBuilder: (index) => const StaggeredTile.count(1, 1),
        ),
      ),
    );
  }
}