import 'package:base_flutter_framework/app.dart';
import 'package:base_flutter_framework/base/di.dart';
import 'package:base_flutter_framework/utils/hive_database/hive_database.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

List<CameraDescription>? cameras;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DependencyInjection.init();

  cameras = await availableCameras();
  runApp(App());
  configLoading();
}
