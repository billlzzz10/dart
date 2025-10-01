import 'package:isar/isar.dart';

part 'metadata.g.dart';

/// Represents metadata for an item in the Isar database.
@collection
class Metadata {
  /// The unique identifier for the metadata in the Isar database.
  Id id = Isar.autoIncrement;

  /// The unique identifier for the metadata.
  @Index()
  late String metadataId;

  /// The ID of the item this metadata belongs to.
  @Index()
  late String itemId;

  /// The fields for the metadata.
  List<String> fields = [];

  /// The date and time the metadata was last updated.
  @Index()
  late DateTime updatedAt;

  /// Creates a new [Metadata] instance.
  Metadata();

  /// Creates a new [Metadata] instance with the given data.
  ///
  /// [metadataId] is the unique identifier for the metadata.
  /// [itemId] is the ID of the item this metadata belongs to.
  /// [fields] is the fields for the metadata.
  /// [updatedAt] is the date and time the metadata was last updated.
  Metadata.create({
    required this.metadataId,
    required this.itemId,
    required this.fields,
    DateTime? updatedAt,
  }) {
    this.updatedAt = updatedAt ?? DateTime.now();
  }
}