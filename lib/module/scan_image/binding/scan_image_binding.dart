import 'package:base_flutter_framework/base/base_binding.dart';
import 'package:base_flutter_framework/module/scan_image/controller/scan_image_controller.dart';
import 'package:get/get.dart';

class ScanBinding extends BaseBinding {
  @override
  void dependencies() async {
    super.dependencies();
    Get.lazyPut<ScanController>(() => ScanController());
  }
}
