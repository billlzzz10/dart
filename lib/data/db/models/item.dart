import 'package:isar/isar.dart';

part 'item.g.dart';

/// Represents an item in the Isar database.
@collection
class Item {
  /// The unique identifier for the item in the Isar database.
  Id id = Isar.autoIncrement;

  /// The unique identifier for the item.
  @Index()
  late String itemId;

  /// The ID of the project this item belongs to.
  @Index()
  late String projectId;

  /// The name of the item.
  @Index()
  late String name;

  /// The type of the item.
  @Enumerated(EnumType.name)
  late ItemType type;

  /// A description of the item.
  String description = '';

  /// A list of tags associated with the item.
  List<String> tags = [];

  /// Whether the item is starred.
  bool starred = false;

  /// A list of picture URLs for the item.
  List<String> pictureUrls = [];

  /// A list of metadata associated with the item.
  List<String> metadata = [];

  /// A list of relationships between this item and other items.
  List<String> relationships = [];

  /// Notes for the item.
  String notes = '';

  /// The date and time the item was created.
  @Index()
  late DateTime createdAt;

  /// The date and time the item was last updated.
  late DateTime updatedAt;

  /// Creates a new [Item] instance.
  Item();

  /// Creates a new [Item] instance with the given data.
  ///
  /// [itemId] is the unique identifier for the item.
  /// [projectId] is the ID of the project this item belongs to.
  /// [name] is the name of the item.
  /// [type] is the type of the item.
  /// [description] is a description of the item.
  /// [tags] is a list of tags associated with the item.
  /// [starred] is whether the item is starred.
  /// [pictureUrls] is a list of picture URLs for the item.
  /// [metadata] is a list of metadata associated with the item.
  /// [relationships] is a list of relationships between this item and other items.
  /// [notes] is notes for the item.
  /// [createdAt] is the date and time the item was created.
  /// [updatedAt] is the date and time the item was last updated.
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