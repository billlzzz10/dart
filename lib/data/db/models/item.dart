import 'package:isar/isar.dart';

part 'item.g.dart';

@collection
class Item {
  Id id = Isar.autoIncrement;

  @Index()
  late String itemId;

  @Index()
  late String projectId;

  @Index()
  late String name;

  @Enumerated(EnumType.name)
  late ItemType type;

  String description = '';

  List<String> tags = [];

  bool starred = false;

  List<String> pictureUrls = [];

  List<String> metadata = [];

  List<String> relationships = [];

  String notes = '';

  @Index()
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