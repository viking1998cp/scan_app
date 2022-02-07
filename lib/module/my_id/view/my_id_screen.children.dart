part of 'my_id_screen.dart';

extension MyIdScreenChildren on MyIdScreen {
  Widget listFavorite(
      {required Function(ResultDetect resultDetect) unlikeClick,
      required BuildContext context}) {
    return controller.favoriteList.value.isEmpty
        ? emptyData(context)
        : LoadMoreGridView(
            listFullData: controller.favoriteList.value,
            onLoading: () {},
            loading: false,
            itembuilder: (context, index) {
              return ItemCache(
                  resultDetect: controller.favoriteList.value[index],
                  unLikeClick: () async {
                    unlikeClick(controller.favoriteList.value[index]);
                    NaturalWorldController controllerWorld = Get.find();
                    controllerWorld.upDateLikeData(
                        controllerWorld.listItemResult
                            .indexOf(controller.favoriteList[index]),
                        false);
                  },
                  mode: 2);
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
                      .favoriteList.value[index].contentUrls!.mobile!.page!,
                  name: controller.favoriteList.value[index].displaytitle!));
            },
            limit: true,
            childAspectRatio: (Get.width / 2) / 180,
            crossAxisCount: 2);
  }

  Widget listCollection(
      {required Function(ResultDetect resultDetect) remoColecction,
      required BuildContext context}) {
    return controller.collectionList.value.isEmpty
        ? emptyData(context)
        : LoadMoreGridView(
            listFullData: controller.collectionList.value,
            onLoading: () {},
            loading: false,
            itembuilder: (context, index) {
              return ItemCache(
                  resultDetect: controller.collectionList.value[index],
                  remoClick: () {
                    remoColecction(controller.collectionList.value[index]);
                  },
                  mode: 1);
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
                      .collectionList.value[index].contentUrls!.mobile!.page!,
                  name: controller.collectionList.value[index].displaytitle!));
            },
            limit: true,
            childAspectRatio: (Get.width / 2) / 180,
            crossAxisCount: 2);
  }

  Widget emptyData(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          child: Container(
            width: 173,
            alignment: Alignment.center,
            child: buttonNoIcon(
                title: TransactionKey.loadLanguage(
                        context, TransactionKey.takePhoto)
                    .toUpperCase(),
                colorBackground: Theme.of(context).primaryColor,
                textColor: Colors.white,
                onclick: () async {
                  if (await Permission.camera.request().isGranted) {
                    await Get.toNamed(Routes.SCAN, arguments: {"from": "myId"});
                    controller.getListCollection();
                  }
                },
                radius: 10,
                fontSizeTitle: 12,
                textBold: true,
                padding: EdgeInsets.symmetric(vertical: 12)),
          ),
        ),
        SizedBox(
          height: 25,
        ),
        Container(height: 300, child: BannerAdsCustom.getInstanceBigAds())
      ],
    );
  }
}
