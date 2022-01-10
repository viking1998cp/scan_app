import 'package:base_flutter_framework/module/scan_image/view/web_view.dart';
import 'package:base_flutter_framework/module/search/controller/search_controller.dart';
import 'package:base_flutter_framework/resource/resource_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class SearchScreen extends GetView<SearchController> {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<SearchController>(() => SearchController());

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
            onChanged: (value) {
              controller.textSearchController.text = value;
              controller.searchData(
                  textSearch: controller.textSearchController.text);
            },
            onSubmitted: (value) {},
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
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container(
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
                      await controller.searchDataDetail(
                          textName: "${item.title}");

                      Get.to(WebviewResult(
                          url: controller.url.value,
                          name: controller.name.value));
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                      child: Card(
                        child: ListTile(
                          title: Text('${item.title}'),
                          subtitle: Text(
                            '${item.snippet!.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ' ')}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                  );
                })
            : Container(
                child: Center(
                  child: Column(
                    children: [
                      Image.asset("assets/images/image_home.png"),
                      // Text('Enter to search...'),
                    ],
                  ),
                ),
              );
      }),
    );
  }
}
