import 'package:base_flutter_framework/utils/constants/common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'base/app_binding.dart';
import 'routes/app_pages.dart';
import 'theme/theme_data.dart';
import 'translations/app_translations_delegate.dart';
import 'translations/application.dart';
import 'utils/constants/colors.dart';

class App extends StatelessWidget {
  AppTranslationsDelegate? _newLocaleDelegate =
      AppTranslationsDelegate(newLocale: new Locale('en', 'English'));

  List<String> testDeviceIds = ['C5D0713F5736F038834AFDA184B042A9'];
  @override
  Widget build(BuildContext context) {
    RequestConfiguration configuration =
        RequestConfiguration(testDeviceIds: testDeviceIds);
    MobileAds.instance.initialize();
    MobileAds.instance.updateRequestConfiguration(configuration);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      enableLog: true,
      initialRoute: Routes.SPLASH,
      defaultTransition: Transition.fade,
      getPages: routePages,
      initialBinding: AppBinding(),
      smartManagement: SmartManagement.keepFactory,
      title: APP_NAME,
      // themeMode: ,
      theme: ThemeConfig.lightTheme,
      supportedLocales: application.supportedLocales(),
      localizationsDelegates: [
        _newLocaleDelegate!,
        //provides localised strings
        GlobalMaterialLocalizations.delegate,
        //provides RTL support
        GlobalWidgetsLocalizations.delegate,
        DefaultMaterialLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      builder: EasyLoading.init(builder: (context, widget) {
        return widget!;
      }),
    );
  }
}

void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.threeBounce
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = AppColor.accentColorLight
    ..backgroundColor = AppColor.primaryBackgroundColorLight
    ..indicatorColor = AppColor.primaryColorLight
    ..textColor = AppColor.primaryColorLight
    ..maskColor = AppColor.errorColorLight
    ..userInteractions = false
    ..dismissOnTap = false
    ..animationStyle = EasyLoadingAnimationStyle.scale;
}
