import '../database_service.dart';
import '../models/base_models.dart';

class SceneRepository {
  final DatabaseService _databaseService;

  SceneRepository(this._databaseService);

  Future<List<Scene>> listByProject(String projectId) async {
    return await _databaseService.getScenesByProject(projectId);
  }

  Future<Scene?> findById(String sceneId) async {
    return await _databaseService.getScene(sceneId);
  }

  Future<void> save(Scene scene) async {
    await _databaseService.saveScene(scene);
  }

  Future<void> delete(String sceneId) async {
    await _databaseService.deleteScene(sceneId);
  }

  Future<List<Scene>> search(String projectId, String query) async {
    final scenes = await _databaseService.getScenesByProject(projectId);
    final lowerQuery = query.toLowerCase();
    return scenes.where((scene) => 
      scene.title.toLowerCase().contains(lowerQuery) ||
      scene.content.toLowerCase().contains(lowerQuery)
    ).toList();
  }
}