import '../database_service.dart';
import '../models/base_models.dart';

class ItemRepository {
  final DatabaseService _databaseService;

  ItemRepository(this._databaseService);

  Future<List<Item>> listByProject(String projectId) async {
    return await _databaseService.getItemsByProject(projectId);
  }

  Future<List<Item>> listByType(String projectId, ItemType type) async {
    final items = await _databaseService.getItemsByProject(projectId);
    return items.where((item) => item.type == type).toList();
  }

  Future<Item?> findById(String itemId) async {
    return await _databaseService.getItem(itemId);
  }

  Future<void> save(Item item) async {
    await _databaseService.saveItem(item);
  }

  Future<void> delete(String itemId) async {
    await _databaseService.deleteItem(itemId);
  }

  Future<List<Item>> getStarred(String projectId) async {
    final items = await _databaseService.getItemsByProject(projectId);
    return items.where((item) => item.starred).toList();
  }

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