import 'package:base_flutter_framework/components/widget/favorite_button.dart';
import 'package:base_flutter_framework/components/widget/image.dart';
import 'package:base_flutter_framework/components/widget/load_more/load_more_grid_view.dart';
import 'package:base_flutter_framework/core/models/result_detect.dart';
import 'package:base_flutter_framework/icons/app_icons.dart';
import 'package:base_flutter_framework/module/natural_world/controller/natural_world_controller.dart';
import 'package:base_flutter_framework/module/scan_image/view/web_view.dart';
import 'package:base_flutter_framework/resource/resource_icon.dart';
import 'package:base_flutter_framework/services/service.dart';
import 'package:base_flutter_framework/translations/transaction_key.dart';
import 'package:base_flutter_framework/utils/constants/colors.dart';
import 'package:base_flutter_framework/utils/shared.dart';
import 'package:base_flutter_framework/utils/string.dart';
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
        title: Text(
          TransactionKey.loadLanguage(
              Get.context!, TransactionKey.naturalWorld),
        ),
        // actions: [
        //   InkWell(
        //     onTap: () {
        //       _showContent(context);
        //     },
        //     child: Padding(
        //       padding: const EdgeInsets.only(right: 20),
        //       child: Image.asset(
        //         ResourceIcon.iconBird,
        //         color: Colors.white,
        //         width: 24,
        //         height: 24,
        //       ),
        //     ),
        //   )
        // ],
      ),
      body: Obx(() => Container(
            child: LoadMoreGridView(
                listFullData: controller.getDataImage(),
                onLoading: () {
                  controller.getData();
                },
                loading: controller.loading.value,
                itembuilder: (context, index) {
                  return itemImage(
                      resultDetect: controller.getDataImage()[index]);
                },
                onclickItem: (index) {
                  if (controller.showAds.value < 4) {
                    if (controller.showAds.value == 1) {
                      controller.createInterstitialAd();
                    }
                    controller.setShowAds(controller.showAds.value + 1);
                  } else {
                    controller.interstitialAd?.show();
                    controller.setShowAds(1);
                  }
                  Get.to(WebviewResult(
                      url: controller
                          .getDataImage()[index]
                          .contentUrls!
                          .mobile!
                          .page!,
                      name: controller.getDataImage()[index].displaytitle!));
                },
                limit: controller.limit.value,
                childAspectRatio: (Get.width / 2) / 180,
                crossAxisCount: 2),
          )),
    );
  }
}
