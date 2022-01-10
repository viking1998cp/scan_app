import 'package:base_flutter_framework/module/natural_image/controller/natural_image_controller.dart';
import 'package:get/get.dart';

class NaturalImageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<NaturalImageController>(NaturalImageController());
  }
}
