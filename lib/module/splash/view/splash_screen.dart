import 'dart:async';

import 'package:base_flutter_framework/components/widget/image_widget/fcore_image.dart';
import 'package:base_flutter_framework/resource/resource_icon.dart';
import 'package:base_flutter_framework/translations/app_translations.dart';
import 'package:base_flutter_framework/utils/constants/colors.dart';
import 'package:base_flutter_framework/utils/shared.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    Timer(Duration(milliseconds: 500), () async {
      await AppTranslations.load(Locale(Shared.getInstance().localeCode, ""));
    });
    return Container(
      color: AppColor.secondBackgroundColorLight,
      child: Stack(
        children: [
          Center(
            child: FCoreImage(
              ResourceIcon.iconSplash,
              width: width * 0.28,
              color: Theme.of(context).primaryColor,
              fit: BoxFit.fitWidth,
            ),
          ),
          // Align(
          //   alignment: Alignment.bottomCenter,
          //   child: Padding(
          //     padding: const EdgeInsets.all(25),
          //     child: Text.rich(
          //       TextSpan(
          //         text: '${'version'.tr}: ',
          //         style: TextAppStyle().versionTextStyle(),
          //         children: [
          //           TextSpan(
          //             text: '1.0.0',
          //             style: TextAppStyle().versionContentTextStyle(),
          //           ),
          //           // can add more TextSpans here...
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
