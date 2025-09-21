
import 'package:flutter_test/flutter_test.dart';
import 'package:novelist_plus/data/db/models/project.dart';

void main() {
  group('Project Model Tests', () {
    test('should create project with required fields', () {
      final project = Project.create(
        projectId: 'test-project-1',
        name: 'Test Project',
      );

      expect(project.projectId, 'test-project-1');
      expect(project.name, 'Test Project');
      expect(project.description, isEmpty);
      expect(project.characterIds, isEmpty);
      expect(project.sceneIds, isEmpty);
      expect(project.settings, isEmpty);
    });

    test('should create project with all fields', () {
      final now = DateTime.now();
      final project = Project.create(
        projectId: 'full-project-1',
        name: 'Full Test Project',
        description: 'A complete test project',
        createdAt: now,
        updatedAt: now,
        characterIds: ['char1', 'char2'],
        sceneIds: ['scene1', 'scene2'],
        settings: ['setting1'],
        coverUrl: 'https://example.com/cover.jpg',
        emoji: '📖',
        icon: 'book-open',
      );

      expect(project.projectId, 'full-project-1');
      expect(project.name, 'Full Test Project');
      expect(project.description, 'A complete test project');
      expect(project.createdAt, now);
      expect(project.updatedAt, now);
      expect(project.characterIds, ['char1', 'char2']);
      expect(project.sceneIds, ['scene1', 'scene2']);
      expect(project.settings, ['setting1']);
      expect(project.coverUrl, 'https://example.com/cover.jpg');
      expect(project.emoji, '📖');
      expect(project.icon, 'book-open');
    });

    test('should set default timestamps when not provided', () {
      final before = DateTime.now();
      final project = Project.create(
        projectId: 'timestamp-test',
        name: 'Timestamp Test',
      );
      final after = DateTime.now();

      expect(project.createdAt.isAfter(before.subtract(const Duration(seconds: 1))), isTrue);
      expect(project.createdAt.isBefore(after.add(const Duration(seconds: 1))), isTrue);
      expect(project.updatedAt.isAfter(before.subtract(const Duration(seconds: 1))), isTrue);
      expect(project.updatedAt.isBefore(after.add(const Duration(seconds: 1))), isTrue);
    });

    test('should handle optional cover properties', () {
      final projectWithCover = Project.create(
        projectId: 'cover-test-1',
        name: 'Cover Test',
        coverUrl: 'test.jpg',
      );

      final projectWithEmoji = Project.create(
        projectId: 'cover-test-2',
        name: 'Emoji Test',
        emoji: '🎭',
      );

      final projectWithIcon = Project.create(
        projectId: 'cover-test-3',
        name: 'Icon Test',
        icon: 'star',
      );

      expect(projectWithCover.coverUrl, 'test.jpg');
      expect(projectWithCover.emoji, isNull);
      expect(projectWithCover.icon, isNull);

      expect(projectWithEmoji.coverUrl, isNull);
      expect(projectWithEmoji.emoji, '🎭');
      expect(projectWithEmoji.icon, isNull);

      expect(projectWithIcon.coverUrl, isNull);
      expect(projectWithIcon.emoji, isNull);
      expect(projectWithIcon.icon, 'star');
    });
  });
}
