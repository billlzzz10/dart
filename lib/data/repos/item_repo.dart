import '../database_service.dart';
import '../models/base_models.dart';

/// A repository for managing items.
///
/// This class provides methods for accessing and manipulating item data.
class ItemRepository {
  final DatabaseService _databaseService;

  /// Creates a new [ItemRepository] instance.
  ///
  /// [_databaseService] is the database service to use for data operations.
  ItemRepository(this._databaseService);

  /// Returns a list of all items for a given project.
  ///
  /// [projectId] is the ID of the project to fetch items for.
  Future<List<Item>> listByProject(String projectId) async {
    return await _databaseService.getItemsByProject(projectId);
  }

  /// Returns a list of all items of a given type for a given project.
  ///
  /// [projectId] is the ID of the project to fetch items for.
  /// [type] is the type of items to fetch.
  Future<List<Item>> listByType(String projectId, ItemType type) async {
    final items = await _databaseService.getItemsByProject(projectId);
    return items.where((item) => item.type == type).toList();
  }

  /// Returns an item by its ID.
  ///
  /// [itemId] is the ID of the item to fetch.
  /// Returns the item, or `null` if it doesn't exist.
  Future<Item?> findById(String itemId) async {
    return await _databaseService.getItem(itemId);
  }

  /// Saves an item to the database.
  ///
  /// [item] is the item to save.
  Future<void> save(Item item) async {
    await _databaseService.saveItem(item);
  }

  /// Deletes an item from the database.
  ///
  /// [itemId] is the ID of the item to delete.
  Future<void> delete(String itemId) async {
    await _databaseService.deleteItem(itemId);
  }

  /// Returns a list of all starred items for a given project.
  ///
  /// [projectId] is the ID of the project to fetch starred items for.
  Future<List<Item>> getStarred(String projectId) async {
    final items = await _databaseService.getItemsByProject(projectId);
    return items.where((item) => item.starred).toList();
  }

  /// Updates the metadata for an item.
  ///
  /// [itemId] is the ID of the item to update.
  /// [metadata] is the new metadata for the item.
  Future<void> updateMetadata(String itemId, Map<String, dynamic> metadata) async {
    final item = await findById(itemId);
    if (item != null) {
      // Convert metadata map to list of strings for Isar storage
      final metadataList = metadata.entries
          .map((entry) => '${entry.key}:${entry.value}')
          .toList();

      item.metadata = metadataList;
      item.updatedAt = DateTime.now();
      await save(item);
    }
  }

  /// Searches for items in a project that match a given query.
  ///
  /// [projectId] is the ID of the project to search in.
  /// [query] is the search query.
  /// Returns a list of items that match the query.
  Future<List<Item>> search(String projectId, String query) async {
    final items = await _databaseService.getItemsByProject(projectId);
    final lowerQuery = query.toLowerCase();
    return items.where((item) =>
      item.name.toLowerCase().contains(lowerQuery) ||
      item.description.toLowerCase().contains(lowerQuery) ||
      item.notes.toLowerCase().contains(lowerQuery)
    ).toList();
  }
}