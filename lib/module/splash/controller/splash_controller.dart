import 'dart:async';
import 'package:base_flutter_framework/components/menu/menu_page.dart/menu_page_common.dart';
import 'package:base_flutter_framework/routes/app_pages.dart';
import 'package:base_flutter_framework/utils/shared.dart';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';
import 'package:native_admob_flutter/native_admob_flutter.dart';

class SplashController extends GetxController {
  SplashController();
  @override
  Future<void> onInit() async {
    super.onInit();
    //send token and user id to server
    _getId();
    await loadInitSplashScreen();
  }

  @override
  Future<void> onReady() async {
    super.onReady();
  }

  Future<void> loadInitSplashScreen() async {
    Timer(Duration(seconds: 2), () async {
      if (Shared.getInstance().layout == 1) {
        Get.offAll(MenuPageCommon(activeIndex: 0));
      } else {
        Get.offAndToNamed(Routes.HOME);
      }
    });
  }

  // Get Device ID
  Future<String?> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      await Shared.getInstance()
          .saveDeviceId(deviceId: iosDeviceInfo.identifierForVendor!);
      // This is my device id. Ad yours here
      MobileAds.setTestDeviceIds([iosDeviceInfo.identifierForVendor!]);
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      await Shared.getInstance()
          .saveDeviceId(deviceId: androidDeviceInfo.androidId!);
      MobileAds.setTestDeviceIds([androidDeviceInfo.androidId!]);
      return androidDeviceInfo.androidId; // unique ID on Android
    }
  }
}
