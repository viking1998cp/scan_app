import 'package:base_flutter_framework/core/models/search.dart';
import 'package:base_flutter_framework/repository/search_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class SearchController extends GetxController {
  SearchRepository _searchRepository = new SearchRepository();

  Rxn<SearchDataModel> searchDataModel = Rxn();
  Rxn<DetailSearchModel> searchDetailModel = Rxn();

  RxList<Search> dataSearch = <Search>[].obs;

  RxString url = "".obs;
  RxString name = "".obs;
  RxInt showAds = 1.obs;

  final TextEditingController textSearchController = TextEditingController();

  Future<void> searchData({String? textSearch}) async {
    try {
      dataSearch.clear();
      searchDataModel.value =
          await _searchRepository.getListDataSearch(searchName: textSearch);
      List<Search> searchResults = [];
      searchResults = await searchDataModel.value!.query!.search!;
      dataSearch.addAll(searchResults);
    } on Exception catch (_) {
      print('exception');
    } catch (error) {
      print('error');
    }
  }

  Future<void> searchDataDetail({String? textName}) async {
    try {
      searchDetailModel.value =
          await _searchRepository.getNameOfDataSearch(name: textName);

      url.value = await searchDetailModel.value!.contentUrls!.mobile!.page!;
      name.value = await searchDetailModel.value!.titles!.display!;
    } on Exception catch (_) {
      print('exception');
    } catch (error) {
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
