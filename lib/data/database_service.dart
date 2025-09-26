/// This file exports the appropriate database service based on the platform.
///
/// It exports the `database_service_interface.dart` file, which defines the
/// abstract `DatabaseService` class. It then uses a conditional export to
/// provide the correct implementation of the `DatabaseService`:
///
/// - If the app is running on a platform that has access to `dart:io` (i.e., mobile or desktop),
///   it exports `database_service_mobile.dart`, which contains the `IsarDatabaseService`.
/// - Otherwise (i.e., on the web), it exports `database_service_web.dart`, which
///   contains the `WebDatabaseService`.
library database_service;

export 'database_service_interface.dart';
export 'database_service_web.dart' if (dart.library.io) 'database_service_mobile.dart';