// Web stub file to replace Isar imports
// This file provides dummy exports for web builds

class Isar {
  static Future<Isar> open(List<dynamic> schemas, {String? directory, bool? inspector}) async {
    throw UnimplementedError('Isar is not supported on web');
  }
}

class IsarCollection<T> {
  Future<void> put(T object) async {}
  Future<List<T>> where() async => [];
  Future<void> deleteAll() async {}
}

// Dummy schemas
const ProjectSchema = null;
const SceneSchema = null;
const ItemSchema = null;
const MetadataSchema = null;

// Dummy path provider
class Directory {
  final String path;
  Directory(this.path);
}

Future<Directory> getApplicationDocumentsDirectory() async {
  return Directory('');
}