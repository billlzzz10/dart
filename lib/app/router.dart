import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/dashboard/dashboard_screen.dart';
import '../features/notes/notes_page.dart';

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