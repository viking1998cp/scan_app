import 'package:base_flutter_framework/core/models/result_detect.dart';
import 'package:base_flutter_framework/repository/detect_repository.dart';
import 'package:base_flutter_framework/repository/natural_image_repository.dart';
import 'package:base_flutter_framework/utils/shared.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:native_admob_flutter/native_admob_flutter.dart' as native;

class MyIdController extends GetxController {
  /// Init the controller
  final bannerController = native.BannerAdController();
  RxInt showAds = 1.obs;
  RxList<ResultDetect> favoriteList = <ResultDetect>[].obs;
  RxList<ResultDetect> collectionList = <ResultDetect>[].obs;

  void getListFavorite() {
    favoriteList.clear();
    favoriteList.addAll(Shared.getInstance().favoriteCache!);
  }

  void getListCollection() {
    collectionList.clear();
    collectionList.addAll(Shared.getInstance().collectionCache!);
  }

  void setShowAds(int value) {
    showAds.value = value;
  }

  static final AdRequest request = AdRequest(
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    nonPersonalizedAds: true,
  );

  InterstitialAd? interstitialAd;
  void createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: InterstitialAd.testAdUnitId,
        request: request,
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            print('$ad loaded');
            interstitialAd = ad;

            interstitialAd!.setImmersiveMode(true);
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error.');

            interstitialAd = null;

            createInterstitialAd();
          },
        ));
  }
}
