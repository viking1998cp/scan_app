// import 'package:base_flutter_framework/screens/menu/menu_main/menu_page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

//router page common
class NavigatorCommon {
  static bool isshowingDialog = false;

  //
  static void navigatorLeftToRight(
      {required BuildContext context, required StatefulWidget goto}) {
    Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.fade,
            child: goto,
            duration: Duration(milliseconds: 300)));
  }

  static void navigatorRightToLeft(
      {required BuildContext context, required StatefulWidget goto}) {
    Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.fade,
            child: goto,
            curve: Curves.fastLinearToSlowEaseIn,
            duration: Duration(milliseconds: 300)));
  }

  static Future<void> navigatorLeftToRightAsyn(
      {required BuildContext context, required StatefulWidget goto}) async {
    await Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.fade,
            child: goto,
            curve: Curves.fastLinearToSlowEaseIn,
            duration: Duration(milliseconds: 300)));
  }

  static dynamic navigatorLeftToRightReturn(
      {required BuildContext context, required StatefulWidget goto}) async {
    return await Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.fade,
            child: goto,
            duration: Duration(milliseconds: 300)));
  }

  static dynamic popSendData({required BuildContext context, dynamic data}) {
    Navigator.pop(context, data);
  }

  static void navigatorRemoveUntil(
      {required BuildContext context, required StatefulWidget goto}) {
    Navigator.pushAndRemoveUntil(
        context,
        PageTransition(type: PageTransitionType.fade, child: goto),
        (Route<dynamic> route) => false);
  }

  static void popNavigator({required BuildContext context}) {
    Navigator.of(context).pop();
  }

  // static void navigationHomePage(
  //     {required BuildContext context, int? indexPage}) {
  //   navigatorRemoveUntil(
  //       context: context,
  //       goto: MenuHome(
  //         index: indexPage ?? 2,
  //       ));
  // }

  static void showDialogCommon(
      {required BuildContext context,
      required Widget child,
      bool? rootNavigator,
      bool? barrierDismissible}) async {
    isshowingDialog = true;
    await showDialog(
        context: context,
        useRootNavigator: rootNavigator ?? false,
        barrierDismissible:
            barrierDismissible == null ? false : barrierDismissible,
        builder: (context) {
          return child;
        });
    isshowingDialog = false;
  }

  static Future<void> showDialogCommonAwait({
    required BuildContext context,
    required Widget child,
    bool? rootNavigator,
    bool? barrierDismissible,
  }) async {
    isshowingDialog = true;
    await showDialog(
        context: context,
        useRootNavigator: rootNavigator ?? false,
        barrierDismissible:
            barrierDismissible == null ? false : barrierDismissible,
        builder: (context) {
          return child;
        });
    isshowingDialog = false;
  }
}
