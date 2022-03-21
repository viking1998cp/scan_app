import 'dart:io';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:base_flutter_framework/components/menu/menu_page.dart/menu_content.dart';
import 'package:base_flutter_framework/components/widget/image.dart';
import 'package:base_flutter_framework/icons/app_icons.dart';
import 'package:base_flutter_framework/icons/my_flutter_app_icons.dart';
import 'package:base_flutter_framework/module/my_id/controller/my_id_controller.dart';

import 'package:base_flutter_framework/module/scan_image/controller/scan_image_controller.dart';
import 'package:base_flutter_framework/routes/app_pages.dart';
import 'package:base_flutter_framework/translations/transaction_key.dart';
import 'package:base_flutter_framework/utils/sk_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class MenuPageCommon extends StatefulWidget {
  int activeIndex;
  MenuPageCommon({Key? key, required this.activeIndex}) : super(key: key);

  @override
  _MenuPageCommonState createState() => _MenuPageCommonState();
}

class _MenuPageCommonState extends State<MenuPageCommon> {
  int indexPage = 0;
  ScanController? controller;
  List<int> _selectIndex = [];
  @override
  void initState() {
    super.initState();
    indexPage = widget.activeIndex;
  }

  Future<bool> _willPop() async {
    if (_selectIndex.isNotEmpty) {
      setState(() {
        indexPage = _selectIndex[_selectIndex.length - 1];
        _selectIndex.removeAt(_selectIndex.length - 1);
      });
      return false;
    } else {
      SKToast.msg(
          context: context,
          message: TransactionKey.loadLanguage(
              context, TransactionKey.titleCloseApp),
          textCancel:
              TransactionKey.loadLanguage(context, TransactionKey.selectCancel),
          okClik: () {
            exit(0);
          },
          textOk: TransactionKey.loadLanguage(context, TransactionKey.selectOk),
          title: TransactionKey.loadLanguage(
              context, TransactionKey.notification));

      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _willPop,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: imageFromLocale(url: AppIcons.iconCapture),
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () async {
            if (indexPage == 4) {
              controller = Get.find<ScanController>();
              controller!.captureImage();
            } else {
              if (await Permission.camera.request().isGranted) {
                setState(() {
                  _selectIndex.add(indexPage);
                  indexPage = 4;
                });
              }
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
            activeIndex: indexPage,
            inactiveColor: Colors.grey.withOpacity(0.8),
            iconSize: 25,
            activeColor: indexPage == 4
                ? Colors.grey.withOpacity(0.8)
                : Theme.of(context).primaryColor,
            gapLocation: GapLocation.center,
            notchSmoothness: NotchSmoothness.defaultEdge,
            onTap: (index) {
              if (index == 1) {
                Get.lazyPut<MyIdController>(
                  () => MyIdController(),
                );
              }
              setState(() {
                _selectIndex.add(indexPage);
                indexPage = index;
              });
            }),
        //other params
      ),
    );
  }
}
