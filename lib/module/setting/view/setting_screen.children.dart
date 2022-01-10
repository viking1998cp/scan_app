part of 'setting_screen.dart';

extension SettingScreenChildren on SettingScreen {
  Widget _listItem(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
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
                    title: const Text('Pick a color theme!'),
                    content: SingleChildScrollView(
                      child: ColorPicker(
                        pickerColor: Theme.of(context).primaryColor,
                        onColorChanged: (color) async {
                          colorNow = color.value;
                        },
                      ),
                    ),
                    actions: <Widget>[
                      ElevatedButton(
                        child: const Text('Change'),
                        onPressed: () {
                          // Shared.getInstance()
                          //     .saveColorPrimary(color: colorNow);
                          AppColor.primaryColorLight = Color(colorNow);
                          Get.changeTheme(ThemeConfig.lightTheme);
                          Navigator.pop(context);
                        },
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
              launch(
                  'mailto:abc@gmail.com?subject=Report problem&body='
                      'App name: ${controller.appName.value}\n'
                      'Package name: ${controller.packageName.value}\n'
                      'Version: ${controller.version.value}\n'
                      'Build number: ${controller.version.value}\n');
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
            onclick: () {},
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
            onclick: () {},
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
            onclick: () {},
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
            onclick: () {},
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
            onclick: () {},
            title: TransactionKey.loadLanguage(
              context,
              TransactionKey.moreApp,
            ),
          ),
        ],
      ),
    );
  }
}
