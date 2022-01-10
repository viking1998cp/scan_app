import 'package:base_flutter_framework/components/widget/button_no_icon.dart';
import 'package:base_flutter_framework/components/widget/load_more/load_more_grid_view.dart';
import 'package:base_flutter_framework/core/models/result_detect.dart';
import 'package:base_flutter_framework/module/my_id/controller/my_id_controller.dart';
import 'package:base_flutter_framework/module/my_id/view/banner_ads.dart';
import 'package:base_flutter_framework/module/my_id/view/item_cache.dart';
import 'package:base_flutter_framework/module/scan_image/view/web_view.dart';
import 'package:base_flutter_framework/translations/transaction_key.dart';
import 'package:base_flutter_framework/utils/color.dart';
import 'package:base_flutter_framework/utils/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scroll_navigation/scroll_navigation.dart';
part 'my_id_screen.children.dart';

class MyIdScreen extends GetView<MyIdController> {
  const MyIdScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: false,
          title: Text(
            TransactionKey.loadLanguage(Get.context!, TransactionKey.myID)
                .toUpperCase(),
          ),
        ),
        body: Container(
            width: Get.width,
            child: TitleScrollNavigation(
              barStyle: TitleNavigationBarStyle(
                activeColor: Theme.of(context).primaryColor,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                padding:
                    EdgeInsets.only(top: 24, bottom: 5, left: 20, right: 20),
                spaceBetween: 40,
              ),
              titles: [
                TransactionKey.loadLanguage(context, TransactionKey.collection),
                TransactionKey.loadLanguage(context, TransactionKey.favorite),
              ],
              identiferStyle: NavigationIdentiferStyle(
                  // position: IdentifierPosition.topAndRight,
                  color: Theme.of(context).primaryColor),
              pages: [
                Obx(() => listCollection(remoColecction: (resultDetect) async {
                      Shared.getInstance()
                          .collectionCache!
                          .remove(resultDetect);
                      await Shared.getInstance().saveCollection(
                          cacheCollection:
                              Shared.getInstance().collectionCache!);
                      controller.getListCollection();
                    })),
                Obx(() => listFavorite(unlikeClick: (resultDetect) async {
                      Shared.getInstance().favoriteCache!.remove(resultDetect);
                      await Shared.getInstance().saveFavorite(
                          cacheFavorite: Shared.getInstance().favoriteCache!);
                      controller.getListFavorite();
                    }))
              ],
            )));
  }
}
