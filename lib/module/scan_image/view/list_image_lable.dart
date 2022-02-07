import 'dart:io';

import 'package:base_flutter_framework/components/widget/button_no_icon.dart';
import 'package:base_flutter_framework/components/widget/circle_icon.dart';
import 'package:base_flutter_framework/components/widget/dialog/input_match_name.dart';
import 'package:base_flutter_framework/components/widget/image.dart';
import 'package:base_flutter_framework/components/widget/indicator.dart';
import 'package:base_flutter_framework/core/models/result_detect.dart';
import 'package:base_flutter_framework/module/my_id/view/banner_ads.dart';
import 'package:base_flutter_framework/module/scan_image/controller/scan_image_controller.dart';
import 'package:base_flutter_framework/module/scan_image/view/web_view.dart';
import 'package:base_flutter_framework/translations/transaction_key.dart';
import 'package:base_flutter_framework/utils/dimens.dart';
import 'package:base_flutter_framework/utils/navigator.dart';
import 'package:base_flutter_framework/utils/shared.dart';
import 'package:base_flutter_framework/utils/string.dart';
import 'package:base_flutter_framework/utils/style/text_style.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';

class ListDetectScreen extends GetView<ScanController> {
  File? file;
  int indexSelect = 0;
  Widget banner(File file, BuildContext context) {
    return Obx(() => Container(
        height: controller.dataDetect.isEmpty
            ? Get.height
            : controller.dataDetect[0].title == 'Not found'
                ? Get.height
                : 250,
        alignment: Alignment.topRight,
        decoration: BoxDecoration(
            image: DecorationImage(image: FileImage(file), fit: BoxFit.fill)),
        child: SizedBox()));
  }

  Widget listResult(List<ResultDetect> datas, BuildContext context) {
    if (datas.length == 1 && datas[0].title == 'Not found') {
      return itemError(context);
    }
    return Container(
      height: Shared.getInstance().layout == 2
          ? DimensCommon.sizeHeight(context: context) - 90
          : DimensCommon.sizeHeight(context: context),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios)),
              Expanded(child: SizedBox()),
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close)),
            ],
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(bottom: 20),
              child: CarouselSlider.builder(
                itemCount: datas.length,
                itemBuilder:
                    (BuildContext context, int itemIndex, int pageViewIndex) =>
                        itemResult(datas[itemIndex], itemIndex, context),
                options: CarouselOptions(
                  autoPlay: false,
                  enableInfiniteScroll: true,
                  enlargeCenterPage: false,
                  onPageChanged: (index, car) {
                    indexSelect = index;
                  },
                  viewportFraction: 0.8,
                  aspectRatio: Get.width / 220,
                  // aspectRatio: ,
                  initialPage: 0,
                ),
              ),
            ),
          ),
          Container(
            height: 50,
            width: 140,
            margin: EdgeInsets.only(bottom: 80),
            child: buttonNoIcon(
                title:
                    TransactionKey.loadLanguage(context, TransactionKey.match)
                        .toUpperCase(),
                colorBackground: Theme.of(context).primaryColor,
                textColor: Colors.white,
                onclick: () async {
                  NavigatorCommon.showDialogCommon(
                      context: context,
                      child: InputMatchNameDialog(
                        hintText: datas[indexSelect].title!,
                        okClick: (text) async {
                          ResultDetect resultDetect = datas[indexSelect].copy();
                          resultDetect.title = text[0];
                          Shared.getInstance()
                              .collectionCache!
                              .add(resultDetect);
                          await Shared.getInstance().saveCollection(
                              cacheCollection:
                                  Shared.getInstance().collectionCache!);
                        },
                      ));
                },
                padding: EdgeInsets.symmetric()),
          )
        ],
      ),
    );
  }

  Widget itemError(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios)),
                Expanded(child: SizedBox()),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close)),
              ],
            ),
            Container(
                height: Get.height - 150,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search,
                      size: 40,
                    ),
                    Text(
                        TransactionKey.loadLanguage(
                            context, TransactionKey.notFound),
                        style: TextAppStyle().textToolBar())
                  ],
                ))
          ],
        ),
      ),
    );
  }

  Widget itemResult(
      ResultDetect resultDetect, int index, BuildContext context) {
    return Container(
      height: 300,
      width: 280,
      margin: EdgeInsets.symmetric(horizontal: 10),
      alignment: Alignment.centerLeft,
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          Container(
            // height: 250,
            margin: EdgeInsets.only(top: 30),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 85, right: 16),
                  padding: EdgeInsets.only(top: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          resultDetect.title!,
                          style: TextAppStyle()
                              .styleTextNameDetect(resultDetect.title!),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            TransactionKey.loadLanguage(
                                    context, TransactionKey.score) +
                                ": ",
                            style: TextAppStyle().styleTitle(),
                          ),
                          Text(
                            resultDetect.point!.toStringAsFixed(2),
                            style: TextAppStyle().styleTextScore(context),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  height: 80,
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Html(
                    data:
                        """<div style="height: 70px;text-overflow: ellipsis;overflow: hidden;white-space: nowrap;">""" +
                            resultDetect.extractHtml! +
                            """</div> """,
                  ),
                ),
                buttonNoIcon(
                    title: TransactionKey.loadLanguage(
                        context, TransactionKey.more),
                    colorBackground: Colors.blue,
                    textColor: Colors.white,
                    onclick: () {
                      Get.to(WebviewResult(
                          url: resultDetect.contentUrls!.mobile!.page!,
                          name: StringCommon.formatHtml(
                              resultDetect.displaytitle!)));
                    },
                    padding: EdgeInsets.symmetric(vertical: 10))
              ],
            ),
          ),
          Container(
            height: 70,
            margin: EdgeInsets.only(right: 185, bottom: 20),
            alignment: Alignment.centerLeft,
            child: circleAvatar(
                radius: 70,
                child: imageFromNetWork(
                    url: resultDetect.originalimage == null
                        ? StringCommon.defaultImage
                        : resultDetect.originalimage!.source!,
                    width: 70,
                    height: 70)),
          ),
        ],
      ),
    );
  }

  Widget progressBar(int point) {
    return Container(
        height: 25,
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Container(
              height: 10,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Theme.of(Get.context!).primaryColor,
                        borderRadius: BorderRadius.circular(20)),
                    width: 164 * (point / 100),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  )
                ],
              ),
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      left: (point < 10
                          ? point.toDouble()
                          : (164 * (point / 100) - 10))),
                  child: circleAvatar(
                      backgroundColor: Theme.of(Get.context!).primaryColor,
                      child: Container(
                        margin: EdgeInsets.all(5),
                        child: Text(
                          point.toString(),
                          style: TextAppStyle().textTitleStyleWhite(),
                        ),
                      )),
                ),
                Expanded(child: SizedBox())
              ],
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    if (file == null) {
      file = Get.arguments[0];
    }

    return SafeArea(
      bottom: true,
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              banner(file!, context),
              Obx(() => Column(
                    children: [
                      Container(
                          child: controller.dataDetect.isEmpty
                              ? Container(
                                  height: (Get.height / 2) + 200,
                                  child: indicator())
                              : listResult(controller.dataDetect, context)),
                      Shared.getInstance().layout == 2
                          ? Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  BannerAdsCustom.getInstanceBottomAds(context),
                                ],
                              ),
                            )
                          : SizedBox()
                    ],
                  ))
            ],
          )),
    );
  }
}
