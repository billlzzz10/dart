import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/database_service.dart';
import '../data/repos/scene_repo.dart';
import '../data/repos/item_repo.dart';
import '../data/repos/template_repo.dart';

// Database service provider
final databaseServiceProvider = Provider<DatabaseService>((ref) {
  throw UnimplementedError('databaseServiceProvider must be overridden');
});

// Repository providers


final sceneRepoProvider = Provider<SceneRepository>((ref) {
  final databaseService = ref.watch(databaseServiceProvider);
  return SceneRepository(databaseService);
});

final itemRepoProvider = Provider<ItemRepository>((ref) {
  final databaseService = ref.watch(databaseServiceProvider);
  return ItemRepository(databaseService);
});

final templateRepoProvider = Provider<TemplateRepository>((ref) {
  return TemplateRepository();
});