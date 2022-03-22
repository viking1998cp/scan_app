import 'package:base_flutter_framework/components/widget/favorite_button.dart';
import 'package:base_flutter_framework/components/widget/image.dart';
import 'package:base_flutter_framework/components/widget/load_more/load_more_grid_view.dart';
import 'package:base_flutter_framework/core/models/result_detect.dart';
import 'package:base_flutter_framework/module/my_id/view/banner_ads.dart';
import 'package:base_flutter_framework/module/natural_world/controller/natural_world_controller.dart';
import 'package:base_flutter_framework/module/scan_image/view/web_view.dart';
import 'package:base_flutter_framework/resource/resource_icon.dart';
import 'package:base_flutter_framework/routes/app_pages.dart';
import 'package:base_flutter_framework/translations/transaction_key.dart';
import 'package:base_flutter_framework/utils/constants/colors.dart';
import 'package:base_flutter_framework/utils/shared.dart';
import 'package:base_flutter_framework/utils/string.dart';
import 'package:base_flutter_framework/utils/style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

part 'natural_world_screen.children.dart';

class NaturalWorldScreen extends GetView<NaturalWorldController> {
  const NaturalWorldScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        titleSpacing: 8,
        title: Text(
          TransactionKey.loadLanguage(
              Get.context!, TransactionKey.naturalWorld),
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
      body: Obx(() => Container(
            child: Column(
              children: [
                Expanded(
                  child: LoadMoreGridView(
                      listFullData: controller.listItemResult.value,
                      onLoading: () {
                        controller.getData();
                      },
                      loading: controller.loading.value,
                      itembuilder: (context, index) {
                        return itemImage(
                            context: context,
                            resultDetect: controller.getDataImage()[index],
                            nice: (index, like) {
                              controller.upDateLikeData(index, like);
                            });
                      },
                      onclickItem: (index) async {
                        if (controller.showAds.value < 4) {
                          if (controller.showAds.value == 1) {
                            controller.createInterstitialAd();
                          }
                          controller.setShowAds(controller.showAds.value + 1);
                        } else {
                          controller.interstitialAd?.show();
                          controller.setShowAds(1);
                        }
                        await Get.to(WebviewResult(
                            url: controller
                                .getDataImage()[index]
                                .contentUrls!
                                .mobile!
                                .page!,
                            name: controller
                                .getDataImage()[index]
                                .displaytitle!));
                      },
                      limit: controller.limit.value,
                      childAspectRatio: (Get.width / 2) / 180,
                      crossAxisCount: 2),
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
            ),
          )),
    );
  }
}
