import 'package:base_flutter_framework/module/search/controller/search_controller.dart';
import 'package:get/get.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut<SearchController>(() => SearchController());
  }
}
