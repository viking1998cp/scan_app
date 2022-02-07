import 'dart:async';
import 'package:base_flutter_framework/base/di.dart';
import 'package:base_flutter_framework/components/menu/menu_page.dart/menu_page_common.dart';
import 'package:base_flutter_framework/routes/app_pages.dart';
import 'package:base_flutter_framework/utils/shared.dart';
import 'package:base_flutter_framework/utils/sk_toast.dart';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:native_admob_flutter/native_admob_flutter.dart';

class SplashController extends GetxController {
  SplashController();
  @override
  Future<void> onInit() async {
    super.onInit();
    //send token and user id to server
    _getId();

    if (Platform.isIOS) {
      bool modelMush = await GoogleMlKit.vision
          .remoteModelManager()
          .isModelDownloaded('mush_data');

      if (!modelMush) {
        SKToast.showToastBottom(
            messager:
                "Bạn cần bật mạng để thiết lập cấu hình trong lần đầu khởi chạy",
            context: Get.context);
        await GoogleMlKit.vision
            .remoteModelManager()
            .downloadModel("mush_data", isWifiRequired: false)
            .then((value) => print(value));
      }

      bool birlModel = await GoogleMlKit.vision
          .remoteModelManager()
          .isModelDownloaded('bird');
      if (!birlModel) {
        SKToast.showToastBottom(
            messager:
                "Bạn cần bật mạng để thiết lập cấu hình trong lần đầu khởi chạy",
            context: Get.context);
        await GoogleMlKit.vision
            .remoteModelManager()
            .downloadModel("bird", isWifiRequired: false);
      }
    }
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
