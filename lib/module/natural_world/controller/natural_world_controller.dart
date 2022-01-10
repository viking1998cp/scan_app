import 'package:base_flutter_framework/core/models/result_detect.dart';
import 'package:base_flutter_framework/repository/detect_repository.dart';
import 'package:base_flutter_framework/repository/natural_image_repository.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class NaturalWorldController extends GetxController {
  RxList<String> listNameItem = <String>[].obs;
  RxList<ResultDetect> listItemResult = <ResultDetect>[].obs;
  NaturalRepository _naturalRepository = new NaturalRepository();
  DetectRepository _detectRepository = new DetectRepository();
  RxInt page = 1.obs;
  RxInt perPgae = 15.obs;
  RxBool loading = true.obs;
  RxBool limit = false.obs;

  RxInt showAds = 1.obs;

  Future<void> getListNameItem() async {
    if (listNameItem.isEmpty)
      _naturalRepository.getNameNatural().then((value) async {
        listNameItem.value = value;
        await getData();
      });
  }

  Future<void> getData() async {
    List<String> loadMoreData = [];
    if ((page.value * perPgae.value) > listNameItem.length) {
      limit.value = true;
      loadMoreData = listNameItem.sublist(
          listNameItem.length - 1 - perPgae.value, listNameItem.length);
    } else {
      loadMoreData = listNameItem.sublist(
          (page.value * perPgae.value) - perPgae.value,
          (page.value * perPgae.value));
    }
    List<ResultDetect> resultLoadMore = [];
    for (int i = 0; i < loadMoreData.length; i++) {
      String name = loadMoreData[i].replaceAll(" ", "_");
      ResultDetect item =
          await _detectRepository.getResultByName(name, locace: "en");
      if (!item.title!.contains("Not found")) {
        resultLoadMore.add(item);
      }
    }
    page++;
    listItemResult.addAll(resultLoadMore);
  }

  List<ResultDetect> getDataImage() {
    return listItemResult.value;
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
