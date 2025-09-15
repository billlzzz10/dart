
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:novelist_plus/data/db/models/project.dart';
import 'package:novelist_plus/data/repos/project_repo.dart';
import 'package:novelist_plus/features/dashboard/dashboard_screen.dart';

void main() {
  group('DashboardScreen Tests', () {
    late List<Project> mockProjects;

    setUp(() {
      mockProjects = [
        Project.create(
          projectId: 'project-1',
          name: 'Fantasy Novel',
          description: 'An epic fantasy adventure',
          emoji: '⚔️',
        ),
        Project.create(
          projectId: 'project-2',
          name: 'Sci-Fi Story',
          description: 'A space exploration tale',
          icon: 'globe',
        ),
      ];
    });

    testWidget('should display app title', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            projectRepoProvider.overrideWith((ref) => MockProjectRepo(mockProjects)),
          ],
          child: MaterialApp(
            home: const DashboardScreen(),
          ),
        ),
      );

      expect(find.text('Novelist Plus'), findsOneWidget);
    });

    testWidget('should display project cards', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            projectRepoProvider.overrideWith((ref) => MockProjectRepo(mockProjects)),
          ],
          child: MaterialApp(
            home: const DashboardScreen(),
          ),
        ),
      );

      expect(find.text('Fantasy Novel'), findsOneWidget);
      expect(find.text('Sci-Fi Story'), findsOneWidget);
    });

    testWidget('should handle empty project list', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            projectRepoProvider.overrideWith((ref) => MockProjectRepo([])),
          ],
          child: MaterialApp(
            home: const DashboardScreen(),
          ),
        ),
      );

      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text('Novelist Plus'), findsOneWidget);
    });
  });
}

class MockProjectRepo {
  final List<Project> _projects;
  
  MockProjectRepo(this._projects);
  
  List<Project> getProjects() => _projects;
}
