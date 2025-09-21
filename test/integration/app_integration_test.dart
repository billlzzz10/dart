
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:novelist_plus/data/db/models/project.dart';
import 'package:novelist_plus/data/repos/project_repo.dart';
import 'package:novelist_plus/features/dashboard/dashboard_screen.dart';
import 'package:novelist_plus/widgets/project_card.dart';

void main() {
  group('App Integration Tests', () {
    testWidgets('should display and interact with projects on dashboard', (WidgetTester tester) async {
      final mockProjects = [
        Project.create(
          projectId: 'integration-1',
          name: 'Integration Test Project',
          description: 'Testing full app flow',
          emoji: '🧪',
        ),
      ];

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            projectRepoProvider.overrideWith((ref) => MockProjectRepo(mockProjects)),
          ],
          child: const MaterialApp(
            home: DashboardScreen(),
          ),
        ),
      );

      // Verify dashboard loads
      expect(find.text('Novelist Plus'), findsOneWidget);
      
      // Verify project appears
      expect(find.text('Integration Test Project'), findsOneWidget);
      expect(find.text('Testing full app flow'), findsOneWidget);
      expect(find.text('🧪'), findsOneWidget);

      // Verify project card is tappable
      expect(find.byType(ProjectCard), findsOneWidget);
      
      // Test project card interaction
      await tester.tap(find.byType(ProjectCard));
      await tester.pumpAndSettle();
      
      // Note: In real integration tests, we would verify navigation
      // For now, we just verify the tap doesn't cause errors
    });

    testWidgets('should handle empty state gracefully', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            projectRepoProvider.overrideWith((ref) => MockProjectRepo([])),
          ],
          child: const MaterialApp(
            home: DashboardScreen(),
          ),
        ),
      );

      // Verify app loads without projects
      expect(find.text('Novelist Plus'), findsOneWidget);
      expect(find.byType(ProjectCard), findsNothing);
    });

    testWidgets('should display multiple projects in grid', (WidgetTester tester) async {
      final mockProjects = List.generate(6, (index) => 
        Project.create(
          projectId: 'project-$index',
          name: 'Project ${index + 1}',
          description: 'Description for project ${index + 1}',
          emoji: ['📚', '⚔️', '🚀', '🎭', '🔬', '🎨'][index],
        ),
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            projectRepoProvider.overrideWith((ref) => MockProjectRepo(mockProjects)),
          ],
          child: const MaterialApp(
            home: DashboardScreen(),
          ),
        ),
      );

      // Verify all projects are displayed
      for (int i = 0; i < 6; i++) {
        expect(find.text('Project ${i + 1}'), findsOneWidget);
      }

      expect(find.byType(ProjectCard), findsNWidgets(6));
    });
  });
}

class MockProjectRepo {
  final List<Project> _projects;
  
  MockProjectRepo(this._projects);
  
  List<Project> getProjects() => _projects;
}
