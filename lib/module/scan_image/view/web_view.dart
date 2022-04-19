import 'package:base_flutter_framework/components/widget/tool_bar.dart';
import 'package:base_flutter_framework/module/my_id/view/banner_ads.dart';
import 'package:base_flutter_framework/utils/shared.dart';
import 'package:base_flutter_framework/utils/string.dart';
import 'package:base_flutter_framework/utils/style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewResult extends StatefulWidget {
  final String url;
  final String name;
  const WebviewResult({Key? key, required this.url, required this.name})
      : super(key: key);

  @override
  _WebviewResultState createState() => _WebviewResultState();
}

class _WebviewResultState extends State<WebviewResult> {
  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        titleSpacing: 8,
        title: Text(
          StringCommon.formatHtml(widget.name.toUpperCase()),
          style: TextAppStyle().textToolBar(),
        ),
      ),
      body: Container(
        child: Stack(
          children: <Widget>[
            Container(
              child: Column(
                children: [
                  Expanded(
                      child: WebView(
                    initialUrl: widget.url,
                    onPageFinished: (finish) {
                      setState(() {
                        isLoading = false;
                      });
                    },
                  )),
                  Shared.getInstance().layout == 2
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            BannerAdsCustom.getInstanceBottomAds(context),
                          ],
                        )
                      : SizedBox()
                ],
              ),
            ),
            isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Stack(),
          ],
        ),
      ),
    );
  }
}
