import 'dart:io';

import 'package:base_flutter_framework/components/widget/indicator.dart';
import 'package:base_flutter_framework/utils/dimens.dart';
import 'package:base_flutter_framework/utils/shared.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerAdsCustom extends StatefulWidget {
  static BannerAdsCustom? instanceBigAds;
  static BannerAdsCustom? instanceSmallAds;

  static BannerAdsCustom? bottomAds;
  static BannerAdsCustom getInstanceBigAds() {
    if (instanceBigAds == null)
      instanceBigAds = BannerAdsCustom(
        type: 2,
      );
    return instanceBigAds!;
  }

  static BannerAdsCustom getInstanceSmallAds(BuildContext context) {
    if (instanceSmallAds == null)
      instanceSmallAds = BannerAdsCustom(
        type: 1,
      );
    return instanceSmallAds!;
  }

  static BannerAdsCustom getInstanceBottomAds(BuildContext context) {
    if (bottomAds == null)
      bottomAds = BannerAdsCustom(
        type: 1,
      );
    return bottomAds!;
  }

  final int type;
  const BannerAdsCustom({Key? key, required this.type}) : super(key: key);

  @override
  _BannerAdsCustomState createState() => _BannerAdsCustomState();
}

class _BannerAdsCustomState extends State<BannerAdsCustom> {
  Widget? child;

  // NativeAd? _nativeAd;
  final ValueNotifier _nativeAdIsLoaded = ValueNotifier<bool>(false);
  final ValueNotifier _nativeAdIsLoadedError = ValueNotifier<bool>(false);
  final ValueNotifier _isShowAd = ValueNotifier<bool>(false);
  NativeAd? _nativeAd;
  @override
  void initState() {
    super.initState();
    _nativeAd = NativeAd(
      adUnitId: Platform.isAndroid
          ? 'ca-app-pub-2678670127764045/5498886451'
          : 'ca-app-pub-3940256099942544/3986624511',
      request: const AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (Ad ad) {
          debugPrint('$NativeAd loaded.');

          _nativeAdIsLoaded.value = true;
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          debugPrint('$NativeAd failedToLoad: $error');
          _nativeAdIsLoadedError.value = true;
          ad.dispose();
        },
        onAdOpened: (Ad ad) => debugPrint('$NativeAd onAdOpened.'),
        onAdClosed: (Ad ad) => debugPrint('$NativeAd onAdClosed.'),
      ),
      factoryId: 'adFactoryExample',
    )..load();
  }

  @override
  void dispose() {
    _nativeAd?.dispose();
    super.dispose();
  }

  String getNativeAds() {
    if (Platform.isIOS) {
      return "ca-app-pub-4971959505787142/1859506847";
    } else {
      return "ca-app-pub-2678670127764045/5498886451";
    }
  }

  @override
  Widget build(BuildContext context) {
    if (child != null) return child!;

    return Shared.getInstance().buyFree == true
        ? SizedBox()
        : Container(
            width: DimensCommon.sizeWidth(context: context),
            margin: EdgeInsets.only(top: 8),
            height: widget.type == 1 ? 70 : 330,
            child: ValueListenableBuilder(
                valueListenable: _nativeAdIsLoaded,
                builder: (context, valueLoad, child) {
                  return valueLoad == true
                      ? ValueListenableBuilder(
                          valueListenable: _nativeAdIsLoadedError,
                          builder: (context, valueError, child) {
                            return valueError != true
                                ? SizedBox(
                                    height: widget.type == 1 ? 70 : 330,
                                    width: double.infinity,
                                    child: AdWidget(ad: _nativeAd!),
                                  )
                                : SizedBox();
                          })
                      : indicator();
                }));
  }
}
