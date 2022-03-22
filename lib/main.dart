import 'package:base_flutter_framework/app.dart';
import 'package:base_flutter_framework/base/di.dart';
import 'package:base_flutter_framework/utils/hive_database/hive_database.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:native_admob_flutter/native_admob_flutter.dart';

import 'utils/shared.dart';

List<CameraDescription>? cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.initialize();
  await HiveDatabase.getInstance().init();
  await Shared.getInstance().getColor();
  await Shared.getInstance().getLayOutScreen();
  await Shared.getInstance().getLikeData();
  await Shared.getInstance().getCollection();
  await Shared.getInstance().getLanguage();

  await DependencyInjection.init();

  cameras = await availableCameras();
  runApp(App());
  configLoading();
}
