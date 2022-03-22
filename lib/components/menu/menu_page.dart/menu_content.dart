import 'dart:async';

import 'package:base_flutter_framework/module/my_id/controller/my_id_controller.dart';
import 'package:base_flutter_framework/module/my_id/view/my_id_screen.dart';
import 'package:base_flutter_framework/module/natural_image/view/natural_image_screen.dart';
import 'package:base_flutter_framework/module/natural_world/view/natural_world_screen.dart';
import 'package:base_flutter_framework/module/scan_image/controller/scan_image_controller.dart';
import 'package:base_flutter_framework/module/scan_image/view/scan_image_screen.dart';
import 'package:base_flutter_framework/module/setting/view/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuContent extends StatefulWidget {
  final index;

  const MenuContent({Key? key, required this.index}) : super(key: key);

  @override
  _MenuContentState createState() => _MenuContentState();
}

class _MenuContentState extends State<MenuContent> {
  @override
  Widget build(BuildContext context) {
    // Scan Camera
    if (widget.index == 4) {
      Get.lazyPut<ScanController>(() => ScanController());
      return ScanScreen();
    } else {
      Timer(Duration(milliseconds: 200), () {
        if (ScanController.cameraController != null) {
          ScanController.cameraController!.dispose();
        }
      });
      // Natural World
      if (widget.index == 0) {
        return NaturalWorldScreen();
      }
      // My ID
      else if (widget.index == 1) {
        MyIdController myIdController = Get.find();
        myIdController.getListFavorite();
        myIdController.getListCollection();
        return MyIdScreen();
      }
      // Natural Image
      else if (widget.index == 2) {
        return NaturalImageScreen();
      }
      // Setting
      else {
        return SettingScreen();
      }
    }
  }
}
