import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../db/models/project.dart';

/// A provider that creates a [ProjectRepository].
final projectRepoProvider = Provider<ProjectRepository>((ref) {
  return ProjectRepository();
});

/// A repository for managing projects.
///
/// This class provides methods for accessing and manipulating project data.
/// For this demo, it returns a hardcoded list of projects.
class ProjectRepository {
  /// Returns a list of all projects.
  ///
  /// In a real application, this would fetch the projects from a database
  /// or a remote server.
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