
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:novelist_plus/data/db/models/project.dart';
import 'package:novelist_plus/widgets/project_card.dart';

void main() {
  group('ProjectCard Widget Tests', () {
    late Project testProject;

    setUp(() {
      testProject = Project.create(
        projectId: 'test-1',
        name: 'Test Project',
        description: 'A test project for unit testing',
        coverUrl: 'https://example.com/image.jpg',
        emoji: '📚',
        icon: 'book-open',
      );
      testProject.tags = ['fantasy', 'adventure'];
    });

    testWidget('should display project title', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProjectCard(project: testProject),
          ),
        ),
      );

      expect(find.text('Test Project'), findsOneWidget);
    });

    testWidget('should display project description', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProjectCard(project: testProject),
          ),
        ),
      );

      expect(find.text('A test project for unit testing'), findsOneWidget);
    });

    testWidget('should display project tags', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProjectCard(project: testProject),
          ),
        ),
      );

      expect(find.text('fantasy'), findsOneWidget);
      expect(find.text('adventure'), findsOneWidget);
    });

    testWidget('should display emoji when provided', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProjectCard(project: testProject),
          ),
        ),
      );

      expect(find.text('📚'), findsOneWidget);
    });

    testWidget('should call onTap when tapped', (WidgetTester tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProjectCard(
              project: testProject,
              onTap: () => tapped = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(ProjectCard));
      expect(tapped, isTrue);
    });

    testWidget('should handle project without description', (WidgetTester tester) async {
      final projectWithoutDesc = Project.create(
        projectId: 'test-2',
        name: 'No Description Project',
        description: '',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProjectCard(project: projectWithoutDesc),
          ),
        ),
      );

      expect(find.text('No Description Project'), findsOneWidget);
      expect(find.text(''), findsNothing);
    });
  });
}
