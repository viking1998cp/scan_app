import 'dart:io';

import 'package:base_flutter_framework/base/base_controller.dart';
import 'package:base_flutter_framework/core/models/result_detect.dart';
import 'package:base_flutter_framework/core/models/search.dart';
import 'package:base_flutter_framework/repository/detect_repository.dart';
import 'package:base_flutter_framework/repository/search_repository.dart';
import 'package:base_flutter_framework/utils/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class SearchController extends BaseController {
  SearchRepository _searchRepository = new SearchRepository();

  Rxn<SearchDataModel> searchDataModel = Rxn();

  RxList<ResultDetect> dataSearch = <ResultDetect>[].obs;

  DetectRepository _getResultRepo = DetectRepository();

  RxInt showAds = 1.obs;

  RxBool loading = false.obs;

  final TextEditingController textSearchController = TextEditingController();

  Future<void> searchData(
      {String? textSearch, required BuildContext context}) async {
    try {
      dataSearch.clear();
      searchDataModel.value =
          await _searchRepository.getListDataSearch(searchName: textSearch);
      List<Search> searchResults = [];
      searchResults = searchDataModel.value!.query!.search!;
      List<ResultDetect> listDataNew = [];
      for (int i = 0; i < searchResults.length; i++) {
        ResultDetect data =
            await _getResultRepo.getResultByName(searchResults[i].title!);
        if (data.title == "Not found.") {
          continue;
        }
        listDataNew.add(data);
      }
      loading.value = false;
      dataSearch.addAll(listDataNew);
    } on Exception catch (_) {
    } catch (error) {}
  }

  Future<void> upDateLikeData(int index, bool like) async {
    List<ResultDetect> listUpdate = [];
    dataSearch.forEach((element) {
      listUpdate.add(element);
    });
    listUpdate[index].isLike = like;

    dataSearch.value = listUpdate;
  }

  void setShowAds(int value) {
    showAds.value = value;
  }

  void setLoading(bool value) {
    loading.value = value;
  }

  static final AdRequest request = AdRequest(
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    nonPersonalizedAds: true,
  );
  String getFullNativeAds() {
    if (Platform.isIOS) {
      return "ca-app-pub-2543065673224553/5479222074";
    } else {
      return "ca-app-pub-2678670127764045/8312752059";
    }
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
