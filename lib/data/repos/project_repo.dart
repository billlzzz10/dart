import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../db/models/project.dart';

final projectRepoProvider = Provider<ProjectRepository>((ref) {
  return ProjectRepository();
});

class ProjectRepository {
  List<Project> getProjects() {
    return [
      Project.create(
        projectId: 'demo-1',
        name: 'My First Novel',
        description: 'A thrilling adventure story',
      ),
      Project.create(
        projectId: 'demo-2', 
        name: 'Fantasy Epic',
        description: 'Dragons and magic await',
      ),
    ];
  }
}