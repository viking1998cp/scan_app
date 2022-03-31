import 'dart:async';
import 'package:base_flutter_framework/base/di.dart';
import 'package:base_flutter_framework/components/menu/menu_page.dart/menu_page_common.dart';
import 'package:base_flutter_framework/routes/app_pages.dart';
import 'package:base_flutter_framework/translations/transaction_key.dart';
import 'package:base_flutter_framework/utils/shared.dart';
import 'package:base_flutter_framework/utils/sk_toast.dart';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:intl/intl.dart';

import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:intl/intl.dart';
import 'package:in_app_purchase_android/billing_client_wrappers.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';

//import for InAppPurchaseStoreKitPlatformAddition
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';

class SplashController extends GetxController {
  SplashController();

  @override
  Future<void> onInit() async {
    super.onInit();

    _getId();

    if (Platform.isIOS) {
      bool modelMush = await GoogleMlKit.vision
          .remoteModelManager()
          .isModelDownloaded('mush_data');

      if (!modelMush) {
        SKToast.showToastBottom(
            messager: TransactionKey.loadLanguage(
                Get.context!, TransactionKey.msgTurnOnNetword),
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
            messager: TransactionKey.loadLanguage(
                Get.context!, TransactionKey.msgTurnOnNetword),
            context: Get.context);
        await GoogleMlKit.vision
            .remoteModelManager()
            .downloadModel("bird", isWifiRequired: false);
      }
    }
    await loadInitSplashScreen();
  }

  final Set<String> _productLists = Platform.isAndroid
      ? <String>{
          'subs_after_try',
          'subs_vip_month',
          'subs_vip_year',
        }
      : <String>{
          "subs_after_try",
          'subs_vip_month',
          'subs_vip_year',
        };

  Future<void> getProductRepository({required Set<String> kIds}) async {
    await InAppPurchase.instance.queryProductDetails(kIds);
    await _getOld();
  }

  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  GooglePlayPurchaseDetails? oldPurchaseDetails;

  Future<void> _getOld() async {
    _inAppPurchase.isAvailable();
    if (Platform.isAndroid) {
      final InAppPurchaseAndroidPlatformAddition androidAddition =
          _inAppPurchase
              .getPlatformAddition<InAppPurchaseAndroidPlatformAddition>();
      QueryPurchaseDetailsResponse oldPurchaseDetailsQuery =
          await androidAddition.queryPastPurchases();
      oldPurchaseDetailsQuery.pastPurchases.forEach((element) async {
        oldPurchaseDetails = element;
      });
      if (oldPurchaseDetails != null) {
        bool st = await SubcsriptionStatus.subscriptionStatus(
            sku: oldPurchaseDetails!.billingClientPurchase.sku,
            duration: Duration(days: 1),
            grace: Duration(days: 0));
        if (st) {
          await Shared.getInstance().saveBuy(buy: true);
        } else {
          await Shared.getInstance().saveBuy(buy: false);
        }
      }
    } else {
      InAppPurchaseStoreKitPlatformAddition iosPlatformAddition = _inAppPurchase
          .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      iosPlatformAddition.showPriceConsentIfNeeded().then((value) {});
      // QueryPurchaseDetailsResponse oldPurchaseDetailsQuery =
      //     await iosPlatformAddition.obs.oldPurchaseDetailsQuery.pastPurchases
      //         .forEach((element) async {
      //   oldPurchaseDetails = element;
      // });
    }
  }

  String dateTimeToString7(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
  }

  String fromTimeHourToString(int? timestamp) {
    if (timestamp != null) {
      return dateTimeToString7(fromTimeStamp(timestamp * 1000));
    }
    return "";
  }

  DateTime fromTimeStamp(int timestamp) {
    return new DateTime.fromMillisecondsSinceEpoch(timestamp);
  }

  @override
  Future<void> onReady() async {
    super.onReady();
  }

  Future<void> loadInitSplashScreen() async {
    await getProductRepository(kIds: _productLists);
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

      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      await Shared.getInstance()
          .saveDeviceId(deviceId: androidDeviceInfo.androidId!);

      return androidDeviceInfo.androidId; // unique ID on Android
    }
  }
}

class SubcsriptionStatus {
  static Future<bool> subscriptionStatus(
      {required String sku,
      required Duration duration,
      required Duration grace}) async {
    await FlutterInappPurchase.instance.initConnection;

    if (Platform.isIOS) {
      var history = await FlutterInappPurchase.instance.getPurchaseHistory();

      for (var purchase in history ?? []) {
        Duration difference =
            DateTime.now().difference(purchase.transactionDate);
        if (difference.inMinutes <= (duration + grace).inMinutes &&
            purchase.productId == sku) return true;
      }
      return false;
    } else if (Platform.isAndroid) {
      var purchases =
          await FlutterInappPurchase.instance.getAvailablePurchases();

      for (var purchase in purchases ?? []) {
        if (purchase.productId == sku) return true;
      }
      return false;
    }
    throw PlatformException(
        code: Platform.operatingSystem, message: "platform not supported");
  }
}
