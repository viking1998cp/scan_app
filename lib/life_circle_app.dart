import 'package:base_flutter_framework/module/my_id/view/banner_ads.dart';
import 'package:base_flutter_framework/utils/dimens.dart';
import 'package:base_flutter_framework/utils/shared.dart';
import 'package:flutter/widgets.dart';

class LifecycleWatcher extends StatefulWidget {
  Widget child;
  LifecycleWatcher({required this.child});
  @override
  _LifecycleWatcherState createState() => _LifecycleWatcherState();
}

class _LifecycleWatcherState extends State<LifecycleWatcher>
    with WidgetsBindingObserver {
  AppLifecycleState? _lastLifecycleState;

  @override
  void initState() {
    super.initState();

    // MqttClientService.getInstance()!.connect();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  Future<void> dispose() async {
    WidgetsBinding.instance!.removeObserver(this);
    try {} catch (_e) {}

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      _lastLifecycleState = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
