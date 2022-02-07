import 'dart:async';

import 'package:base_flutter_framework/app.dart';
import 'package:base_flutter_framework/components/menu/item_menu.dart';
import 'package:base_flutter_framework/components/widget/dialog/change_layout.dart';
import 'package:base_flutter_framework/components/widget/dialog/select_language.dart';
import 'package:base_flutter_framework/components/widget/tool_bar.dart';
import 'package:base_flutter_framework/module/my_id/view/banner_ads.dart';
import 'package:base_flutter_framework/module/scan_image/controller/scan_image_controller.dart';
import 'package:base_flutter_framework/module/search/view/search_screen.dart';
import 'package:base_flutter_framework/module/setting/controller/setting_controller.dart';
import 'package:base_flutter_framework/resource/resource_icon.dart';
import 'package:base_flutter_framework/routes/app_pages.dart';
import 'package:base_flutter_framework/theme/theme_data.dart';
import 'package:base_flutter_framework/translations/transaction_key.dart';
import 'package:base_flutter_framework/utils/constants/colors.dart';
import 'package:base_flutter_framework/utils/dimens.dart';
import 'package:base_flutter_framework/utils/hive_database/hive_database.dart';
import 'package:base_flutter_framework/utils/navigator.dart';
import 'package:base_flutter_framework/utils/shared.dart';
import 'package:base_flutter_framework/utils/style/text_style.dart';
import 'package:dynamic_theme_mode/dynamic_theme_mode.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
part 'setting_screen.children.dart';

class SettingScreen extends GetView<SettingController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        titleSpacing: 8,
        title: Text(
          TransactionKey.loadLanguage(Get.context!, TransactionKey.setting),
          style: TextAppStyle().textToolBar(),
        ),
      ),
      body: Column(
        children: [
          Expanded(child: _listItem(context)),
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
}
