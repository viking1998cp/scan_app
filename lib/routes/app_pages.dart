import 'package:base_flutter_framework/module/home/binding/home_binding.dart';
import 'package:base_flutter_framework/module/home/view/home_screen.dart';
import 'package:base_flutter_framework/module/my_id/binding/my_id_binding.dart';
import 'package:base_flutter_framework/module/my_id/view/my_id_screen.dart';
import 'package:base_flutter_framework/module/natural_image/binding/natural_image_binding.dart';
import 'package:base_flutter_framework/module/natural_image/view/natural_image_screen.dart';
import 'package:base_flutter_framework/module/natural_world/binding/natural_world_binding.dart';
import 'package:base_flutter_framework/module/natural_world/view/natural_world_screen.dart';
import 'package:base_flutter_framework/module/scan_image/binding/scan_image_binding.dart';
import 'package:base_flutter_framework/module/scan_image/view/list_image_lable.dart';
import 'package:base_flutter_framework/module/scan_image/view/scan_image_screen.dart';
import 'package:base_flutter_framework/module/search/binding/search_binding.dart';
import 'package:base_flutter_framework/module/search/view/search_screen.dart';
import 'package:base_flutter_framework/module/setting/binding/setting_binding.dart';
import 'package:base_flutter_framework/module/setting/view/setting_screen.dart';
import 'package:base_flutter_framework/module/splash/binding/splash_binding.dart';
import 'package:base_flutter_framework/module/splash/view/splash_screen.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

const INITIAL = Routes.HOME;

final routePages = [
  GetPage(
    name: Routes.SPLASH,
    page: () => SplashScreen(),
    binding: SplashBinding(),
  ),
  GetPage(
    name: Routes.HOME,
    page: () => HomeScreen(),
    binding: HomeBinding(),
  ),
  GetPage(
    name: Routes.NATURAL_WORLD,
    page: () => NaturalWorldScreen(),
    binding: NaturalWorldBinding(),
  ),
  GetPage(
    name: Routes.NATURAL_IMAGE,
    page: () => NaturalImageScreen(),
    binding: NaturalImageBinding(),
  ),
  GetPage(
    name: Routes.SEARCH,
    page: () => SearchScreen(),
    binding: SearchBinding(),
  ),
  GetPage(
      name: Routes.SCAN,
      page: () => ScanScreen(),
      binding: ScanBinding(),
      children: [
        GetPage(
          name: Routes.LIST_DETECT,
          page: () => ListDetectScreen(),
        ),
      ]),
  GetPage(
    name: Routes.SETTING,
    page: () => SettingScreen(),
    binding: SettingBinding(),
  ),
  GetPage(
    name: Routes.MYID,
    page: () => MyIdScreen(),
    binding: MyIdBinding(),
  ),
  GetPage(
    name: Routes.MYID,
    page: () => SearchScreen(),
    binding: SearchBinding(),
  ),
];
