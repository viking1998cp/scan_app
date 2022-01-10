import 'package:flutter/material.dart';

Widget buttonNoIcon(
    {required String title,
    required Color colorBackground,
    required Color textColor,
    required Function onclick,
    required EdgeInsets padding,
    MaterialStateProperty<EdgeInsets>? paddingButton,
    double? fontSizeTitle,
    double? radius,
    bool? textBold,
    EdgeInsets? margin,
    Border? border}) {
  if (margin == null) {
    margin = EdgeInsets.all(0);
  }
  return Container(
    margin: margin,
    child: TextButton(
      onPressed: () {
        onclick();
      },
      style: ButtonStyle(padding: paddingButton ?? null),
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius ?? 5),
              color: colorBackground,
              border: border),
          padding: padding,
          child: Center(
            child: Text(title,
                style: TextStyle(
                    color: textColor,
                    fontWeight: textBold != null && textBold
                        ? FontWeight.bold
                        : FontWeight.normal,
                    fontSize: fontSizeTitle == null ? 16 : fontSizeTitle)),
          )),
    ),
  );
}
