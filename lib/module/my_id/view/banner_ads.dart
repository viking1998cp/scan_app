import 'package:base_flutter_framework/components/widget/indicator.dart';
import 'package:flutter/material.dart';
import 'package:native_admob_flutter/native_admob_flutter.dart';

class BannerAds extends StatefulWidget {
  const BannerAds({Key? key}) : super(key: key);

  @override
  _BannerAdsState createState() => _BannerAdsState();
}

class _BannerAdsState extends State<BannerAds>
    with AutomaticKeepAliveClientMixin {
  Widget? child;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (child != null) return child!;
    return BannerAd(
      builder: (context, child) {
        return Container(
          color: Colors.transparent,
          child: child,
        );
      },
      loading: Center(child: indicator()),
      error: Text('error'),
      size: BannerSize.fromWH(300, 250),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
