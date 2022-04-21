import 'dart:io';

import 'package:base_flutter_framework/core/models/wallpaper.dart';
import 'package:base_flutter_framework/repository/wallpaper_repository.dart';
import 'package:base_flutter_framework/resource/resource_icon.dart';
import 'package:base_flutter_framework/utils/constants/colors.dart';
import 'package:base_flutter_framework/utils/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class NaturalImageController extends GetxController {
  WallpaperRepository _wallpaperRepository = new WallpaperRepository();

  RxList<WallpaperId> wallpaperIdsName = <WallpaperId>[].obs;

  RxList<WallpaperId> wallpaperIdsLoad = <WallpaperId>[].obs;

  RxBool? isActive0 = false.obs;
  RxBool? isActive1 = false.obs;
  RxBool? isActive2 = false.obs;
  RxBool? isActive3 = false.obs;

  RxInt currentIndex = 0.obs;

  RxInt page = 1.obs;
  RxInt perPage = 2.obs;
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
    super.onInit();
  }

  Future<void> getData() async {
    await getUrls(wallpaperName: "plant");
    loadData();
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
    wallpaperIdsName.clear();
    wallpaperIdsLoad.clear();
    await getUrls(wallpaperName: name);
    page.value = 1;
    loadData();
  }

  Future<void> loadData() async {
    wallpaperIdsLoad.addAll(wallpaperIdsName.sublist(
        page.value * perPage.value, (page.value + 1) * perPage.value));

    page++;
    if (wallpaperIdsLoad.length < 10) {
      loadData();
    }
  }

  Future<void> getUrls({required String wallpaperName}) async {
    try {
      int pageLoadName = 1;
      for (int i = 0; i < 5; i++) {
        WallpaperModel? wallpaperModel = await _wallpaperRepository
            .getListWallpaperIds(name: wallpaperName, pageCount: pageLoadName);
        pageLoadName++;

        wallpaperIdsName.addAll(wallpaperModel!.id!);
      }
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
  String getFullNativeAds() {
    return Platform.isAndroid
        ? 'ca-app-pub-3940256099942544/1033173712'
        : 'ca-app-pub-3940256099942544/4411468910';
  }

  InterstitialAd? interstitialAd;
  void createInterstitialAd() {
    if (Shared.getInstance().buyFree == true) {
      return;
    }
    InterstitialAd.load(
        adUnitId: getFullNativeAds(),
        request: request,
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            interstitialAd = ad;

            interstitialAd!.setImmersiveMode(true);
          },
          onAdFailedToLoad: (LoadAdError error) {
            interstitialAd = null;

            createInterstitialAd();
          },
        ));
  }
}
