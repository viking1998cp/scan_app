import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:base_flutter_framework/translations/transaction_key.dart';
import 'package:base_flutter_framework/utils/dimens.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SKToast {
  static void showToastBottom(
      {required String messager, required BuildContext? context}) {
    Fluttertoast.showToast(
        msg: messager,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black.withOpacity(0.8),
        textColor: Colors.white,
        fontSize: DimensCommon.fontSizeSmall);
  }

  static void success({
    required String title,
    required String message,
    required BuildContext context,
  }) {
    AwesomeDialog(
      context: context,
      useRootNavigator: true,
      animType: AnimType.LEFTSLIDE,
      headerAnimationLoop: false,
      dialogType: DialogType.SUCCES,
      title: title,
      desc: message,
      btnOkText: TransactionKey.loadLanguage(context, TransactionKey.selectOk),
      btnOkOnPress: () {},
      btnOkIcon: Icons.check_circle,
      buttonsTextStyle:
          TextStyle(fontSize: DimensCommon.fontSizeSmall, color: Colors.white),
      // onDissmissCallback: () {}
    ).show();
  }

  static void msg(
      {required String title,
      required String message,
      required String textOk,
      required String textCancel,
      required BuildContext context,
      Function()? okClik}) {
    AwesomeDialog(
      context: context,
      useRootNavigator: true,
      headerAnimationLoop: false,
      btnOkText: textOk,
      btnCancelText: textCancel,
      btnOkColor: Theme.of(context).primaryColor,
      btnCancelColor: Theme.of(context).primaryColor,
      showCloseIcon: true,
      dialogType: DialogType.NO_HEADER,
      title: title,
      desc: message,
      btnOkOnPress: () {
        if (okClik != null) {
          okClik();
        }
      },
      btnCancelOnPress: () {},
      buttonsTextStyle:
          TextStyle(fontSize: DimensCommon.fontSizeSmall, color: Colors.white),
      // btnOkIcon: Icons.close,
    ).show();
  }
}
