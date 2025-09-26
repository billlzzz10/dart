import 'package:flutter/services.dart';
import 'package:yaml/yaml.dart';
import '../../domain/entities.dart';

/// A repository for managing templates.
///
/// This class provides methods for accessing template data, which is stored
/// in YAML files in the `assets/templates` directory.
class TemplateRepository {
  /// Returns a list of all available templates.
  ///
  /// This method loads all the template files from the `assets/templates`
  /// directory, parses them as YAML, and returns them as a list of [Template]
  /// objects.
  Future<List<Template>> getTemplates() async {
    final templates = <Template>[];

    try {
      // Load character template
      final characterYaml = await rootBundle.loadString('assets/templates/character.template.yaml');
      final characterSchema = loadYaml(characterYaml) as Map;
      templates.add(Template(
        id: 'character_template',
        name: 'Character Template',
        type: ItemType.character,
        schema: Map<String, dynamic>.from(characterSchema),
        createdAt: DateTime.now(),
      ));
    } catch (e) {
      // Template file doesn't exist yet
    }

    try {
      // Load location template
      final locationYaml = await rootBundle.loadString('assets/templates/location.template.yaml');
      final locationSchema = loadYaml(locationYaml) as Map;
      templates.add(Template(
        id: 'location_template',
        name: 'Location Template',
        type: ItemType.location,
        schema: Map<String, dynamic>.from(locationSchema),
        createdAt: DateTime.now(),
      ));
    } catch (e) {
      // Template file doesn't exist yet
    }

    try {
      // Load scene template
      final sceneYaml = await rootBundle.loadString('assets/templates/scene.template.yaml');
      final sceneSchema = loadYaml(sceneYaml) as Map;
      templates.add(Template(
        id: 'scene_template',
        name: 'Scene Template',
        type: ItemType.extra, // Scenes can be considered as extra type
        schema: Map<String, dynamic>.from(sceneSchema),
        createdAt: DateTime.now(),
      ));
    } catch (e) {
      // Template file doesn't exist yet
    }

    return templates;
  }

  /// Returns a template by its ID.
  ///
  /// [templateId] is the ID of the template to fetch.
  /// Returns the template, or `null` if it doesn't exist.
  Future<Template?> getTemplate(String templateId) async {
    final templates = await getTemplates();
    try {
      return templates.firstWhere((t) => t.id == templateId);
    } catch (e) {
      return null;
    }
  }
}