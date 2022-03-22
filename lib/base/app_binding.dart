import 'package:base_flutter_framework/module/my_id/controller/my_id_controller.dart';
import 'package:base_flutter_framework/module/natural_world/controller/natural_world_controller.dart';
import 'package:base_flutter_framework/module/scan_image/controller/scan_image_controller.dart';
import 'package:base_flutter_framework/module/setting/controller/setting_controller.dart';
import 'package:base_flutter_framework/routes/app_pages.dart';
import 'package:get/get.dart';

import '../network/bindings/network_binding.dart';

class AppBinding extends Bindings {
  @override
  Future<void> dependencies() async {
    Get..put(NetworkBinding(), permanent: true);
    Get.lazyPut<NaturalWorldController>(() => NaturalWorldController(),
        tag: Routes.NATURAL_WORLD, fenix: true);

    Get.lazyPut<SettingController>(() => SettingController(),
        tag: Routes.SETTING, fenix: true);
    Get.lazyPut<ScanController>(() => ScanController(),
        tag: Routes.SCAN, fenix: true);

    Get.lazyPut<MyIdController>(() => MyIdController(),
        tag: Routes.MYID, fenix: true);
  }
}
