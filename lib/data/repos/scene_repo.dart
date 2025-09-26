import '../database_service.dart';
import '../models/base_models.dart';

/// A repository for managing scenes.
///
/// This class provides methods for accessing and manipulating scene data.
class SceneRepository {
  final DatabaseService _databaseService;

  /// Creates a new [SceneRepository] instance.
  ///
  /// [_databaseService] is the database service to use for data operations.
  SceneRepository(this._databaseService);

  /// Returns a list of all scenes for a given project.
  ///
  /// [projectId] is the ID of the project to fetch scenes for.
  Future<List<Scene>> listByProject(String projectId) async {
    return await _databaseService.getScenesByProject(projectId);
  }

  /// Returns a scene by its ID.
  ///
  /// [sceneId] is the ID of the scene to fetch.
  /// Returns the scene, or `null` if it doesn't exist.
  Future<Scene?> findById(String sceneId) async {
    return await _databaseService.getScene(sceneId);
  }

  /// Saves a scene to the database.
  ///
  /// [scene] is the scene to save.
  Future<void> save(Scene scene) async {
    await _databaseService.saveScene(scene);
  }

  /// Deletes a scene from the database.
  ///
  /// [sceneId] is the ID of the scene to delete.
  Future<void> delete(String sceneId) async {
    await _databaseService.deleteScene(sceneId);
  }

  /// Searches for scenes in a project that match a given query.
  ///
  /// [projectId] is the ID of the project to search in.
  /// [query] is the search query.
  /// Returns a list of scenes that match the query.
  Future<List<Scene>> search(String projectId, String query) async {
    final scenes = await _databaseService.getScenesByProject(projectId);
    final lowerQuery = query.toLowerCase();
    return scenes.where((scene) =>
      scene.title.toLowerCase().contains(lowerQuery) ||
      scene.content.toLowerCase().contains(lowerQuery)
    ).toList();
  }
}