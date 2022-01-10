import 'package:base_flutter_framework/core/models/wallpaper.dart';
import 'package:base_flutter_framework/repository/wallpaper_repository.dart';
import 'package:base_flutter_framework/resource/resource_icon.dart';
import 'package:base_flutter_framework/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class NaturalImageController extends GetxController {
  Rxn<WallpaperModel> wallpaperModel = Rxn();
  WallpaperRepository _wallpaperRepository = new WallpaperRepository();

  RxList<WallpaperId> wallpaperIds = <WallpaperId>[].obs;

  RxBool? isActive0 = false.obs;
  RxBool? isActive1 = false.obs;
  RxBool? isActive2 = false.obs;
  RxBool? isActive3 = false.obs;

  RxInt currentIndex = 0.obs;

  RxInt page = 0.obs;
  RxInt perPage = 100.obs;
  RxBool loading = true.obs;
  RxBool limit = false.obs;

  // set wallpaper
  Stream<String>? progressString;
  RxString? res = ''.obs;
  RxBool downloading = false.obs;
  RxBool isDisable = true.obs;

  // set status download image
  RxBool downloadImageStatus = false.obs;

  // Transform
  RxInt degrees = 0.obs;
  RxBool setDegrees = false.obs;

  // play slide
  RxBool autoPlay = false.obs;

  // status bottom tab
  RxBool bottomMenu = true.obs;

  RxInt showAds = 1.obs;

  @override
  void onInit() async {
    print("call onInit");

    super.onInit();
  }

  void getData() {
    getUrls(wallpaperName: "plant");
    isActive0!.value = true;
  }

  Future<void> reloadData(String name) async {
    if (isActive0!.value == true) {
      currentIndex.value = 0;
    }
    if (isActive1!.value == true) {
      currentIndex.value = 1;
    }
    if (isActive2!.value == true) {
      currentIndex.value = 2;
    }
    if (isActive3!.value == true) {
      currentIndex.value = 3;
    }
    wallpaperIds.clear();
    page.value = 0;
    getUrls(wallpaperName: name);
  }

  Future<void> getUrls({required String wallpaperName}) async {
    try {
      wallpaperModel.value = await _wallpaperRepository.getListWallpaperIds(
          name: wallpaperName, pageCount: page.value);
      page.value = page.value + 100;
      List<WallpaperId> resultLoadMore = [];
      resultLoadMore = await wallpaperModel.value!.id!;
      resultLoadMore.shuffle();
      wallpaperIds.addAll(resultLoadMore);
    } on Exception catch (_) {
      limit.value = true;
      print('exception');
    } catch (error) {
      limit.value = true;
      print('error');
    }
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
