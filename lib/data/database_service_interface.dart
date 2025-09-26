import 'models/base_models.dart';

/// An abstract class that defines the interface for the database service.
///
/// This class provides a contract for all database operations in the app.
abstract class DatabaseService {
  /// Initializes the database service.
  Future<void> initialize();

  // Project operations
  /// Saves a [Project] to the database.
  ///
  /// [project] is the project to save.
  Future<void> saveProject(Project project);

  /// Retrieves a [Project] from the database.
  ///
  /// [projectId] is the ID of the project to retrieve.
  /// Returns the project, or `null` if it doesn't exist.
  Future<Project?> getProject(String projectId);

  /// Retrieves all [Project]s from the database.
  ///
  /// Returns a list of all projects.
  Future<List<Project>> getAllProjects();

  /// Deletes a [Project] from the database.
  ///
  /// [projectId] is the ID of the project to delete.
  Future<void> deleteProject(String projectId);

  // Scene operations
  /// Saves a [Scene] to the database.
  ///
  /// [scene] is the scene to save.
  Future<void> saveScene(Scene scene);

  /// Retrieves a [Scene] from the database.
  ///
  /// [sceneId] is the ID of the scene to retrieve.
  /// Returns the scene, or `null` if it doesn't exist.
  Future<Scene?> getScene(String sceneId);

  /// Retrieves all [Scene]s for a given project from the database.
  ///
  /// [projectId] is the ID of the project to retrieve scenes for.
  /// Returns a list of scenes for the project.
  Future<List<Scene>> getScenesByProject(String projectId);

  /// Deletes a [Scene] from the database.
  ///
  /// [sceneId] is the ID of the scene to delete.
  Future<void> deleteScene(String sceneId);

  // Item operations
  /// Saves an [Item] to the database.
  ///
  /// [item] is the item to save.
  Future<void> saveItem(Item item);

  /// Retrieves an [Item] from the database.
  ///
  /// [itemId] is the ID of the item to retrieve.
  /// Returns the item, or `null` if it doesn't exist.
  Future<Item?> getItem(String itemId);

  /// Retrieves all [Item]s for a given project from the database.
  ///
  /// [projectId] is the ID of the project to retrieve items for.
  /// Returns a list of items for the project.
  Future<List<Item>> getItemsByProject(String projectId);

  /// Deletes an [Item] from the database.
  ///
  /// [itemId] is the ID of the item to delete.
  Future<void> deleteItem(String itemId);

  // Metadata operations
  /// Saves [Metadata] to the database.
  ///
  /// [metadata] is the metadata to save.
  Future<void> saveMetadata(Metadata metadata);

  /// Retrieves [Metadata] from the database.
  ///
  /// [metadataId] is the ID of the metadata to retrieve.
  /// Returns the metadata, or `null` if it doesn't exist.
  Future<Metadata?> getMetadata(String metadataId);

  /// Retrieves all [Metadata] for a given item from the database.
  ///
  /// [itemId] is the ID of the item to retrieve metadata for.
  /// Returns a list of metadata for the item.
  Future<List<Metadata>> getMetadataByItem(String itemId);

  /// Deletes [Metadata] from the database.
  ///
  /// [metadataId] is the ID of the metadata to delete.
  Future<void> deleteMetadata(String metadataId);
}