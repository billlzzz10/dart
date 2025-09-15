import '../database_service.dart';
import '../models/base_models.dart';

class ProjectRepository {
  final DatabaseService _databaseService;

  ProjectRepository(this._databaseService);

  Future<List<Project>> list() async {
    return await _databaseService.getAllProjects();
  }

  Future<Project?> findById(String projectId) async {
    return await _databaseService.getProject(projectId);
  }

  Future<void> save(Project project) async {
    await _databaseService.saveProject(project);
  }

  Future<void> delete(String projectId) async {
    await _databaseService.deleteProject(projectId);
  }

  Future<List<Project>> getRecent({int limit = 5}) async {
    final projects = await _databaseService.getAllProjects();
    projects.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    return projects.take(limit).toList();
  }
}