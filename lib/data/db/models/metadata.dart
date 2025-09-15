import 'package:isar/isar.dart';

part 'metadata.g.dart';

@collection
class Metadata {
  Id id = Isar.autoIncrement;

  @Index()
  late String metadataId;

  @Index()
  late String itemId;

  List<String> fields = [];

  @Index()
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