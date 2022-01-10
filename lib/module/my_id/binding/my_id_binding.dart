import 'package:base_flutter_framework/module/natural_world/controller/natural_world_controller.dart';
import 'package:get/get.dart';

class MyIdBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<NaturalWorldController>(NaturalWorldController());
  }
}
