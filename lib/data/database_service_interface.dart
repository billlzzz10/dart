import 'models/base_models.dart';

abstract class DatabaseService {
  Future<void> initialize();
  
  // Project operations
  Future<void> saveProject(Project project);
  Future<Project?> getProject(String projectId);
  Future<List<Project>> getAllProjects();
  Future<void> deleteProject(String projectId);
  
  // Scene operations
  Future<void> saveScene(Scene scene);
  Future<Scene?> getScene(String sceneId);
  Future<List<Scene>> getScenesByProject(String projectId);
  Future<void> deleteScene(String sceneId);
  
  // Item operations
  Future<void> saveItem(Item item);
  Future<Item?> getItem(String itemId);
  Future<List<Item>> getItemsByProject(String projectId);
  Future<void> deleteItem(String itemId);
  
  // Metadata operations
  Future<void> saveMetadata(Metadata metadata);
  Future<Metadata?> getMetadata(String metadataId);
  Future<List<Metadata>> getMetadataByItem(String itemId);
  Future<void> deleteMetadata(String metadataId);
}