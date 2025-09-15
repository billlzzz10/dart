import 'package:isar/isar.dart';

part 'scene.g.dart';

@collection
class Scene {
  Id id = Isar.autoIncrement;

  @Index()
  late String sceneId;

  @Index()
  late String projectId;

  @Index()
  late String title;

  String content = '';

  List<String> itemIds = [];

  List<String> subplots = [];

  List<String> metadata = [];

  @Index()
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