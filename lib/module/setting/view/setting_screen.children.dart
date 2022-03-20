part of 'setting_screen.dart';

extension SettingScreenChildren on SettingScreen {
  Widget _listItem(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: DimensCommon.kPaddingMenu,
            ),
            ItemMenu(
              icon: ResourceIcon.iconChangeLayout,
              onclick: () {
                NavigatorCommon.showDialogCommon(
                    context: context, child: DialogChangeLayout());
              },
              title: TransactionKey.loadLanguage(
                context,
                TransactionKey.changeLayout,
              ),
              subTitle: TransactionKey.loadLanguage(
                context,
                TransactionKey.bottomMenu,
              ),
            ),
            SizedBox(
              height: DimensCommon.kPaddingMedium,
            ),
            ItemMenu(
              icon: ResourceIcon.iconChangeTheme,
              onclick: () async {
                int colorNow = AppColor.primaryColorLight.value;
                await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(
                          TransactionKey.loadLanguage(
                              context, TransactionKey.pickColorTheme),
                          style: TextAppStyle().styleTitle()),
                      content: SingleChildScrollView(
                        child: ColorPicker(
                          pickerColor: Theme.of(context).primaryColor,
                          onColorChanged: (color) async {
                            colorNow = color.value;
                          },
                          pickerAreaHeightPercent: 0.5,
                          enableAlpha: true,
                          displayThumbColor: true,
                          paletteType: PaletteType.hslWithHue,
                          labelTypes: [],
                          pickerAreaBorderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(2),
                              topRight: Radius.circular(2)),
                          hexInputController: TextEditingController(),
                          portraitOnly: true,
                        ),
                      ),
                      actions: <Widget>[
                        ElevatedButton(
                          child: Text(
                              TransactionKey.loadLanguage(
                                  context, TransactionKey.changeTheme),
                              style: TextAppStyle().styleTitle()),
                          onPressed: () {
                            Shared.getInstance()
                                .saveColorPrimary(color: colorNow);
                            AppColor.primaryColorLight = Color(colorNow);
                            Get.changeTheme(ThemeConfig.lightTheme);
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Theme.of(context).primaryColor),
                        ),
                      ],
                    );
                  },
                );
              },
              title: TransactionKey.loadLanguage(
                context,
                TransactionKey.changeTheme,
              ),
            ),
            SizedBox(
              height: DimensCommon.kPaddingMedium,
            ),
            ItemMenu(
              icon: ResourceIcon.iconFeedback,
              onclick: () async {
                await controller.getInfoApp();
                launch('mailto:oreecaa@gmail.com?subject=Report problem&body='
                    'App name: ${controller.appName.value}\n'
                    'Package name: ${controller.packageName.value}\n'
                    'Version: ${controller.version.value}\n'
                    'Build number: ${controller.version.value}\n');
                SKToast.showToastBottom(
                    messager: controller.appName.value, context: context);
              },
              title: TransactionKey.loadLanguage(
                context,
                TransactionKey.feedback,
              ),
            ),
            SizedBox(
              height: DimensCommon.kPaddingMedium,
            ),
            ItemMenu(
              icon: ResourceIcon.iconLanguage,
              onclick: () async {
                await NavigatorCommon.showDialogCommonAwait(
                    barrierDismissible: true,
                    rootNavigator: true,
                    context: context,
                    child: SelectLanguage());
              },
              title: TransactionKey.loadLanguage(
                context,
                TransactionKey.language,
              ),
            ),
            SizedBox(
              height: DimensCommon.kPaddingMedium,
            ),
            ItemMenu(
              icon: ResourceIcon.iconBuyPro,
              onclick: () {
                showBottomSheet(child: DialogBuypro(), context: context);
              },
              title: TransactionKey.loadLanguage(
                context,
                TransactionKey.buyPro,
              ),
            ),
            SizedBox(
              height: DimensCommon.kPaddingMedium,
            ),
            ItemMenu(
              icon: ResourceIcon.iconShare,
              onclick: () {
                Share.share(
                    TransactionKey.loadLanguage(context, TransactionKey.contentRecommendedApp) +
                        (Platform.isAndroid
                            ? "https://play.google.com/store/apps/details?id=${controller.packageName.value}"
                            : "https://apps.apple.com/app/id1614593199"),
                    subject: TransactionKey.loadLanguage(
                        context, TransactionKey.titleRecommendedApp));
              },
              title: TransactionKey.loadLanguage(
                context,
                TransactionKey.share,
              ),
            ),
            SizedBox(
              height: DimensCommon.kPaddingMedium,
            ),
            ItemMenu(
              icon: ResourceIcon.iconRate,
              onclick: () async {
                showDialogRatting(context);
              },
              title: TransactionKey.loadLanguage(
                context,
                TransactionKey.rateUs,
              ),
            ),
            SizedBox(
              height: DimensCommon.kPaddingMedium,
            ),
            ItemMenu(
              icon: ResourceIcon.iconMoreApp,
              onclick: () {
                launch(Platform.isAndroid
                    ? "https://play.google.com/store/apps/developer?id=Gamaa"
                    : "https://apps.apple.com/developer/id1614593199");
              },
              title: TransactionKey.loadLanguage(
                context,
                TransactionKey.moreApp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> showDialogRatting(BuildContext context) async {
    NavigatorCommon.showDialogCommon(
      context: context,
      rootNavigator: true,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          alignment: Alignment.center,
          child: Obx(() => Container(
                width: 315,
                height: controller.ratingIndex.value == 0.0 ? 200 : 230,
                padding: EdgeInsets.symmetric(horizontal: 8),
                color: Colors.white,
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.yellow.shade600,
                              size: 24,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              TransactionKey.loadLanguage(
                                  context, TransactionKey.rateYourExperience),
                              style: TextAppStyle().styleTextTag(),
                            ),
                          ],
                        ),
                        IconButton(
                            onPressed: () {
                              Get.back();
                              controller.ratingIndex.value = 0.0;
                            },
                            icon: Icon(
                              Icons.close_sharp,
                              color: Colors.brown,
                              size: 20,
                            ))
                      ],
                    ),
                    Container(
                      child: Obx(() {
                        return Column(
                          children: [
                            Text(
                              TransactionKey.loadLanguage(
                                  context, TransactionKey.titleRate),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            RatingBar.builder(
                              initialRating: 0,
                              minRating: 1,
                              itemSize: 35,
                              direction: Axis.horizontal,
                              // allowHalfRating: true,
                              itemCount: 5,
                              itemPadding:
                                  EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => Column(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                  ),
                                ],
                              ),
                              onRatingUpdate: (rating) {
                                controller.ratingIndex.value = rating;
                              },
                            ),
                            controller.ratingIndex.value == 0.0
                                ? Container()
                                : controller.ratingIndex.value != 0.0 &&
                                        controller.ratingIndex.value <= 3.0
                                    ? InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                          Timer(Duration(milliseconds: 100),
                                              () {
                                            dialogSendRatingReview(context);
                                          });
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(top: 10),
                                          child: Text(
                                            TransactionKey.loadLanguage(context,
                                                TransactionKey.thankRatting),
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      )
                                    : InkWell(
                                        onTap: () {
                                          Get.back();
                                          controller.ratingIndex.value = 0.0;
                                          if (Platform.isAndroid) {
                                            launch("https://play.google.com/store/apps/details?id=${controller.packageName.value}");
                                          } else {
                                            launch("https://apps.apple.com/app/id1614593199");
                                          }
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(top: 8),
                                          child: Text(
                                            TransactionKey.loadLanguage(context,
                                                TransactionKey.rateInStore),
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                          ],
                        );
                      }),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }

  Future<void> dialogSendRatingReview(BuildContext context) async {
    NavigatorCommon.showDialogCommon(
      context: context,
      rootNavigator: true,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          alignment: Alignment.center,
          child: Container(
            width: 300,
            height: 105,
            padding: EdgeInsets.symmetric(horizontal: 8),
            color: Colors.white,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellow.shade600,
                          size: 24,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          TransactionKey.loadLanguage(
                              context, TransactionKey.rateYourExperience),
                          style: TextAppStyle().styleTextTag(),
                        ),
                      ],
                    ),
                    IconButton(
                        onPressed: () {
                          Get.back();
                          controller.ratingIndex.value = 0.0;
                        },
                        icon: Icon(
                          Icons.close_sharp,
                          color: Colors.brown,
                          size: 20,
                        ))
                  ],
                ),
                Container(
                    child: Column(
                  children: [
                    Text(
                      TransactionKey.loadLanguage(
                          context, TransactionKey.letMeKnow),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            TransactionKey.loadLanguage(
                                    context, TransactionKey.selectCancel)
                                .toUpperCase(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            launch('mailto:oreecaa@gmail.com');
                          },
                          child: Text(
                            TransactionKey.loadLanguage(
                                    Get.context!, TransactionKey.selectOk)
                                .toUpperCase(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                  ],
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> showBottomSheet(
      {required Widget child, required BuildContext context}) async {
    await showModalBottomSheet<dynamic>(
        useRootNavigator: true,
        isScrollControlled: true,
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        builder: (BuildContext bc) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [child],
          );
        });
  }
}
