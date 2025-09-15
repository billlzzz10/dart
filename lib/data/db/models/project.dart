import 'package:isar/isar.dart';

part 'project.g.dart';

@collection
class Project {
  Id id = Isar.autoIncrement;

  @Index()
  late String projectId;

  @Index()
  late String name;

  String description = '';

  late DateTime createdAt;

  late DateTime updatedAt;

  List<String> characterIds = [];

  List<String> sceneIds = [];

  List<String> settings = [];

  String? coverUrl;
  String? emoji;
  String? icon;

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
    this.coverUrl,
    this.emoji,
    this.icon,
  }) {
    final now = DateTime.now();
    this.createdAt = createdAt ?? now;
    this.updatedAt = updatedAt ?? now;
  }
}