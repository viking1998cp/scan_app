import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'models/image_cache_model.dart';

class HiveDatabase {
  late final Box<ImageCacheModel> imageCacheBox;

  static HiveDatabase? instance;
  static HiveDatabase getInstance() {
    if (instance == null) {
      instance = HiveDatabase();
    }
    return instance!;
  }

  HiveDatabase();

  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    Hive
      ..init(dir.path)
      ..registerAdapter(ImageCacheModelAdapter());
  }
}
