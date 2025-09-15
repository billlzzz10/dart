// Domain entities for Novelist Plus

class Project {
  final String id;
  final String name;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<String> characterIds;
  final List<String> sceneIds;
  final Map<String, dynamic> settings;

  const Project({
    required this.id,
    required this.name,
    this.description = '',
    required this.createdAt,
    required this.updatedAt,
    this.characterIds = const [],
    this.sceneIds = const [],
    this.settings = const {},
  });

  List<String> scenesForCharacter(String characterId) {
    // This would be implemented to find scenes containing a specific character
    return sceneIds.where((sceneId) => true).toList(); // Placeholder
  }

  List<Item> get characters => []; // Placeholder, would be populated from repository
}

class Scene {
  final String id;
  final String projectId;
  final String title;
  final String content;
  final List<String> itemIds;
  final List<String> subplots;
  final Map<String, dynamic> metadata;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Scene({
    required this.id,
    required this.projectId,
    required this.title,
    this.content = '',
    this.itemIds = const [],
    this.subplots = const [],
    this.metadata = const {},
    required this.createdAt,
    required this.updatedAt,
  });
}

class Item {
  final String id;
  final String projectId;
  final String name;
  final ItemType type;
  final String description;
  final List<String> tags;
  final bool starred;
  final List<String> pictureUrls;
  final Map<String, dynamic> metadata;
  final Map<String, List<String>> relationships;
  final String notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Item({
    required this.id,
    required this.projectId,
    required this.name,
    required this.type,
    this.description = '',
    this.tags = const [],
    this.starred = false,
    this.pictureUrls = const [],
    this.metadata = const {},
    this.relationships = const {},
    this.notes = '',
    required this.createdAt,
    required this.updatedAt,
  });
}

enum ItemType {
  character,
  location,
  prop,
  event,
  extra;
}

class Template {
  final String id;
  final String name;
  final ItemType type;
  final Map<String, dynamic> schema;
  final DateTime createdAt;

  const Template({
    required this.id,
    required this.name,
    required this.type,
    required this.schema,
    required this.createdAt,
  });
}

class Metadata {
  final String id;
  final String itemId;
  final Map<String, dynamic> fields;
  final DateTime updatedAt;

  const Metadata({
    required this.id,
    required this.itemId,
    required this.fields,
    required this.updatedAt,
  });
}