class Project {
  String id;
  String projectId;
  String name;

  String description;
  DateTime createdAt;
  DateTime updatedAt;
  List<String> characterIds;
  List<String> sceneIds;
  List<String> settings;
  String? coverUrl;
  String? emoji;
  String? icon;

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