import 'package:base_flutter_framework/module/my_id/controller/my_id_controller.dart';
import 'package:base_flutter_framework/resource/resource_icon.dart';
import 'package:base_flutter_framework/routes/app_pages.dart';
import 'package:base_flutter_framework/translations/transaction_key.dart';
import 'package:base_flutter_framework/utils/style/button_style.dart';
import 'package:base_flutter_framework/utils/style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

part 'home_screen.chidren.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _appBar(context), body: _buildBody());
  }

  Widget _buildBody() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      // color: Colors.grey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 3,
                  blurRadius: 3,
                  offset: Offset(1, 3),
                ),
              ],
            ),
            child: TextButton(
              onPressed: () async {
                await Get.toNamed(Routes.SCAN);
              },
              style: ButtonAppStyle().buttonWrap(),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 10,
                      blurRadius: 5,
                      offset: Offset(1, 5),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: Image.asset(ResourceIcon.iconQRCode),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              TransactionKey.loadLanguage(
                                  Get.context!, TransactionKey.scan),
                              style: TextAppStyle().textTitleStyle()),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                              TransactionKey.loadLanguage(
                                  Get.context!, TransactionKey.scanImage),
                              style: TextAppStyle().textMediumStyle()),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 28,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                // flex: 1,
                child: _itemMenu(
                    title: TransactionKey.loadLanguage(
                        Get.context!, TransactionKey.trending),
                    icon: ResourceIcon.iconTrending,
                    detail: TransactionKey.loadLanguage(
                        Get.context!, TransactionKey.subTrending),
                    onclick: () async {
                      await Get.toNamed(Routes.NATURAL_WORLD);
                    }),
              ),
              SizedBox(
                width: 23,
              ),
              Expanded(
                // flex: 1,
                child: _itemMenu(
                    title: TransactionKey.loadLanguage(
                        Get.context!, TransactionKey.myBirds),
                    icon: ResourceIcon.iconImage,
                    detail: TransactionKey.loadLanguage(
                        Get.context!, TransactionKey.subMyBirds),
                    onclick: () async {
                      MyIdController controller = Get.find();
                      controller.getListCollection();
                      controller.getListFavorite();
                      await Get.toNamed(Routes.MYID);
                    }),
              ),
            ],
          ),
          SizedBox(
            height: 28,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                // flex: 5,
                child: _itemMenu(
                    title: TransactionKey.loadLanguage(
                        Get.context!, TransactionKey.search),
                    icon: ResourceIcon.iconSearch,
                    detail: TransactionKey.loadLanguage(
                        Get.context!, TransactionKey.searchObject),
                    onclick: () async {
                      await Get.toNamed(Routes.SEARCH);
                    }),
              ),
              SizedBox(
                width: 23,
              ),
              Expanded(
                // flex: 6,
                child: _itemMenu(
                    title: TransactionKey.loadLanguage(
                        Get.context!, TransactionKey.wallpaper),
                    icon: ResourceIcon.iconWallpaper,
                    detail: TransactionKey.loadLanguage(
                        Get.context!, TransactionKey.subWallpaper),
                    onclick: () async {
                      await Get.toNamed(Routes.NATURAL_IMAGE);
                    }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
