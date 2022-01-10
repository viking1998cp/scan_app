import 'package:base_flutter_framework/module/my_id/controller/my_id_controller.dart';
import 'package:base_flutter_framework/module/natural_image/controller/natural_image_controller.dart';
import 'package:base_flutter_framework/module/natural_world/controller/natural_world_controller.dart';
import 'package:base_flutter_framework/module/scan_image/controller/scan_image_controller.dart';
import 'package:base_flutter_framework/module/search/controller/search_controller.dart';
import 'package:base_flutter_framework/module/setting/controller/setting_controller.dart';
import 'package:base_flutter_framework/services/storage_service.dart';
import 'package:base_flutter_framework/utils/hive_database/dao/image_cache_dao.dart';
import 'package:base_flutter_framework/utils/hive_database/hive_database.dart';
import 'package:base_flutter_framework/utils/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:native_admob_flutter/native_admob_flutter.dart';

import 'package:path_provider/path_provider.dart';

class DependencyInjection {
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    // Initialize without device test ids.
    await MobileAds.initialize();
    await HiveDatabase.getInstance().init();
    await Shared.getInstance().getColor();
    await Shared.getInstance().getLayOutScreen();
    await Shared.getInstance().getLikeData();
    await Shared.getInstance().getCollection();
    Get.lazyPut<StorageService>(() => StorageService());
    Get.lazyPut<ScanController>(() => ScanController());
    Get.lazyPut<NaturalWorldController>(() => NaturalWorldController());
    Get.lazyPut<NaturalImageController>(() => NaturalImageController());
    Get.lazyPut<SearchController>(() => SearchController());
    Get.lazyPut<SettingController>(() => SettingController());
    Get.lazyPut<MyIdController>(() => MyIdController());
    NaturalWorldController naturalWorldController = Get.find();
    naturalWorldController.getListNameItem();
    NaturalImageController naturalImageController = Get.find();
    naturalImageController.getData();
    MyIdController myIdController = Get.find();
    myIdController.bannerController.load();
  }
}
