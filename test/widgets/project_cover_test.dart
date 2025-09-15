
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:novelist_plus/data/db/models/project.dart';
import 'package:novelist_plus/widgets/project_cover.dart';

void main() {
  group('ProjectCover Widget Tests', () {
    testWidget('should display network image when coverUrl is provided', (WidgetTester tester) async {
      final project = Project.create(
        projectId: 'test-1',
        name: 'Test Project',
        coverUrl: 'https://example.com/image.jpg',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProjectCover(project: project),
          ),
        ),
      );

      expect(find.byType(Image), findsOneWidget);
    });

    testWidget('should display fallback with emoji', (WidgetTester tester) async {
      final project = Project.create(
        projectId: 'test-2',
        name: 'Emoji Project',
        emoji: '🎭',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProjectCover(project: project),
          ),
        ),
      );

      expect(find.text('🎭'), findsOneWidget);
    });

    testWidget('should display fallback with icon', (WidgetTester tester) async {
      final project = Project.create(
        projectId: 'test-3',
        name: 'Icon Project',
        icon: 'book-open',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProjectCover(project: project),
          ),
        ),
      );

      expect(find.byType(Icon), findsOneWidget);
    });

    testWidget('should display default fallback', (WidgetTester tester) async {
      final project = Project.create(
        projectId: 'test-4',
        name: 'Default Project',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProjectCover(project: project),
          ),
        ),
      );

      expect(find.byType(Icon), findsOneWidget);
      expect(find.byType(Container), findsWidgets);
    });

    testWidget('should respect custom height', (WidgetTester tester) async {
      final project = Project.create(
        projectId: 'test-5',
        name: 'Custom Height Project',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProjectCover(
              project: project,
              height: 200,
            ),
          ),
        ),
      );

      final containerWidget = tester.widget<Container>(
        find.byType(Container).first,
      );
      expect(containerWidget.constraints?.maxHeight, 200);
    });
  });
}
