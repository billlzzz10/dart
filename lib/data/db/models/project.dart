/// Represents a project in the Isar database.
class Project {
  /// The unique identifier for the project.
  String id;

  /// The project's unique identifier.
  String projectId;

  /// The name of the project.
  String name;

  /// A description of the project.
  String description;

  /// The date and time the project was created.
  DateTime createdAt;

  /// The date and time the project was last updated.
  DateTime updatedAt;

  /// A list of character IDs associated with the project.
  List<String> characterIds;

  /// A list of scene IDs associated with the project.
  List<String> sceneIds;

  /// A list of settings for the project.
  List<String> settings;

  /// The URL of the project's cover image.
  String? coverUrl;

  /// The emoji associated with the project.
  String? emoji;

  /// The icon associated with the project.
  String? icon;

  /// Creates a new [Project] instance.
  ///
  /// [id] is the unique identifier for the project.
  /// [projectId] is the project's unique identifier.
  /// [name] is the name of the project.
  /// [description] is a description of the project.
  /// [createdAt] is the date and time the project was created.
  /// [updatedAt] is the date and time the project was last updated.
  /// [characterIds] is a list of character IDs associated with the project.
  /// [sceneIds] is a list of scene IDs associated with the project.
  /// [settings] is a list of settings for the project.
  /// [coverUrl] is the URL of the project's cover image.
  /// [emoji] is the emoji associated with the project.
  /// [icon] is the icon associated with the project.
  Project({
    required this.id,
    required this.projectId,
    required this.name,
    this.description = '',
    DateTime? createdAt,
    DateTime? updatedAt,
    this.characterIds = const [],
    this.sceneIds = const [],
    this.settings = const [],
    this.coverUrl,
    this.emoji,
    this.icon,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  /// Creates a new [Project] instance with a generated ID.
  ///
  /// [projectId] is the project's unique identifier.
  /// [name] is the name of the project.
  /// [description] is a description of the project.
  /// [createdAt] is the date and time the project was created.
  /// [updatedAt] is the date and time the project was last updated.
  /// [characterIds] is a list of character IDs associated with the project.
  /// [sceneIds] is a list of scene IDs associated with the project.
  /// [settings] is a list of settings for the project.
  /// [coverUrl] is the URL of the project's cover image.
  /// [emoji] is the emoji associated with the project.
  /// [icon] is the icon associated with the project.
  Project.create({
    required this.projectId,
    required this.name,
    this.description = '',
    DateTime? createdAt,
    DateTime? updatedAt,
    this.characterIds = const [],
    this.sceneIds = const [],
    this.settings = const [],
    this.coverUrl,
    this.emoji,
    this.icon,
  }) : id = DateTime.now().millisecondsSinceEpoch.toString(),
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();
}