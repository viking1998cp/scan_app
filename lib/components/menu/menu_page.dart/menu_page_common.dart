import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:base_flutter_framework/components/menu/menu_page.dart/menu_content.dart';
import 'package:base_flutter_framework/components/widget/image.dart';
import 'package:base_flutter_framework/icons/app_icons.dart';
import 'package:base_flutter_framework/icons/my_flutter_app_icons.dart';

import 'package:base_flutter_framework/module/scan_image/controller/scan_image_controller.dart';
import 'package:base_flutter_framework/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuPageCommon extends StatefulWidget {
  int activeIndex;
  MenuPageCommon({Key? key, required this.activeIndex}) : super(key: key);

  @override
  _MenuPageCommonState createState() => _MenuPageCommonState();
}

class _MenuPageCommonState extends State<MenuPageCommon> {
  int indexPage = 0;
  ScanController? controller;
  int activeIndex = 0;
  @override
  void initState() {
    super.initState();
    indexPage = widget.activeIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: imageFromLocale(url: AppIcons.iconCapture),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          if (indexPage == 4) {
            controller = Get.find<ScanController>();
            controller!.captureImage();
          } else {
            setState(() {
              indexPage = 4;
            });
          }
        },
        //params
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: MenuContent(
        index: indexPage,
      ),
      bottomNavigationBar: AnimatedBottomNavigationBar(
          icons: [
            MyFlutterApp.search_results_for_natural_world___flaticon_2_1,
            MyFlutterApp.search_results_for_gallery___flaticon_2_1,
            MyFlutterApp.search_results_for_image___flaticon_2_1_3x,
            MyFlutterApp.coolicon
          ],
          activeIndex: activeIndex,
          inactiveColor: Colors.grey.withOpacity(0.8),
          iconSize: 25,
          activeColor: Theme.of(context).primaryColor,
          gapLocation: GapLocation.center,
          notchSmoothness: NotchSmoothness.defaultEdge,
          onTap: (index) {
            setState(() {
              activeIndex = index;
              indexPage = index;
              widget.activeIndex = index;
            });
          }),
      //other params
    );
  }
}
