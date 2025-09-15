import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'database_service_interface.dart';
import 'models/base_models.dart' as base;
import 'db/models/project.dart' as isar_models;
import 'db/models/scene.dart' as isar_models;
import 'db/models/item.dart' as isar_models;
import 'db/models/metadata.dart' as isar_models;

class IsarDatabaseService implements DatabaseService {
  late Isar _isar;
  
  @override
  Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open(
      [isar_models.ProjectSchema, isar_models.SceneSchema, isar_models.ItemSchema, isar_models.MetadataSchema],
      directory: dir.path,
      inspector: kDebugMode,
    );
  }
  
  // Conversion functions from base models to Isar models
  isar_models.Project _toIsarProject(base.Project baseProject) {
    final isarProject = isar_models.Project();
    isarProject.id = baseProject.id;
    isarProject.projectId = baseProject.projectId;
    isarProject.name = baseProject.name;
    isarProject.description = baseProject.description;
    isarProject.createdAt = baseProject.createdAt;
    isarProject.updatedAt = baseProject.updatedAt;
    isarProject.characterIds = List.from(baseProject.characterIds);
    isarProject.sceneIds = List.from(baseProject.sceneIds);
    isarProject.settings = List.from(baseProject.settings);
    return isarProject;
  }
  
  base.Project _fromIsarProject(isar_models.Project isarProject) {
    final baseProject = base.Project();
    baseProject.id = isarProject.id;
    baseProject.projectId = isarProject.projectId;
    baseProject.name = isarProject.name;
    baseProject.description = isarProject.description;
    baseProject.createdAt = isarProject.createdAt;
    baseProject.updatedAt = isarProject.updatedAt;
    baseProject.characterIds = List.from(isarProject.characterIds);
    baseProject.sceneIds = List.from(isarProject.sceneIds);
    baseProject.settings = List.from(isarProject.settings);
    return baseProject;
  }
  
  isar_models.Scene _toIsarScene(base.Scene baseScene) {
    final isarScene = isar_models.Scene();
    isarScene.id = baseScene.id;
    isarScene.sceneId = baseScene.sceneId;
    isarScene.projectId = baseScene.projectId;
    isarScene.title = baseScene.title;
    isarScene.content = baseScene.content;
    isarScene.itemIds = List.from(baseScene.itemIds);
    isarScene.subplots = List.from(baseScene.subplots);
    isarScene.metadata = List.from(baseScene.metadata);
    isarScene.createdAt = baseScene.createdAt;
    isarScene.updatedAt = baseScene.updatedAt;
    return isarScene;
  }
  
  base.Scene _fromIsarScene(isar_models.Scene isarScene) {
    final baseScene = base.Scene();
    baseScene.id = isarScene.id;
    baseScene.sceneId = isarScene.sceneId;
    baseScene.projectId = isarScene.projectId;
    baseScene.title = isarScene.title;
    baseScene.content = isarScene.content;
    baseScene.itemIds = List.from(isarScene.itemIds);
    baseScene.subplots = List.from(isarScene.subplots);
    baseScene.metadata = List.from(isarScene.metadata);
    baseScene.createdAt = isarScene.createdAt;
    baseScene.updatedAt = isarScene.updatedAt;
    return baseScene;
  }
  
  isar_models.Item _toIsarItem(base.Item baseItem) {
    final isarItem = isar_models.Item();
    isarItem.id = baseItem.id;
    isarItem.itemId = baseItem.itemId;
    isarItem.projectId = baseItem.projectId;
    isarItem.name = baseItem.name;
    isarItem.type = _toIsarItemType(baseItem.type);
    isarItem.description = baseItem.description;
    isarItem.tags = List.from(baseItem.tags);
    isarItem.starred = baseItem.starred;
    isarItem.pictureUrls = List.from(baseItem.pictureUrls);
    isarItem.metadata = List.from(baseItem.metadata);
    isarItem.relationships = List.from(baseItem.relationships);
    isarItem.notes = baseItem.notes;
    isarItem.createdAt = baseItem.createdAt;
    isarItem.updatedAt = baseItem.updatedAt;
    return isarItem;
  }
  
  base.Item _fromIsarItem(isar_models.Item isarItem) {
    final baseItem = base.Item();
    baseItem.id = isarItem.id;
    baseItem.itemId = isarItem.itemId;
    baseItem.projectId = isarItem.projectId;
    baseItem.name = isarItem.name;
    baseItem.type = _fromIsarItemType(isarItem.type);
    baseItem.description = isarItem.description;
    baseItem.tags = List.from(isarItem.tags);
    baseItem.starred = isarItem.starred;
    baseItem.pictureUrls = List.from(isarItem.pictureUrls);
    baseItem.metadata = List.from(isarItem.metadata);
    baseItem.relationships = List.from(isarItem.relationships);
    baseItem.notes = isarItem.notes;
    baseItem.createdAt = isarItem.createdAt;
    baseItem.updatedAt = isarItem.updatedAt;
    return baseItem;
  }
  
  isar_models.Metadata _toIsarMetadata(base.Metadata baseMetadata) {
    final isarMetadata = isar_models.Metadata();
    isarMetadata.id = baseMetadata.id;
    isarMetadata.metadataId = baseMetadata.metadataId;
    isarMetadata.itemId = baseMetadata.itemId;
    isarMetadata.fields = List.from(baseMetadata.fields);
    isarMetadata.updatedAt = baseMetadata.updatedAt;
    return isarMetadata;
  }
  
  base.Metadata _fromIsarMetadata(isar_models.Metadata isarMetadata) {
    final baseMetadata = base.Metadata();
    baseMetadata.id = isarMetadata.id;
    baseMetadata.metadataId = isarMetadata.metadataId;
    baseMetadata.itemId = isarMetadata.itemId;
    baseMetadata.fields = List.from(isarMetadata.fields);
    baseMetadata.updatedAt = isarMetadata.updatedAt;
    return baseMetadata;
  }
  
  isar_models.ItemType _toIsarItemType(base.ItemType baseType) {
    switch (baseType) {
      case base.ItemType.character:
        return isar_models.ItemType.character;
      case base.ItemType.location:
        return isar_models.ItemType.location;
      case base.ItemType.prop:
        return isar_models.ItemType.prop;
      case base.ItemType.event:
        return isar_models.ItemType.event;
      case base.ItemType.extra:
        return isar_models.ItemType.extra;
    }
  }
  
  base.ItemType _fromIsarItemType(isar_models.ItemType isarType) {
    switch (isarType) {
      case isar_models.ItemType.character:
        return base.ItemType.character;
      case isar_models.ItemType.location:
        return base.ItemType.location;
      case isar_models.ItemType.prop:
        return base.ItemType.prop;
      case isar_models.ItemType.event:
        return base.ItemType.event;
      case isar_models.ItemType.extra:
        return base.ItemType.extra;
    }
  }
  
  // Project operations
  @override
  Future<void> saveProject(base.Project project) async {
    final isarProject = _toIsarProject(project);
    await _isar.writeTxn(() async {
      await _isar.projects.put(isarProject);
    });
  }
  
  @override
  Future<base.Project?> getProject(String projectId) async {
    final isarProject = await _isar.projects.filter().projectIdEqualTo(projectId).findFirst();
    return isarProject != null ? _fromIsarProject(isarProject) : null;
  }
  
  @override
  Future<List<base.Project>> getAllProjects() async {
    final isarProjects = await _isar.projects.where().findAll();
    return isarProjects.map(_fromIsarProject).toList();
  }
  
  @override
  Future<void> deleteProject(String projectId) async {
    await _isar.writeTxn(() async {
      await _isar.projects.filter().projectIdEqualTo(projectId).deleteAll();
    });
  }
  
  // Scene operations
  @override
  Future<void> saveScene(base.Scene scene) async {
    final isarScene = _toIsarScene(scene);
    await _isar.writeTxn(() async {
      await _isar.scenes.put(isarScene);
    });
  }
  
  @override
  Future<base.Scene?> getScene(String sceneId) async {
    final isarScene = await _isar.scenes.filter().sceneIdEqualTo(sceneId).findFirst();
    return isarScene != null ? _fromIsarScene(isarScene) : null;
  }
  
  @override
  Future<List<base.Scene>> getScenesByProject(String projectId) async {
    final isarScenes = await _isar.scenes.filter().projectIdEqualTo(projectId).findAll();
    return isarScenes.map(_fromIsarScene).toList();
  }
  
  @override
  Future<void> deleteScene(String sceneId) async {
    await _isar.writeTxn(() async {
      await _isar.scenes.filter().sceneIdEqualTo(sceneId).deleteAll();
    });
  }
  
  // Item operations
  @override
  Future<void> saveItem(base.Item item) async {
    final isarItem = _toIsarItem(item);
    await _isar.writeTxn(() async {
      await _isar.items.put(isarItem);
    });
  }
  
  @override
  Future<base.Item?> getItem(String itemId) async {
    final isarItem = await _isar.items.filter().itemIdEqualTo(itemId).findFirst();
    return isarItem != null ? _fromIsarItem(isarItem) : null;
  }
  
  @override
  Future<List<base.Item>> getItemsByProject(String projectId) async {
    final isarItems = await _isar.items.filter().projectIdEqualTo(projectId).findAll();
    return isarItems.map(_fromIsarItem).toList();
  }
  
  @override
  Future<void> deleteItem(String itemId) async {
    await _isar.writeTxn(() async {
      await _isar.items.filter().itemIdEqualTo(itemId).deleteAll();
    });
  }
  
  // Metadata operations
  @override
  Future<void> saveMetadata(base.Metadata metadata) async {
    final isarMetadata = _toIsarMetadata(metadata);
    await _isar.writeTxn(() async {
      await _isar.metadatas.put(isarMetadata);
    });
  }
  
  @override
  Future<base.Metadata?> getMetadata(String metadataId) async {
    final isarMetadata = await _isar.metadatas.filter().metadataIdEqualTo(metadataId).findFirst();
    return isarMetadata != null ? _fromIsarMetadata(isarMetadata) : null;
  }
  
  @override
  Future<List<base.Metadata>> getMetadataByItem(String itemId) async {
    final isarMetadatas = await _isar.metadatas.filter().itemIdEqualTo(itemId).findAll();
    return isarMetadatas.map(_fromIsarMetadata).toList();
  }
  
  @override
  Future<void> deleteMetadata(String metadataId) async {
    await _isar.writeTxn(() async {
      await _isar.metadatas.filter().metadataIdEqualTo(metadataId).deleteAll();
    });
  }
}

// Factory function for mobile/desktop
DatabaseService createDatabaseService() {
  return IsarDatabaseService();
}