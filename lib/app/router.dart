
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/dashboard/dashboard_screen.dart';
import '../features/notes/notes_page.dart';
import '../features/project/project_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'dashboard',
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: '/project/:id',
        name: 'project',
        builder: (context, state) {
          final projectId = state.pathParameters['id'];
          if (projectId != null) {
            return ProjectScreen(projectId: projectId);
          } 
          // TODO: Handle this case, maybe redirect to a 404 page
          return const DashboardScreen();
        },
      ),
      GoRoute(
        path: '/notes/:noteId',
        name: 'notes',
        builder: (context, state) => NotesPage(
          noteId: state.pathParameters['noteId'] ?? 'default',
        ),
      ),
      // Add more routes as needed
    ],
  );
});
