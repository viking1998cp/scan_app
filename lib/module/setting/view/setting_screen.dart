import 'package:base_flutter_framework/app.dart';
import 'package:base_flutter_framework/components/menu/item_menu.dart';
import 'package:base_flutter_framework/components/widget/dialog/change_layout.dart';
import 'package:base_flutter_framework/components/widget/tool_bar.dart';
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
import 'package:dynamic_theme_mode/dynamic_theme_mode.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
part 'setting_screen.children.dart';

class SettingScreen extends GetView<SettingController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ToolBarCommon(
            onclick: () {
              Navigator.pop(context);
              // Get.to(SearchScreen());
            },
            showPopButton: Shared.getInstance().layout == 2 ? true : false,
            onTapSearch: () {
              Get.to(SearchScreen());
            },
            title: TransactionKey.loadLanguage(context, TransactionKey.setting),
          ),
          _listItem(context)
        ],
      ),
    );
  }
}
