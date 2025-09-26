import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/theme.dart';
import 'app/router.dart';
import 'core/di.dart';
import 'data/database_service.dart';

/// The main entry point for the application.
///
/// This function initializes the database service and runs the app.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize platform-specific database service
  final databaseService = createDatabaseService();
  await databaseService.initialize();

  runApp(
    ProviderScope(
      overrides: [
        databaseServiceProvider.overrideWithValue(databaseService),
      ],
      child: const NovelistPlusApp(),
    ),
  );
}

/// The root widget of the application.
///
/// This widget sets up the `MaterialApp` and provides the router and themes.
class NovelistPlusApp extends ConsumerWidget {
  /// Creates a new [NovelistPlusApp] instance.
  const NovelistPlusApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'Novelist Plus',
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.system,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}