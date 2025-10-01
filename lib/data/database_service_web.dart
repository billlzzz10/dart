import 'database_service_interface.dart';
import 'models/base_models.dart';

/// A concrete implementation of the [DatabaseService] interface that uses in-memory storage.
///
/// This service is used for the web platform and is intended for demonstration purposes.
/// In a real-world application, you would likely want to use a more persistent storage
/// mechanism like IndexedDB or local storage.
class WebDatabaseService implements DatabaseService {
  final Map<String, Project> _projects = {};
  final Map<String, Scene> _scenes = {};
  final Map<String, Item> _items = {};
  final Map<String, Metadata> _metadata = {};

  @override
  Future<void> initialize() async {
    // For web, we use in-memory storage. In a real app, you might want to
    // use IndexedDB or localStorage.
  }

  @override
  Future<void> saveProject(Project project) async {
    _projects[project.projectId] = project;
  }

  @override
  Future<Project?> getProject(String projectId) async {
    return _projects[projectId];
  }

  @override
  Future<List<Project>> getAllProjects() async {
    return _projects.values.toList();
  }

  @override
  Future<void> deleteProject(String projectId) async {
    _projects.remove(projectId);
  }

  @override
  Future<void> saveScene(Scene scene) async {
    _scenes[scene.sceneId] = scene;
  }

  @override
  Future<Scene?> getScene(String sceneId) async {
    return _scenes[sceneId];
  }

  @override
  Future<List<Scene>> getScenesByProject(String projectId) async {
    return _scenes.values.where((scene) => scene.projectId == projectId).toList();
  }

  @override
  Future<void> deleteScene(String sceneId) async {
    _scenes.remove(sceneId);
  }

  @override
  Future<void> saveItem(Item item) async {
    _items[item.itemId] = item;
  }

  @override
  Future<Item?> getItem(String itemId) async {
    return _items[itemId];
  }

  @override
  Future<List<Item>> getItemsByProject(String projectId) async {
    return _items.values.where((item) => item.projectId == projectId).toList();
  }

  @override
  Future<void> deleteItem(String itemId) async {
    _items.remove(itemId);
  }

  @override
  Future<void> saveMetadata(Metadata metadata) async {
    _metadata[metadata.metadataId] = metadata;
  }

  @override
  Future<Metadata?> getMetadata(String metadataId) async {
    return _metadata[metadataId];
  }

  @override
  Future<List<Metadata>> getMetadataByItem(String itemId) async {
    return _metadata.values.where((meta) => meta.itemId == itemId).toList();
  }

  @override
  Future<void> deleteMetadata(String metadataId) async {
    _metadata.remove(metadataId);
  }
}

/// Creates a new [DatabaseService] instance for the web.
DatabaseService createDatabaseService() {
  return WebDatabaseService();
}