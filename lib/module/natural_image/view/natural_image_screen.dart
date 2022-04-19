import 'package:base_flutter_framework/components/widget/image.dart';
import 'package:base_flutter_framework/components/widget/load_more/load_more_grid_view.dart';
import 'package:base_flutter_framework/module/my_id/view/banner_ads.dart';
import 'package:base_flutter_framework/module/natural_image/controller/natural_image_controller.dart';
import 'package:base_flutter_framework/module/natural_image/view/natural_image_detail.dart';
import 'package:base_flutter_framework/module/scan_image/controller/scan_image_controller.dart';
import 'package:base_flutter_framework/resource/resource_icon.dart';
import 'package:base_flutter_framework/translations/transaction_key.dart';
import 'package:base_flutter_framework/utils/constants/colors.dart';
import 'package:base_flutter_framework/utils/shared.dart';
import 'package:base_flutter_framework/utils/style/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NaturalImageScreen extends GetView<NaturalImageController> {
  const NaturalImageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScanController.cameraController?.dispose();
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        titleSpacing: 8,
        title: Text(
          TransactionKey.loadLanguage(
              Get.context!, TransactionKey.naturalImage),
          style: TextAppStyle().textToolBar(),
        ),
        actions: [
          Obx(() {
            return InkWell(
              onTap: () {
                _showContent(context);
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Image.asset(
                  controller.currentIndex.value == 0
                      ? ResourceIcon.iconPlant
                      : controller.currentIndex.value == 1
                          ? ResourceIcon.iconPet
                          : controller.currentIndex.value == 2
                              ? ResourceIcon.iconMushroom
                              : ResourceIcon.iconBird,
                  color: Colors.white,
                  width: 24,
                  height: 24,
                ),
              ),
            );
          })
        ],
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6),
      child: Column(
        children: [
          Expanded(
            child: Obx(() {
              return LoadMoreGridView(
                  listFullData: controller.wallpaperIdsLoad.value,
                  onLoading: () {
                    controller.loadData();
                  },
                  loading: controller.loading.value,
                  itembuilder: (context, index) {
                    dynamic id = controller.wallpaperIdsLoad.value[index].id;
                    return Container(
                      margin: EdgeInsets.only(top: 6, left: 3, right: 3),
                      child: Card(
                          elevation: 10,
                          child: imageFromNetWork(
                              url: "http://i.7fon.org/300/$id.jpg",
                              width: null,
                              height: null,
                              fill: true)),
                    );
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
                    Get.to(ImageDetailScreen(
                      indexPage: index,
                    ));
                  },
                  limit: controller.limit.value,
                  childAspectRatio: (Get.width / 2) / 180,
                  crossAxisCount: 2);
            }),
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
    );
  }

  void _showContent(BuildContext context) {
    showDialog(
      context: context, barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return Obx(() {
          return new AlertDialog(
            content: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: () {
                        controller.isActive0!.value = true;
                        controller.isActive1!.value = false;
                        controller.isActive2!.value = false;
                        controller.isActive3!.value = false;
                      },
                      child: Image.asset(
                        ResourceIcon.iconPlant,
                        color: controller.isActive0!.value == true
                            ? Colors.blue
                            : AppColor.gray2,
                        width: 24,
                        height: 24,
                      )),
                  InkWell(
                      onTap: () {
                        controller.isActive0!.value = false;
                        controller.isActive1!.value = true;
                        controller.isActive2!.value = false;
                        controller.isActive3!.value = false;
                      },
                      child: Image.asset(
                        ResourceIcon.iconPet,
                        color: controller.isActive1!.value == true
                            ? Colors.blue
                            : AppColor.gray2,
                        width: 24,
                        height: 24,
                      )),
                  InkWell(
                      onTap: () {
                        controller.isActive0!.value = false;
                        controller.isActive1!.value = false;
                        controller.isActive2!.value = true;
                        controller.isActive3!.value = false;
                      },
                      child: Image.asset(
                        ResourceIcon.iconMushroom,
                        color: controller.isActive2!.value == true
                            ? Colors.blue
                            : AppColor.gray2,
                        width: 24,
                        height: 24,
                      )),
                  InkWell(
                      onTap: () {
                        controller.isActive0!.value = false;
                        controller.isActive1!.value = false;
                        controller.isActive2!.value = false;
                        controller.isActive3!.value = true;
                      },
                      child: Image.asset(
                        ResourceIcon.iconBird,
                        color: controller.isActive3!.value == true
                            ? Colors.blue
                            : AppColor.gray2,
                        width: 24,
                        height: 24,
                      )),
                ],
              ),
            ),
            actions: [
              new FlatButton(
                child: new Text('Ok'),
                onPressed: () {
                  controller.reloadData(controller.isActive0!.value == true
                      ? "plant"
                      : controller.isActive1!.value == true
                          ? "dog"
                          : controller.isActive3!.value == true
                              ? "bird"
                              : "mushroom");
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
      },
    );
  }
}
