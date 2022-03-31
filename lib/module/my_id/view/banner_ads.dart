import 'dart:io';

import 'package:base_flutter_framework/components/widget/indicator.dart';
import 'package:base_flutter_framework/utils/dimens.dart';
import 'package:base_flutter_framework/utils/shared.dart';
import 'package:flutter/material.dart';
import 'package:native_admob_flutter/native_admob_flutter.dart';

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

  final _nativeAdController = NativeAdController();

  @override
  void initState() {
    super.initState();
    _nativeAdController.onEvent.listen((event) {
      print(event);
    });
    _nativeAdController.load().then((value) {
      print(value);
    });
  }

  @override
  void dispose() {
    _nativeAdController.dispose();
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
        : NativeAd(
            controller: _nativeAdController,
            height: widget.type == 1 ? 60 : 250,
            builder: (context, child) {
              return Material(
                elevation: 8,
                child: child,
              );
            },
            unitId: getNativeAds(),
            buildLayout: widget.type == 2
                ? mediumAdTemplateLayoutBuilder
                : adBannerLayoutBuilder,
            loading: Container(
              width: DimensCommon.sizeWidth(context: context),
              height: widget.type == 1 ? 60 : 250,
              child: indicator(),
            ),
            error: Container(),
            icon: AdImageView(padding: EdgeInsets.only(left: 6)),
            headline: AdTextView(style: TextStyle(color: Colors.black)),
            advertiser: AdTextView(style: TextStyle(color: Colors.black)),
            loadTimeout: Duration(seconds: 60),
            body:
                AdTextView(style: TextStyle(color: Colors.black), maxLines: 1),
            button: AdButtonView(
              margin: EdgeInsets.only(left: 6, right: 6),
              textStyle: TextStyle(color: Colors.green, fontSize: 14),
              elevation: 18,
              elevationColor: Colors.amber,
            ),
          );
  }
}
