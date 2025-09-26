/// This file provides stub implementations for Isar and path_provider, which are not
/// available on the web. This allows the mobile database service to be compiled
/// for the web without errors, even though it is not used.
library database_service_web_stub;

/// A stub implementation of the Isar class.
class Isar {
  /// Throws an [UnimplementedError] because Isar is not supported on the web.
  static Future<Isar> open(List<dynamic> schemas, {String? directory, bool? inspector}) async {
    throw UnimplementedError('Isar is not supported on web');
  }
}

/// A stub implementation of the IsarCollection class.
class IsarCollection<T> {
  /// Does nothing.
  Future<void> put(T object) async {}

  /// Returns an empty list.
  Future<List<T>> where() async => [];

  /// Does nothing.
  Future<void> deleteAll() async {}
}

/// A dummy schema for the Project model.
const ProjectSchema = null;

/// A dummy schema for the Scene model.
const SceneSchema = null;

/// A dummy schema for the Item model.
const ItemSchema = null;

/// A dummy schema for the Metadata model.
const MetadataSchema = null;

/// A stub implementation of the Directory class.
class Directory {
  /// The path of the directory.
  final String path;

  /// Creates a new [Directory] instance.
  Directory(this.path);
}

/// A stub implementation of the getApplicationDocumentsDirectory function.
///
/// Returns a [Directory] with an empty path.
Future<Directory> getApplicationDocumentsDirectory() async {
  return Directory('');
}