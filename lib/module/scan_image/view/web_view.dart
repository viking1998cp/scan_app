import 'package:base_flutter_framework/components/widget/tool_bar.dart';
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
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        child: Column(
          children: [
            ToolBarCommon(
              onclick: () {
                Navigator.pop(context);
              },
              title: widget.name.toUpperCase(),
            ),
            Expanded(
                child: WebView(
              initialUrl: widget.url,
            ))
          ],
        ),
      ),
    ));
  }
}
