import 'package:base_flutter_framework/app.dart';
import 'package:base_flutter_framework/base/di.dart';
import 'package:base_flutter_framework/utils/hive_database/hive_database.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';

import 'utils/shared.dart';

List<CameraDescription>? cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveDatabase.getInstance().init();
  await Shared.getInstance().getColor();
  await Shared.getInstance().getLayOutScreen();
  await Shared.getInstance().getLikeData();
  await Shared.getInstance().getCollection();
  await Shared.getInstance().getLanguage();
  await DependencyInjection.init();

  print('test');
  cameras = await availableCameras();
  runApp(App());
  configLoading();
}
