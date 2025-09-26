import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/database_service.dart';
import '../data/repos/scene_repo.dart';
import '../data/repos/item_repo.dart';
import '../data/repos/template_repo.dart';

/// This file contains the dependency injection setup for the application.
///
/// It uses Riverpod to provide instances of the database service and repositories
/// to the rest of the application.

/// A provider for the [DatabaseService].
///
/// This provider must be overridden in the main application setup to provide a
/// concrete implementation of the [DatabaseService].
final databaseServiceProvider = Provider<DatabaseService>((ref) {
  throw UnimplementedError('databaseServiceProvider must be overridden');
});

/// A provider for the [SceneRepository].
///
/// This provider creates a [SceneRepository] and depends on the [databaseServiceProvider].
final sceneRepoProvider = Provider<SceneRepository>((ref) {
  final databaseService = ref.watch(databaseServiceProvider);
  return SceneRepository(databaseService);
});

/// A provider for the [ItemRepository].
///
/// This provider creates an [ItemRepository] and depends on the [databaseServiceProvider].
final itemRepoProvider = Provider<ItemRepository>((ref) {
  final databaseService = ref.watch(databaseServiceProvider);
  return ItemRepository(databaseService);
});

/// A provider for the [TemplateRepository].
///
/// This provider creates a [TemplateRepository].
final templateRepoProvider = Provider<TemplateRepository>((ref) {
  return TemplateRepository();
});