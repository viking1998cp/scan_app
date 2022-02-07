import 'package:base_flutter_framework/components/widget/favorite_button.dart';
import 'package:base_flutter_framework/components/widget/indicator.dart';
import 'package:base_flutter_framework/core/models/result_detect.dart';
import 'package:base_flutter_framework/module/my_id/view/banner_ads.dart';
import 'package:base_flutter_framework/module/scan_image/view/web_view.dart';
import 'package:base_flutter_framework/module/search/controller/search_controller.dart';
import 'package:base_flutter_framework/resource/resource_icon.dart';
import 'package:base_flutter_framework/services/service.dart';
import 'package:base_flutter_framework/utils/shared.dart';
import 'package:base_flutter_framework/utils/string.dart';
import 'package:base_flutter_framework/utils/style/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:loader_overlay/loader_overlay.dart';
part 'search_screen.children.dart';

class SearchScreen extends GetView<SearchController> {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: TextField(
            style: Theme.of(context).textTheme.bodyText2,
            textInputAction: TextInputAction.search,
            // controller: controller.textSearchController,
            maxLines: 1,
            onChanged: (value) {},
            onSubmitted: (value) {
              controller.textSearchController.text = value;
              controller.searchData(
                  textSearch: controller.textSearchController.text,
                  context: context);
              controller.setLoading(true);
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(top: 8),
              hintText: 'Search...',
              border: InputBorder.none,
              prefixIcon: Icon(Icons.search),
              suffixIcon: IconButton(
                onPressed: () {
                  controller.textSearchController.clear();
                },
                icon: Icon(
                  CupertinoIcons.clear_thick_circled,
                  color: const Color(0xFF8C8C8C),
                  size: 18,
                ),
              ),
            ),
          ),
        ),
        // actions: [
        //   IconButton(
        //       icon: Icon(CupertinoIcons.search),
        //       onPressed: () {
        //         controller.searchData(
        //             textSearch: controller.textSearchController.text);
        //       }),
        // ],
      ),
      body: Column(
        children: [
          _buildBody(),
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

  Widget _buildBody() {
    return Expanded(
      child: Obx(() {
        return controller.dataSearch.length != 0
            ? ListView.builder(
                physics: AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.dataSearch.length,
                itemBuilder: (ctx, index) {
                  var item = controller.dataSearch[index];
                  return InkWell(
                    onTap: () async {
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
                          url: item.contentUrls!.mobile!.page!,
                          name: item.displaytitle!));
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                      child: itemSearch(item, (index, nice) {}),
                    ),
                  );
                })
            : !controller.loading.value
                ? Container(
                    child: Center(child: emptyData(Get.context!)),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      indicator(),
                      // Text('Enter to search...'),
                    ],
                  );
      }),
    );
  }
}
