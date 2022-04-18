import 'package:base_flutter_framework/components/widget/button_no_icon.dart';
import 'package:base_flutter_framework/components/widget/image.dart';
import 'package:base_flutter_framework/components/widget/load_more/load_more_grid_view.dart';
import 'package:base_flutter_framework/core/models/result_detect.dart';
import 'package:base_flutter_framework/module/my_id/controller/my_id_controller.dart';
import 'package:base_flutter_framework/module/my_id/view/banner_ads.dart';
import 'package:base_flutter_framework/module/my_id/view/item_cache.dart';
import 'package:base_flutter_framework/module/natural_world/controller/natural_world_controller.dart';
import 'package:base_flutter_framework/module/scan_image/controller/scan_image_controller.dart';
import 'package:base_flutter_framework/module/scan_image/view/web_view.dart';
import 'package:base_flutter_framework/resource/resource_icon.dart';
import 'package:base_flutter_framework/routes/app_pages.dart';
import 'package:base_flutter_framework/translations/transaction_key.dart';
import 'package:base_flutter_framework/utils/color.dart';
import 'package:base_flutter_framework/utils/dimens.dart';
import 'package:base_flutter_framework/utils/shared.dart';
import 'package:base_flutter_framework/utils/style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:scroll_navigation/scroll_navigation.dart';
part 'my_id_screen.children.dart';

class MyIdScreen extends GetView<MyIdController> {
  const MyIdScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScanController.cameraController?.dispose();
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: false,
          titleSpacing: 8,
          title: Text(
            TransactionKey.loadLanguage(Get.context!, TransactionKey.myID)
                .toUpperCase(),
            style: TextAppStyle().textToolBar(),
          ),
          actions: [
            Container(
              height: 30,
              width: 30,
              margin: EdgeInsets.only(right: 10),
              child: InkWell(
                onTap: () {
                  Get.toNamed(Routes.SEARCH);
                },
                child: imageFromLocale(
                    url: ResourceIcon.iconSearchAppBar, fit: BoxFit.none),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                  width: Get.width,
                  alignment: Alignment.centerLeft,
                  child: TitleScrollNavigation(
                    barStyle: TitleNavigationBarStyle(
                      activeColor: Theme.of(context).primaryColor,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      padding: EdgeInsets.only(
                          top: 24, bottom: 5, left: 20, right: 20),
                      spaceBetween: 40,
                    ),
                    titles: [
                      TransactionKey.loadLanguage(
                          context, TransactionKey.collection),
                      TransactionKey.loadLanguage(
                          context, TransactionKey.favorite),
                    ],
                    identiferStyle: NavigationIdentiferStyle(
                        // position: IdentifierPosition.topAndRight,
                        color: Theme.of(context).primaryColor),
                    pages: [
                      Obx(() => listCollection(
                          context: context,
                          remoColecction: (resultDetect) async {
                            Shared.getInstance()
                                .collectionCache!
                                .remove(resultDetect);
                            await Shared.getInstance().saveCollection(
                                cacheCollection:
                                    Shared.getInstance().collectionCache!);
                            controller.getListCollection();
                          })),
                      Obx(() => listFavorite(
                          context: context,
                          unlikeClick: (resultDetect) async {
                            Shared.getInstance()
                                .favoriteCache!
                                .remove(resultDetect);
                            await Shared.getInstance().saveFavorite(
                                cacheFavorite:
                                    Shared.getInstance().favoriteCache!);
                            controller.getListFavorite();
                          }))
                    ],
                  )),
            ),
            Shared.getInstance().layout == 2
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      BannerAdsCustom.getInstanceBottomAds(context),
                    ],
                  )
                : SizedBox()
          ],
        ));
  }
}
