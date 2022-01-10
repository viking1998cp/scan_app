import 'package:base_flutter_framework/components/bindings/network_binding.dart';
import 'package:base_flutter_framework/module/natural_world/controller/natural_world_controller.dart';

import 'package:base_flutter_framework/module/scan_image/controller/scan_image_controller.dart';
import 'package:base_flutter_framework/module/setting/controller/setting_controller.dart';
import 'package:base_flutter_framework/routes/app_pages.dart';
import 'package:get/get.dart';

class AppBinding extends Bindings {
  @override
  Future<void> dependencies() async {
    Get..put(NetworkBinding(), permanent: true);
    Get.lazyPut<NaturalWorldController>(() => NaturalWorldController(),
        tag: Routes.NATURAL_WORLD);

    Get.lazyPut<SettingController>(() => SettingController(),
        tag: Routes.SETTING);
    Get.lazyPut<ScanController>(() =>
        ScanController()); // keep the class in memory with "permanent:true"
  }
}
