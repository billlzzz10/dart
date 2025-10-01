// Domain entities for Novelist Plus

/// A class that represents a project in the Novelist Plus app.
class Project {
  /// The unique identifier for the project.
  final String id;

  /// The name of the project.
  final String name;

  /// A description of the project.
  final String description;

  /// The date and time the project was created.
  final DateTime createdAt;

  /// The date and time the project was last updated.
  final DateTime updatedAt;

  /// A list of character IDs associated with the project.
  final List<String> characterIds;

  /// A list of scene IDs associated with the project.
  final List<String> sceneIds;

  /// A map of settings for the project.
  final Map<String, dynamic> settings;

  /// Creates a new [Project] instance.
  ///
  /// [id] is the unique identifier for the project.
  /// [name] is the name of the project.
  /// [description] is a description of the project.
  /// [createdAt] is the date and time the project was created.
  /// [updatedAt] is the date and time the project was last updated.
  /// [characterIds] is a list of character IDs associated with the project.
  /// [sceneIds] is a list of scene IDs associated with the project.
  /// [settings] is a map of settings for the project.
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

  /// Returns a list of scene IDs for a given character ID.
  ///
  /// This is a placeholder and would be implemented to find scenes containing a specific character.
  ///
  /// [characterId] is the ID of the character to find scenes for.
  /// Returns a list of scene IDs.
  List<String> scenesForCharacter(String characterId) {
    // This would be implemented to find scenes containing a specific character
    return sceneIds.where((sceneId) => true).toList(); // Placeholder
  }

  /// A list of characters in the project.
  ///
  /// This is a placeholder and would be populated from a repository.
  List<Item> get characters => []; // Placeholder, would be populated from repository
}

/// A class that represents a scene in a project.
class Scene {
  /// The unique identifier for the scene.
  final String id;

  /// The ID of the project this scene belongs to.
  final String projectId;

  /// The title of the scene.
  final String title;

  /// The content of the scene.
  final String content;

  /// A list of item IDs associated with the scene.
  final List<String> itemIds;

  /// A list of subplots associated with the scene.
  final List<String> subplots;

  /// A map of metadata for the scene.
  final Map<String, dynamic> metadata;

  /// The date and time the scene was created.
  final DateTime createdAt;

  /// The date and time the scene was last updated.
  final DateTime updatedAt;

  /// Creates a new [Scene] instance.
  ///
  /// [id] is the unique identifier for the scene.
  /// [projectId] is the ID of the project this scene belongs to.
  /// [title] is the title of the scene.
  /// [content] is the content of the scene.
  /// [itemIds] is a list of item IDs associated with the scene.
  /// [subplots] is a list of subplots associated with the scene.
  /// [metadata] is a map of metadata for the scene.
  /// [createdAt] is the date and time the scene was created.
  /// [updatedAt] is the date and time the scene was last updated.
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

/// A class that represents an item in a project, such as a character, location, or prop.
class Item {
  /// The unique identifier for the item.
  final String id;

  /// The ID of the project this item belongs to.
  final String projectId;

  /// The name of the item.
  final String name;

  /// The type of the item.
  final ItemType type;

  /// A description of the item.
  final String description;

  /// A list of tags associated with the item.
  final List<String> tags;

  /// Whether the item is starred.
  final bool starred;

  /// A list of picture URLs for the item.
  final List<String> pictureUrls;

  /// A map of metadata for the item.
  final Map<String, dynamic> metadata;

  /// A map of relationships between this item and other items.
  final Map<String, List<String>> relationships;

  /// Notes for the item.
  final String notes;

  /// The date and time the item was created.
  final DateTime createdAt;

  /// The date and time the item was last updated.
  final DateTime updatedAt;

  /// Creates a new [Item] instance.
  ///
  /// [id] is the unique identifier for the item.
  /// [projectId] is the ID of the project this item belongs to.
  /// [name] is the name of the item.
  /// [type] is the type of the item.
  /// [description] is a description of the item.
  /// [tags] is a list of tags associated with the item.
  /// [starred] is whether the item is starred.
  /// [pictureUrls] is a list of picture URLs for the item.
  /// [metadata] is a map of metadata for the item.
  /// [relationships] is a map of relationships between this item and other items.
  /// [notes] is notes for the item.
  /// [createdAt] is the date and time the item was created.
  /// [updatedAt] is the date and time the item was last updated.
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

/// An enum that represents the type of an item.
enum ItemType {
  /// A character in the story.
  character,

  /// A location in the story.
  location,

  /// A prop in the story.
  prop,

  /// An event in the story.
  event,

  /// An extra item in the story.
  extra;
}

/// A class that represents a template for an item.
class Template {
  /// The unique identifier for the template.
  final String id;

  /// The name of the template.
  final String name;

  /// The type of the item this template is for.
  final ItemType type;

  /// The schema for the template.
  final Map<String, dynamic> schema;

  /// The date and time the template was created.
  final DateTime createdAt;

  /// Creates a new [Template] instance.
  ///
  /// [id] is the unique identifier for the template.
  /// [name] is the name of the template.
  /// [type] is the type of the item this template is for.
  /// [schema] is the schema for the template.
  /// [createdAt] is the date and time the template was created.
  const Template({
    required this.id,
    required this.name,
    required this.type,
    required this.schema,
    required this.createdAt,
  });
}

/// A class that represents metadata for an item.
class Metadata {
  /// The unique identifier for the metadata.
  final String id;

  /// The ID of the item this metadata belongs to.
  final String itemId;

  /// The fields for the metadata.
  final Map<String, dynamic> fields;

  /// The date and time the metadata was last updated.
  final DateTime updatedAt;

  /// Creates a new [Metadata] instance.
  ///
  /// [id] is the unique identifier for the metadata.
  /// [itemId] is the ID of the item this metadata belongs to.
  /// [fields] is the fields for the metadata.
  /// [updatedAt] is the date and time the metadata was last updated.
  const Metadata({
    required this.id,
    required this.itemId,
    required this.fields,
    required this.updatedAt,
  });
}