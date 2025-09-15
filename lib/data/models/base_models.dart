// Base model classes without Isar annotations
// These are used for web builds to avoid Isar-specific code

class Project {
  int id = 0;
  late String projectId;
  late String name;
  String description = '';
  late DateTime createdAt;
  late DateTime updatedAt;
  List<String> characterIds = [];
  List<String> sceneIds = [];
  List<String> settings = [];

  Project();

  Project.create({
    required this.projectId,
    required this.name,
    this.description = '',
    DateTime? createdAt,
    DateTime? updatedAt,
    this.characterIds = const [],
    this.sceneIds = const [],
    this.settings = const [],
  }) {
    final now = DateTime.now();
    this.createdAt = createdAt ?? now;
    this.updatedAt = updatedAt ?? now;
  }
}

class Scene {
  int id = 0;
  late String sceneId;
  late String projectId;
  late String title;
  String content = '';
  List<String> itemIds = [];
  List<String> subplots = [];
  List<String> metadata = [];
  late DateTime createdAt;
  late DateTime updatedAt;

  Scene();

  Scene.create({
    required this.sceneId,
    required this.projectId,
    required this.title,
    this.content = '',
    this.itemIds = const [],
    this.subplots = const [],
    this.metadata = const [],
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    final now = DateTime.now();
    this.createdAt = createdAt ?? now;
    this.updatedAt = updatedAt ?? now;
  }
}

class Item {
  int id = 0;
  late String itemId;
  late String projectId;
  late String name;
  late ItemType type;
  String description = '';
  List<String> tags = [];
  bool starred = false;
  List<String> pictureUrls = [];
  List<String> metadata = [];
  List<String> relationships = [];
  String notes = '';
  late DateTime createdAt;
  late DateTime updatedAt;

  Item();

  Item.create({
    required this.itemId,
    required this.projectId,
    required this.name,
    required this.type,
    this.description = '',
    this.tags = const [],
    this.starred = false,
    this.pictureUrls = const [],
    this.metadata = const [],
    this.relationships = const [],
    this.notes = '',
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    final now = DateTime.now();
    this.createdAt = createdAt ?? now;
    this.updatedAt = updatedAt ?? now;
  }
}

enum ItemType {
  character,
  location,
  prop,
  event,
  extra;
}

class Metadata {
  int id = 0;
  late String metadataId;
  late String itemId;
  List<String> fields = [];
  late DateTime updatedAt;

  Metadata();

  Metadata.create({
    required this.metadataId,
    required this.itemId,
    required this.fields,
    DateTime? updatedAt,
  }) {
    this.updatedAt = updatedAt ?? DateTime.now();
  }
}