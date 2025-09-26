import 'package:isar/isar.dart';

part 'scene.g.dart';

/// Represents a scene in the Isar database.
@collection
class Scene {
  /// The unique identifier for the scene in the Isar database.
  Id id = Isar.autoIncrement;

  /// The unique identifier for the scene.
  @Index()
  late String sceneId;

  /// The ID of the project this scene belongs to.
  @Index()
  late String projectId;

  /// The title of the scene.
  @Index()
  late String title;

  /// The content of the scene.
  String content = '';

  /// A list of item IDs associated with the scene.
  List<String> itemIds = [];

  /// A list of subplots associated with the scene.
  List<String> subplots = [];

  /// A list of metadata associated with the scene.
  List<String> metadata = [];

  /// The date and time the scene was created.
  @Index()
  late DateTime createdAt;

  /// The date and time the scene was last updated.
  late DateTime updatedAt;

  /// Creates a new [Scene] instance.
  Scene();

  /// Creates a new [Scene] instance with the given data.
  ///
  /// [sceneId] is the unique identifier for the scene.
  /// [projectId] is the ID of the project this scene belongs to.
  /// [title] is the title of the scene.
  /// [content] is the content of the scene.
  /// [itemIds] is a list of item IDs associated with the scene.
  /// [subplots] is a list of subplots associated with the scene.
  /// [metadata] is a list of metadata associated with the scene.
  /// [createdAt] is the date and time the scene was created.
  /// [updatedAt] is the date and time the scene was last updated.
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